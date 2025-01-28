import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';

mixin ValidateMixin<T extends StatefulWidget> on State<T> {
  String? usernameValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthUsernameValidate(value: value),
        );
    return value;
  }

  String? emailValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthEmailValidate(value: value),
        );
    return value;
  }

  String? passwordValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthPasswordValidate(value: value),
        );
    return value;
  }
}
