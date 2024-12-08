class LoginUser {
  String email;
  String password;

  LoginUser({required this.email, required this.password});
}

class RegisterUser extends LoginUser {
  String username;
  String phone;

  RegisterUser({
    required super.email,
    required super.password,
    required this.username,
    required this.phone,
  });
}
