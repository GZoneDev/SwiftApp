import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/features/auth/bloc/auth_bloc.dart';
import 'package:receptico/features/auth/widget/widget.dart';

class SelectorPasswordInputWidget extends StatelessWidget {
  final String placeholder;
  final String? Function(AuthState state) selector;
  final TextEditingController? controller;
  final String? Function(String?) onChanged;
  final EdgeInsets margin, marginWithError;
  final Widget? helpWidget;

  const SelectorPasswordInputWidget({
    super.key,
    required this.placeholder,
    required this.selector,
    required this.controller,
    required this.onChanged,
    this.margin = const EdgeInsets.only(bottom: 25.0),
    this.marginWithError = const EdgeInsets.only(bottom: 22.0),
    this.helpWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, String?>(
      selector: selector,
      builder: (context, error) {
        return PasswordInputWidget(
          controller: controller,
          placeholder: placeholder,
          onChanged: onChanged,
          margin: margin,
          marginWithError: marginWithError,
          helpWidget: helpWidget,
          error: error,
          iconColor: context.color.font.input,
        );
      },
    );
  }
}
