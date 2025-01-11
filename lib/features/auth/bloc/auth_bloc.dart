import 'dart:async';

import 'package:receptico/common/valitation/template_validate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/generated/l10n.dart';

import '../service/service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum EBlocError {
  email,
  username,
  password,
  confirmPassword,
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late S _localization;
  final IAuthEmailService authEmailService;
  final IAuthGoogleService authGoogleService;
  final Map<EBlocError, String?> _errors = <EBlocError, String?>{};

  StreamController<int>? _countdownController;

  get isBlocked => _countdownController?.isClosed == false;

  // Start validation
  AuthBloc({required this.authEmailService, required this.authGoogleService})
      : super(AuthInitialState()) {
    on<AuthEmailValidateEvent>((event, emit) {
      final errorMessage =
          TemplateValidate.emailValidate(event.value, _localization);
      _emitFail(EBlocError.email, errorMessage, emit);
    });

    on<AuthPasswordValidateEvent>((event, emit) {
      final errorMessage =
          TemplateValidate.passwordValidate(event.value, _localization);
      _emitFail(EBlocError.password, errorMessage, emit);
    });

    on<AuthConfirmPasswordValidateEvent>((event, emit) {
      final errorMessage = event.value == event.confirmValue
          ? null
          : _localization.passwordsNoMatchError;
      _emitFail(EBlocError.confirmPassword, errorMessage, emit);
    });

    on<AuthUsernameValidateEvent>((event, emit) {
      final errorMessage =
          TemplateValidate.usernameValidate(event.value, _localization);
      _emitFail(EBlocError.username, errorMessage, emit);
    });
    // End validation

    on<AuthRouteEvent>((event, emit) {
      _errors.clear();
      emit(AuthClearFailState());
    });

    on<AuthLoginEvent>((event, emit) async {
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
          : _emitFail(
              EBlocError.email, _localization.userNoVerifiedError, emit);
    });

    on<AuthRegisterEvent>((event, emit) async {
      if (isBlocked) {
        emit(AuthShowWaitMessageState());
        return;
      }

      if (_errors.isNotEmpty) {
        emit(AuthFailState(errors: _errors));
        return;
      }

      emit(AuthLoadingState());

      final result =
          await authEmailService.registerWithEmail(event.email, event.password);

      if (result.isSuccess) {
        emit(AuthRegisterSuccessState(event.email));
        await _startTimer(emit);
      } else {
        _throwFail(result, _localization, emit);
      }
    });

    on<AuthRestoreEvent>((event, emit) async {
      if (isBlocked) {
        emit(AuthShowWaitMessageState());
        return;
      }

      if (_errors.isNotEmpty) {
        emit(AuthFailState(errors: _errors));
        return;
      }

      emit(AuthLoadingState());

      final result = await authEmailService.sendResetPasswordEmail(event.email);

      if (result.isSuccess) {
        emit(AuthRestoreSuccessState(event.email));
        await _startTimer(emit);
      } else {
        _throwFail(result, _localization, emit);
      }
    });

    on<AuthGoogleSingInEvent>((event, emit) async {
      emit(AuthLoadingState());

      final result = await authGoogleService.signInWithGoogle();

      result ? emit(AuthLoginSuccessState()) : emit(AuthLoadedState());
    });

    on<AuthSendRegisterEmailEvent>((event, emit) async {
      if (isBlocked) {
        emit(AuthShowWaitMessageState());
        return;
      }
      emit(AuthLoadingState());

      final result = await authEmailService.resendVerificationEmail();
      if (result.isSuccess) {
        emit(AuthLoadedState());
        await _startTimer(emit);
      } else {
        _throwFail(result, _localization, emit);
      }
    });

    on<AuthSendRestoreEmailEvent>((event, emit) async {
      if (isBlocked) {
        emit(AuthShowWaitMessageState());
        return;
      }

      emit(AuthLoadingState());

      final result = await authEmailService.sendResetPasswordEmail(event.email);

      if (result.isSuccess) {
        emit(AuthLoadedState());
        await _startTimer(emit);
      } else {
        _throwFail(result, _localization, emit);
      }
    });
  }

  Future<void> _startTimer(Emitter<AuthState> emit) async {
    if (_countdownController?.isClosed == false) return;
    _countdownController = StreamController<int>();

    int remainingSeconds = 60;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        _countdownController?.add(remainingSeconds);
        --remainingSeconds;
      } else {
        timer.cancel();
        _countdownController?.close();
      }
    });

    await for (final remainingSeconds in _countdownController!.stream) {
      emit(AuthCountdownUpdatedState(remainingSeconds));
    }

    emit(AuthCountdownCompleteState());
  }

  void updateLocalization(S localization) {
    _localization = localization;
  }

  void _emitFail(
      final EBlocError type, final String? message, Emitter<AuthState> emit) {
    if (_errors[type] != message) {
      message == null ? _errors.remove(type) : _errors[type] = message;
      emit(AuthFailState(errors: _errors));
    }
  }

  void _throwFail(
      FirebaseAuthError error, S localization, Emitter<AuthState> emit) {
    switch (error) {
      case FirebaseAuthError.success:
        break;
      case FirebaseAuthError.userDisabled:
        _emitFail(EBlocError.email, localization.userDisabledError, emit);
        break;
      case FirebaseAuthError.userNotFound:
      case FirebaseAuthError.resetUserNotFound:
      case FirebaseAuthError.invalidCredential:
        _emitFail(EBlocError.email, localization.userNotFoundError, emit);
        break;
      case FirebaseAuthError.wrongPassword:
        _emitFail(EBlocError.password, localization.wrongPasswordError, emit);
        break;
      case FirebaseAuthError.emailAlreadyInUse:
        _emitFail(EBlocError.email, localization.emailExistError, emit);
        break;
      case FirebaseAuthError.invalidEmail:
      case FirebaseAuthError.resetInvalidEmail:
        _emitFail(EBlocError.email, localization.invalidEmailError, emit);
        break;
      case FirebaseAuthError.weakPassword:
        _emitFail(EBlocError.password, localization.weakPasswordError, emit);
        break;
      case FirebaseAuthError.invalidVerificationId:
        _emitFail(EBlocError.email, localization.userNoVerifiedError, emit);
        break;
      case FirebaseAuthError.quotaExceeded:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.credentialAlreadyInUse:
        _emitFail(EBlocError.email, localization.credentialAlreadyInUse, emit);
        break;
      case FirebaseAuthError.tooManyRequests:
        // TODO: Handle this case.
        throw UnimplementedError();

      ///////
      case FirebaseAuthError.requiresRecentLogin:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.invalidVerificationCode:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.phoneOperationNotAllowed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.operationNotAllowed:
      case FirebaseAuthError.networkRequestFailed:
      case FirebaseAuthError.internalError:
      case FirebaseAuthError.unknown:
        emit(AuthNetworkFailState());
        break;
    }
  }
}
