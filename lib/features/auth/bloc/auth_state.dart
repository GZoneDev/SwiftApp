part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {}

class AuthLoginFailState extends AuthState {
  String? emailOrPhoneError, passwordError;

  AuthLoginFailState({this.emailOrPhoneError, this.passwordError});

  bool containsError() => emailOrPhoneError != null || passwordError != null;
}

class AuthRegisterFailState extends AuthState {
  String? emailOrPhoneError, passwordError, usernameError;

  AuthRegisterFailState({
    this.emailOrPhoneError,
    this.passwordError,
    this.usernameError,
  });

  bool containsError() =>
      emailOrPhoneError != null ||
      passwordError != null ||
      usernameError != null;
}

class AuthRestoreFailState extends AuthState {
  String? emailOrPhoneError;

  AuthRestoreFailState({this.emailOrPhoneError});

  bool containsError() => emailOrPhoneError != null;
}

class AuthRestorePhoneFailState extends AuthState {
  String? code, password, confirmPassword;

  AuthRestorePhoneFailState({
    required this.code,
    required this.password,
    required this.confirmPassword,
  });

  bool containsError() =>
      code != null || password != null || confirmPassword != null;
}
