part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoaded extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoginSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthRegisterSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthRestoreSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthUnknownFail extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthClearFail extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthFail extends AuthState {
  final String? email;
  final String? password;
  final String? username;

  AuthFail({this.email, this.password, this.username});

  @override
  List<Object?> get props => [email, password, username];
}

class AuthSendRestorePasswordEmail extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSendRegisterPasswordEmail extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthEmailVerifiedSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}
