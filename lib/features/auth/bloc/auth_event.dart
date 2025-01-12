part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email, password;

  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthRegisterEvent extends AuthEvent {
  final String email, password, username;

  AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}

class AuthRestoreEvent extends AuthEvent {
  final String email;

  AuthRestoreEvent({
    required this.email,
  });
}

class AuthRouteEvent extends AuthEvent {}

class AuthValidateEvent extends AuthEvent {
  final String? value;

  AuthValidateEvent({
    required this.value,
  });
}

class AuthEmailValidateEvent extends AuthValidateEvent {
  AuthEmailValidateEvent({required super.value});
}

class AuthPasswordValidateEvent extends AuthValidateEvent {
  AuthPasswordValidateEvent({required super.value});
}

class AuthConfirmPasswordValidateEvent extends AuthValidateEvent {
  final String? confirmValue;
  AuthConfirmPasswordValidateEvent({
    required this.confirmValue,
    required super.value,
  });
}

class AuthUsernameValidateEvent extends AuthValidateEvent {
  AuthUsernameValidateEvent({required super.value});
}

class AuthGoogleSingInEvent extends AuthEvent {}

class AuthSendRegisterEmailEvent extends AuthEvent {
  final String email;
  AuthSendRegisterEmailEvent(this.email);
}

class AuthSendRestoreEmailEvent extends AuthEvent {
  final String email;
  AuthSendRestoreEmailEvent(this.email);
}
