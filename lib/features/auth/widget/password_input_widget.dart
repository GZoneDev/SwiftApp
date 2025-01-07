import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receptico/core/UI/color/color.dart';

import 'text_input_widget.dart';

class PasswordInputWidget extends StatefulWidget {
  final double width, height, borderRadius, fontSize;
  final EdgeInsets margin, marginWithError;
  final String placeholderText;
  final String? Function(String?)? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Widget? helpWidget;
  final String? error;

  const PasswordInputWidget({
    super.key,
    required this.placeholderText,
    this.width = 278,
    this.height = 42,
    this.borderRadius = 8,
    this.fontSize = 17,
    this.marginWithError = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.onTap,
    this.controller,
    this.helpWidget,
    this.onChanged,
    this.error,
  });

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(left: 16, right: 44, top: 10, bottom: 10);
    return Stack(
      children: [
        TextInputWidget(
          onChanged: widget.onChanged,
          controller: widget.controller,
          placeholder: widget.placeholderText,
          obscureText: _isObscured,
          padding: padding,
          onTap: widget.onTap,
          helpWidget: widget.helpWidget,
          error: widget.error,
          margin: widget.margin,
          marginWithError: widget.marginWithError,
        ),
        Container(
          height: widget.height,
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => setState(() => _isObscured = !_isObscured),
            icon: Icon(
              _isObscured ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
              size: widget.fontSize,
              color: context.color.font.input,
            ),
          ),
        ),
      ],
    );
  }
}
