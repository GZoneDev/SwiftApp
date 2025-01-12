import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/features/auth/bloc/auth_bloc.dart';
import 'package:receptico/features/auth/widget/widget.dart';

class SelectorTextInputWidget extends StatelessWidget {
  final String placeholder;
  final String? Function(AuthState state) selector;
  final TextEditingController? controller;
  final String? Function(String?) onChanged;
  final EdgeInsets margin, marginWithError;

  const SelectorTextInputWidget({
    super.key,
    required this.placeholder,
    required this.selector,
    required this.controller,
    required this.onChanged,
    this.margin = const EdgeInsets.only(bottom: 16.0),
    this.marginWithError = const EdgeInsets.only(bottom: 10.0),
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, String?>(
      selector: selector,
      builder: (context, error) {
        return TextInputWidget(
          controller: controller,
          placeholder: placeholder,
          margin: margin,
          marginWithError: marginWithError,
          onChanged: onChanged,
          error: error,
        );
      },
    );
  }
}
