part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String emailOrPhone, password;
  final S localization;

  AuthLoginEvent({
    required this.emailOrPhone,
    required this.password,
    required this.localization,
  });
}

class AuthRegisterEvent extends AuthEvent {
  final String emailOrPhone, password, username;
  final S localization;

  AuthRegisterEvent({
    required this.emailOrPhone,
    required this.password,
    required this.username,
    required this.localization,
  });
}

class AuthRestoreEvent extends AuthEvent {
  final String emailOrPhone;
  final StackRouter router;
  final S localization;

  AuthRestoreEvent({
    required this.emailOrPhone,
    required this.router,
    required this.localization,
  });
}

class AuthRouteEvent extends AuthEvent {}

class AuthValidateEvent extends AuthEvent {
  final String? value;
  final S localization;

  AuthValidateEvent({
    required this.value,
    required this.localization,
  });
}

class AuthEmailValidateEvent extends AuthValidateEvent {
  AuthEmailValidateEvent({required super.value, required super.localization});
}

class AuthPasswordValidateEvent extends AuthValidateEvent {
  AuthPasswordValidateEvent(
      {required super.value, required super.localization});
}

class AuthConfirmPasswordValidateEvent extends AuthValidateEvent {
  final String? confirmValue;
  AuthConfirmPasswordValidateEvent({
    required this.confirmValue,
    required super.value,
    required super.localization,
  });
}

class AuthUsernameValidateEvent extends AuthValidateEvent {
  AuthUsernameValidateEvent(
      {required super.value, required super.localization});
}

class AuthGoogleSingInEvent extends AuthEvent {}
