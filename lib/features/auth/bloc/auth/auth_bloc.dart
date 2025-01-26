import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import '../../service/service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum _EBlocError {
  email,
  username,
  password,
}

EventTransformer<E> throttle<E>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).flatMap(mapper);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const waitTime = 60;
  final Talker loger;
  final AuthEmailService authEmailService;
  final AuthGoogleService authGoogleService;
  final AuthValidationService validationService;
  final TimerService restoreTimer;
  final TimerService registerTimer;

  final Map<_EBlocError, String> _errors = <_EBlocError, String>{};

  AuthBloc({
    required this.authEmailService,
    required this.authGoogleService,
    required this.validationService,
    required this.restoreTimer,
    required this.registerTimer,
    required this.loger,
  }) : super(AuthInitial()) {
    on<AuthUsernameValidate>(_usernameValidate);
    on<AuthEmailValidate>(_emailValidate);
    on<AuthPasswordValidate>(_passwordValidate);

    on<AuthLogin>(
      _login,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
    on<AuthRegister>(
      _register,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
    on<AuthRestore>(
      _sendRestorePasswordEmail,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
    on<AuthSendRegisterEmail>(
      _sendVerificationEmail,
      transformer: throttle(const Duration(milliseconds: 500)),
    );

    on<AuthRoute>(_routing);
    on<AuthGoogleSingIn>(
      _googleLogin,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
  }

  FutureOr<void> _usernameValidate(
      AuthUsernameValidate event, Emitter<AuthState> emit) {
    final errorMessage = validationService.usernameValidate(event.value);
    _setError(_EBlocError.username, errorMessage?.name);
    _emitFail(emit);
  }

  FutureOr<void> _emailValidate(
      AuthEmailValidate event, Emitter<AuthState> emit) {
    final errorMessage = validationService.emailValidate(event.value);
    _setError(_EBlocError.email, errorMessage?.name);
    _emitFail(emit);
  }

  FutureOr<void> _passwordValidate(
      AuthPasswordValidate event, Emitter<AuthState> emit) {
    final errorMessage = validationService.passwordValidate(event.value);
    _setError(_EBlocError.password, errorMessage?.name);
    _emitFail(emit);
  }

  FutureOr<void> _routing(AuthRoute event, Emitter<AuthState> emit) {
    _errors.clear();
    emit(AuthClearFail());
  }

  FutureOr<void> _login(AuthLogin event, Emitter<AuthState> emit) async {
    final errorEmail = validationService.emailValidate(event.email);
    final errorPassword = validationService.passwordValidate(event.password);

    _setError(_EBlocError.email, errorEmail?.name);
    _setError(_EBlocError.password, errorPassword?.name);

    if (_errors.isNotEmpty) {
      _emitFail(emit);
      return;
    }

    emit(AuthLoading());

    final result =
        await authEmailService.loginWithEmail(event.email, event.password);

    result.isSuccess ? emit(AuthLoginSuccess()) : _throwFail(result, emit);
  }

  FutureOr<void> _register(AuthRegister event, Emitter<AuthState> emit) async {
    if (registerTimer.isRunning) return;

    final errorUsername = validationService.usernameValidate(event.username);
    final errorEmail = validationService.emailValidate(event.email);
    final errorPassword = validationService.passwordValidate(event.password);

    _setError(_EBlocError.username, errorUsername?.name);
    _setError(_EBlocError.email, errorEmail?.name);
    _setError(_EBlocError.password, errorPassword?.name);

    if (_errors.isNotEmpty) {
      _emitFail(emit);
      return;
    }

    emit(AuthLoading());

    final result = await authEmailService.registerWithEmail(
      event.username,
      event.email,
      event.password,
    );

    if (!result.isSuccess) {
      _throwFail(result, emit);
      return;
    }

    emit(AuthRegisterSuccess());

    try {
      await registerTimer.wait(waitTime);
      final isVerify = await _waitEmailVerification();
      if (isVerify) emit(AuthEmailVerifiedSuccess());
    } catch (e) {
      loger.error(e);
    }
  }

  Future<bool> _waitEmailVerification() async {
    await for (var _ in registerTimer.stream) {
      final isVerificated = await authEmailService.isEmailVerified();
      if (isVerificated) {
        registerTimer.stop();
        return true;
      }
    }

    return false;
  }

  FutureOr<void> _sendRestorePasswordEmail(
      AuthRestore event, Emitter<AuthState> emit) async {
    if (restoreTimer.isRunning) return;

    try {
      final errorEmail = validationService.emailValidate(event.email);

      _setError(_EBlocError.email, errorEmail?.name);

      if (_errors.isNotEmpty) {
        _emitFail(emit);
        return;
      }

      emit(AuthLoading());

      final result = await authEmailService.sendResetPasswordEmail(event.email);

      if (result.isSuccess) {
        emit(AuthSendRestorePasswordEmail());
        restoreTimer.wait(waitTime);
      } else {
        _throwFail(result, emit);
      }
    } catch (e) {
      loger.error(e);
      emit(AuthLoaded());
    }
  }

  FutureOr<void> _sendVerificationEmail(
      AuthSendRegisterEmail event, Emitter<AuthState> emit) async {
    if (registerTimer.isRunning) return;

    emit(AuthLoading());
    try {
      final isVerified = await authEmailService.isEmailVerified();

      //TODO: need refactor
      if (isVerified) {
        await GetIt.I<IAuthorization>().logOut();
        emit(AuthEmailVerifiedSuccess());
        return;
      }

      final result = await authEmailService.resendVerificationEmail();
      if (result.isSuccess) {
        emit(AuthSendRegisterPasswordEmail());
        await registerTimer.wait(waitTime);
        final isVerify = await _waitEmailVerification();
        if (isVerify) emit(AuthEmailVerifiedSuccess());
      } else {
        _throwFail(result, emit);
      }
    } catch (e) {
      loger.error(e);
      emit(AuthLoaded());
    }
  }

  FutureOr<void> _googleLogin(
      AuthGoogleSingIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await authGoogleService.signInWithGoogle();

    result ? emit(AuthLoginSuccess()) : emit(AuthLoaded());
  }

  void _setError(_EBlocError type, String? message) {
    if (_errors[type] == message) return;
    message == null ? _errors.remove(type) : _errors[type] = message;
  }

  void _emitFail(Emitter<AuthState> emit) {
    emit(AuthFail(
      email: _errors[_EBlocError.email],
      password: _errors[_EBlocError.password],
      username: _errors[_EBlocError.username],
    ));
  }

  void _throwFail(AuthError error, Emitter<AuthState> emit) {
    switch (error) {
      case AuthError.success:
        break;
      case AuthError.userNoVerified:
      case AuthError.userDisabled:
      case AuthError.userNotFound:
      case AuthError.resetUserNotFound:
      case AuthError.invalidCredential:
      case AuthError.emailAlreadyInUse:
      case AuthError.invalidEmail:
      case AuthError.resetInvalidEmail:
      case AuthError.invalidVerificationId:
      case AuthError.credentialAlreadyInUse:
        _setError(_EBlocError.email, error.name);
        _emitFail(emit);
        break;
      case AuthError.weakPassword:
      case AuthError.wrongPassword:
        _setError(_EBlocError.password, error.name);
        _emitFail(emit);
        break;
      default:
        emit(AuthUnknownFail());
    }
  }
}
