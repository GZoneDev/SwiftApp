part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {}

class AuthRestoreSuccessState extends AuthState {}

class AuthNetworkFailState extends AuthState {}

class AuthClearFailState extends AuthState {}

class AuthFailState extends AuthState {
  final Map<EBlocError, String?> errors;

  AuthFailState({required this.errors});
}

class AuthSendRestorePasswordEmail extends AuthState {}

class AuthSendRegisterPasswordEmail extends AuthState {}

class AuthEmailVerifiedSuccess extends AuthState {}
