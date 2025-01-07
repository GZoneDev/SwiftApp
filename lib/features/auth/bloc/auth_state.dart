part of 'auth_bloc.dart';

abstract class AuthState {
  final Map<EBlocError, String?>? errors;
  AuthState({this.errors});
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {
  final String email;
  AuthRegisterSuccessState(this.email);
}

class AuthRestoreSuccessState extends AuthState {
  final String email;
  AuthRestoreSuccessState(this.email);
}

class AuthNetworkFailState extends AuthState {}

class AuthLoginFailState extends AuthState {
  String? emailOrPhoneError, passwordError;

  AuthLoginFailState({this.emailOrPhoneError, this.passwordError});

  get containsError => emailOrPhoneError != null || passwordError != null;
}

class AuthClearFailState extends AuthState {}

class AuthRestoreFailState extends AuthState {
  String? emailOrPhoneError;

  AuthRestoreFailState({this.emailOrPhoneError});
}

class AuthFailState extends AuthState {
  AuthFailState({super.errors});
}

class AuthEmailFailState extends AuthFailState {}

class AuthPasswordFailState extends AuthFailState {}
