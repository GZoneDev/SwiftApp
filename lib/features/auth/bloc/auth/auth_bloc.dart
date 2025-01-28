import 'dart:async';

import 'package:receptico/common/valitation/template_validate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/bloc/bloc_route_interface.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../../service/service.dart';
import '../../service/timer_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum EBlocError {
  email,
  username,
  password,
  confirmPassword,
}

EventTransformer<E> throttle<E>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).flatMap(mapper);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> implements IBlocRoute {
  static const waitTime = 60;
  late S _localization;
  final Talker loger;
  final AuthEmailService authEmailService;
  final AuthGoogleService authGoogleService;
  final TimerService restoreTimer;
  final TimerService registerTimer;

  final Map<EBlocError, String?> _errors = <EBlocError, String?>{};

  AuthBloc({
    required this.authEmailService,
    required this.authGoogleService,
    required this.restoreTimer,
    required this.registerTimer,
    required this.loger,
  }) : super(AuthInitialState()) {
    on<AuthUsernameValidateEvent>(_usernameValidate);
    on<AuthEmailValidateEvent>(_emailValidate);
    on<AuthPasswordValidateEvent>(_passwordValidate);

    on<AuthLoginEvent>(
      _login,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
    on<AuthRegisterEvent>(
      _register,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
    on<AuthRestoreEvent>(
      _sendRestorePasswordEmail,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
    on<AuthSendRegisterEmailEvent>(
      _sendVerificationEmail,
      transformer: throttle(const Duration(milliseconds: 500)),
    );

    on<AuthRouteEvent>(_routing);
    on<AuthGoogleSingInEvent>(
      _googleLogin,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
  }

  FutureOr<void> _usernameValidate(
      AuthUsernameValidateEvent event, Emitter<AuthState> emit) {
    final errorMessage =
        TemplateValidate.usernameValidate(event.value, _localization);
    _emitFail(EBlocError.username, errorMessage, emit);
  }

  FutureOr<void> _emailValidate(
      AuthEmailValidateEvent event, Emitter<AuthState> emit) {
    final errorMessage =
        TemplateValidate.emailValidate(event.value, _localization);
    _emitFail(EBlocError.email, errorMessage, emit);
  }

  FutureOr<void> _passwordValidate(
      AuthPasswordValidateEvent event, Emitter<AuthState> emit) {
    final errorMessage =
        TemplateValidate.passwordValidate(event.value, _localization);
    _emitFail(EBlocError.password, errorMessage, emit);
  }

  FutureOr<void> _routing(AuthRouteEvent event, Emitter<AuthState> emit) {
    _errors.clear();
    emit(AuthClearFailState());
  }

  FutureOr<void> _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final errorEmail =
        TemplateValidate.emailValidate(event.email, _localization);
    final errorPassword =
        TemplateValidate.passwordValidate(event.password, _localization);

    _emitFail(EBlocError.email, errorEmail, emit);
    _emitFail(EBlocError.password, errorPassword, emit);

    if (_errors.isNotEmpty) {
      emit(AuthFailState(errors: _errors));
      return;
    }

    emit(AuthLoadingState());

    final result =
        await authEmailService.loginWithEmail(event.email, event.password);

    if (!result.isSuccess) {
      _throwFail(result, _localization, emit);
      return;
    }

    final isVerified = await authEmailService.isEmailVerified();

    isVerified
        ? emit(AuthLoginSuccessState())
        : _emitFail(EBlocError.email, _localization.userNoVerifiedError, emit);
  }

  FutureOr<void> _register(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    if (registerTimer.isWaiting) return;

    try {
      final errorUsername =
          TemplateValidate.usernameValidate(event.username, _localization);
      final errorEmail =
          TemplateValidate.emailValidate(event.email, _localization);
      final errorPassword =
          TemplateValidate.passwordValidate(event.password, _localization);

      _emitFail(EBlocError.username, errorUsername, emit);
      _emitFail(EBlocError.email, errorEmail, emit);
      _emitFail(EBlocError.password, errorPassword, emit);

      if (_errors.isNotEmpty) return;

      emit(AuthLoadingState());

      final result =
          await authEmailService.registerWithEmail(event.email, event.password);

      if (result.isSuccess) {
        emit(AuthRegisterSuccessState());
        await registerTimer.wait(waitTime);
        final isVerify = await _waitEmailVerification();
        if (isVerify) emit(AuthEmailVerifiedSuccess());
      } else {
        _throwFail(result, _localization, emit);
      }
    } catch (e) {
      loger.error(e);
      emit(AuthLoadedState());
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
      AuthRestoreEvent event, Emitter<AuthState> emit) async {
    if (restoreTimer.isWaiting) return;

    try {
      final errorEmail =
          TemplateValidate.emailValidate(event.email, _localization);

      _emitFail(EBlocError.email, errorEmail, emit);

      if (_errors.isNotEmpty) return;

      emit(AuthLoadingState());

      final result = await authEmailService.sendResetPasswordEmail(event.email);

      if (result.isSuccess) {
        emit(AuthSendRestorePasswordEmail());
        restoreTimer.wait(waitTime);
      } else {
        _throwFail(result, _localization, emit);
      }
    } catch (e) {
      loger.error(e);
      emit(AuthLoadedState());
    }
  }

  FutureOr<void> _sendVerificationEmail(
      AuthSendRegisterEmailEvent event, Emitter<AuthState> emit) async {
    if (registerTimer.isWaiting) return;

    emit(AuthLoadingState());
    try {
      final isVerified = await authEmailService.isEmailVerified();

      //TODO: need refactor
      if (isVerified) {
        //await GetIt.I<IAuthorization>().logOut();
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
        _throwFail(result, _localization, emit);
      }
    } catch (e) {
      loger.error(e);
      emit(AuthLoadedState());
    }
  }

  FutureOr<void> _googleLogin(
      AuthGoogleSingInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final result = await authGoogleService.signInWithGoogle();

    result ? emit(AuthLoginSuccessState()) : emit(AuthLoadedState());
  }

  void updateLocalization(S localization) {
    _localization = localization;
  }

  @override
  //void routeEvent() => add(AuthRouteEvent());

  void routeEvent() => emit(AuthLoginSuccessState());

  void _emitFail(
      final EBlocError type, final String? message, Emitter<AuthState> emit) {
    if (_errors[type] != message) {
      message == null ? _errors.remove(type) : _errors[type] = message;
      emit(AuthFailState(errors: _errors));
    }
  }

  void _throwFail(AuthError error, S localization, Emitter<AuthState> emit) {
    final errorMapping = {
      AuthError.userDisabled: () =>
          _emitFail(EBlocError.email, localization.userDisabledError, emit),
      AuthError.userNotFound: () =>
          _emitFail(EBlocError.email, localization.userNotFoundError, emit),
      AuthError.resetUserNotFound: () =>
          _emitFail(EBlocError.email, localization.userNotFoundError, emit),
      AuthError.invalidCredential: () =>
          _emitFail(EBlocError.email, localization.userNotFoundError, emit),
      AuthError.wrongPassword: () =>
          _emitFail(EBlocError.password, localization.wrongPasswordError, emit),
      AuthError.emailAlreadyInUse: () =>
          _emitFail(EBlocError.email, localization.emailExistError, emit),
      AuthError.invalidEmail: () =>
          _emitFail(EBlocError.email, localization.invalidEmailError, emit),
      AuthError.resetInvalidEmail: () =>
          _emitFail(EBlocError.email, localization.invalidEmailError, emit),
      AuthError.weakPassword: () =>
          _emitFail(EBlocError.password, localization.weakPasswordError, emit),
      AuthError.invalidVerificationId: () =>
          _emitFail(EBlocError.email, localization.userNoVerifiedError, emit),
      AuthError.credentialAlreadyInUse: () => _emitFail(
          EBlocError.email, localization.credentialAlreadyInUse, emit),
      AuthError.operationNotAllowed: () => emit(AuthNetworkFailState()),
      AuthError.networkRequestFailed: () => emit(AuthNetworkFailState()),
      AuthError.internalError: () => emit(AuthNetworkFailState()),
      AuthError.unknown: () => emit(AuthNetworkFailState()),
    };

    final unimplementedErrors = {
      AuthError.quotaExceeded,
      AuthError.tooManyRequests,
      AuthError.requiresRecentLogin,
      AuthError.invalidVerificationCode,
      AuthError.phoneOperationNotAllowed,
    };

    if (error == AuthError.success) return;

    if (errorMapping.containsKey(error)) {
      errorMapping[error]?.call();
    } else if (unimplementedErrors.contains(error)) {
      throw UnimplementedError('Handle error: $error');
    }
  }
}
