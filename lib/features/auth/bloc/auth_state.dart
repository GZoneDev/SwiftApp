part of 'auth_bloc.dart';

abstract class AuthState {}

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

class AuthClearFailState extends AuthState {}

class AuthFailState extends AuthState {
  final Map<EBlocError, String?> errors;

  AuthFailState({required this.errors});
}

class AuthCountdownUpdatedState extends AuthState {
  final int remainingSeconds;
  AuthCountdownUpdatedState(this.remainingSeconds);
}

class AuthCountdownCompleteState extends AuthState {}

class AuthShowWaitMessageState extends AuthState {}
