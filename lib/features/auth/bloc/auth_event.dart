part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String emailOrPhone, password;

  AuthLoginEvent({
    required this.emailOrPhone,
    required this.password,
  });
}

class AuthRegisterEvent extends AuthEvent {
  final String emailOrPhone, password, username;

  AuthRegisterEvent({
    required this.emailOrPhone,
    required this.password,
    required this.username,
  });
}

class AuthRestoreEvent extends AuthEvent {
  final String emailOrPhone;

  AuthRestoreEvent({required this.emailOrPhone});
}

class AuthRestorePhoneEvent extends AuthEvent {
  final String code, password, confirmPassword;

  AuthRestorePhoneEvent({
    required this.code,
    required this.password,
    required this.confirmPassword,
  });
}
