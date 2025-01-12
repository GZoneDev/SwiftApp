import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'text_input_widget.dart';

class PasswordInputWidget extends StatefulWidget {
  final double width, height, borderRadius, iconSize;
  final EdgeInsets margin, marginWithError;
  final String? placeholder;
  final String? Function(String?)? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Widget? helpWidget;
  final String? error;
  final Color? iconColor;

  const PasswordInputWidget({
    super.key,
    this.placeholder,
    this.width = 278,
    this.height = 42,
    this.borderRadius = 8,
    this.iconSize = 17,
    this.marginWithError = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.onTap,
    this.controller,
    this.helpWidget,
    this.onChanged,
    this.error,
    this.iconColor,
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
          placeholder: widget.placeholder,
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
              size: widget.iconSize,
              color: widget.iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
