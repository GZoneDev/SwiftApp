part of 'auth_block.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  String? emailError, passwordError;

  AuthLoginFailure({this.emailError, this.passwordError});
}

class AuthRegisterFailure extends AuthState {
  String? emailError, passwordError, phoneError, usernameError;

  AuthRegisterFailure({
    this.emailError,
    this.passwordError,
    this.phoneError,
    this.usernameError,
  });
}
