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
  String? emailError, passwordError;

  AuthLoginFailState({this.emailError, this.passwordError});

  get containsError => emailError != null || passwordError != null;
}

class AuthClearFailState extends AuthState {}

class AuthRestoreFailState extends AuthState {
  String? emailError;

  AuthRestoreFailState({this.emailError});
}

class AuthFailState extends AuthState {
  AuthFailState({super.errors});
}

class AuthEmailFailState extends AuthFailState {}

class AuthPasswordFailState extends AuthFailState {}

class AuthCountdownUpdatedState extends AuthState {
  final int remainingSeconds;
  AuthCountdownUpdatedState(this.remainingSeconds);
}

class AuthCountdownCompleteState extends AuthState {}

class AuthShowWaitMessageState extends AuthState {}
