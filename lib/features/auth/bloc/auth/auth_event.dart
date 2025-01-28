part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String email, password;

  AuthLogin({
    required this.email,
    required this.password,
  });
}

class AuthRegister extends AuthEvent {
  final String email, password, username;

  AuthRegister({
    required this.email,
    required this.password,
    required this.username,
  });
}

class AuthRestore extends AuthEvent {
  final String email;

  AuthRestore({
    required this.email,
  });
}

class AuthRoute extends AuthEvent {}

abstract class AuthValidate extends AuthEvent {
  final String? value;

  AuthValidate({
    required this.value,
  });
}

class AuthEmailValidate extends AuthValidate {
  AuthEmailValidate({required super.value});
}

class AuthPasswordValidate extends AuthValidate {
  AuthPasswordValidate({required super.value});
}

class AuthUsernameValidate extends AuthValidate {
  AuthUsernameValidate({required super.value});
}

class AuthGoogleLogin extends AuthEvent {}

class AuthAppleLogin extends AuthEvent {}

class AuthSendRegisterEmail extends AuthEvent {
  final String email, password;

  AuthSendRegisterEmail({
    required this.email,
    required this.password,
  });
}
