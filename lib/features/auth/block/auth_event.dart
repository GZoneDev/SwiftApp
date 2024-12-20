part of 'auth_block.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final LoginUser user;

  AuthLogin({required this.user});
}

class AuthRegister extends AuthEvent {
  final RegisterUser user;

  AuthRegister({required this.user});
}
