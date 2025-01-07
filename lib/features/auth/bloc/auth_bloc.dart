import 'package:receptico/common/valitation/template_validate.dart';
import 'package:auto_route/auto_route.dart';
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
  final IAuthEmailService _authEmail = AuthEmailService();
  final IAuthGoogleService _authGoogle = AuthGoogleService();

  final Map<EBlocError, String?> _errors = <EBlocError, String?>{};

  // Start validation
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEmailValidateEvent>((event, emit) {
      final errorMessage =
          TemplateValidate.emailValidate(event.value, event.localization);
      _emitFail(EBlocError.email, errorMessage, emit);
    });

    on<AuthPasswordValidateEvent>((event, emit) {
      final errorMessage =
          TemplateValidate.passwordValidate(event.value, event.localization);
      _emitFail(EBlocError.password, errorMessage, emit);
    });

    on<AuthConfirmPasswordValidateEvent>((event, emit) {
      final errorMessage = event.value == event.confirmValue
          ? null
          : event.localization.passwordsNoMatchError;
      _emitFail(EBlocError.confirmPassword, errorMessage, emit);
    });

    on<AuthUsernameValidateEvent>((event, emit) {
      final errorMessage =
          TemplateValidate.usernameValidate(event.value, event.localization);
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
          await _authEmail.loginWithEmail(event.emailOrPhone, event.password);

      if (!result.isSuccess) {
        _throwFail(result, event.localization, emit);
        return;
      }

      final isVerified = await _authEmail.isEmailVerified();

      if (isVerified) {
        emit(AuthLoginSuccessState());
      } else {
        _emitFail(
            EBlocError.email, event.localization.userNoVerifiedError, emit);
      }
    });

    on<AuthRegisterEvent>((event, emit) async {
      if (_errors.isNotEmpty) {
        emit(AuthFailState(errors: _errors));
        return;
      }

      emit(AuthLoadingState());

      final result = await _authEmail.registerWithEmail(
          event.emailOrPhone, event.password);

      result.isSuccess
          ? emit(AuthRegisterSuccessState(event.emailOrPhone))
          : _throwFail(result, event.localization, emit);
    });

    on<AuthRestoreEvent>((event, emit) async {
      if (_errors.isNotEmpty) {
        emit(AuthFailState(errors: _errors));
        return;
      }

      emit(AuthLoadingState());

      final result = await _authEmail.resetPassword(event.emailOrPhone);

      if (!result.isSuccess) _throwFail(result, event.localization, emit);

      final isVerified = await _authEmail.isEmailVerified();

      isVerified
          ? emit(AuthRestoreSuccessState(event.emailOrPhone))
          : _emitFail(
              EBlocError.email, event.localization.userNoVerifiedError, emit);
    });

    on<AuthGoogleSingInEvent>((event, emit) async {
      emit(AuthLoadingState());

      final result = await _authGoogle.signInWithGoogle();

      result ? emit(AuthLoginSuccessState()) : emit(AuthLoadedState());
    });
  }

  void _emitFail(
      final EBlocError type, final String? message, Emitter<AuthState> emit) {
    if (_errors[type] != message) {
      message == null ? _errors.remove(type) : _errors[type] = message;
      emit(AuthFailState(errors: _errors));
    }
  }

  void _throwFail(
      FirebaseAuthError error, S localithation, Emitter<AuthState> emit) {
    switch (error) {
      case FirebaseAuthError.success:
        break;
      case FirebaseAuthError.userDisabled:
        _emitFail(EBlocError.email, localithation.userDisabledError, emit);
        break;
      case FirebaseAuthError.userNotFound:
        _emitFail(EBlocError.email, localithation.userNotFoundError, emit);
        break;
      case FirebaseAuthError.wrongPassword:
        _emitFail(EBlocError.password, localithation.wrongPasswordError, emit);
        break;
      case FirebaseAuthError.emailAlreadyInUse:
        _emitFail(EBlocError.email, localithation.emailExistError, emit);
        break;
      case FirebaseAuthError.invalidEmail:
        _emitFail(EBlocError.email, localithation.invalidEmailError, emit);
        break;
      case FirebaseAuthError.operationNotAllowed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.weakPassword:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.resetInvalidEmail:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.resetUserNotFound:
        _emitFail(EBlocError.email, localithation.userNotFoundError, emit);
        break;
      case FirebaseAuthError.invalidVerificationCode:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.invalidVerificationId:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.quotaExceeded:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.credentialAlreadyInUse:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.phoneOperationNotAllowed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.requiresRecentLogin:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.tooManyRequests:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.invalidCredential:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.networkRequestFailed:
        emit(AuthNetworkFailState());
        break;
      case FirebaseAuthError.internalError:
        // TODO: Handle this case.
        throw UnimplementedError();
      case FirebaseAuthError.unknown:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
