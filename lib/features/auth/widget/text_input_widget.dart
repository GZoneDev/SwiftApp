import 'dart:async';

import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final double? width, height;
  final EdgeInsets margin, marginWithError;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final String? Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? error, placeholder;
  final bool obscureText, readOnly;
  final Widget? helpWidget;

  const TextInputWidget({
    super.key,
    this.placeholder,
    this.width,
    this.height = 42,
    this.marginWithError = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.padding,
    this.onTap,
    this.controller,
    this.error,
    this.obscureText = false,
    this.helpWidget,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  Timer? _debounce;

  void _onTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged?.call(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const errorLeftPadding = 8.0;
    final theme = Theme.of(context).inputDecorationTheme;
    final effectiveBorder =
        widget.error == null ? theme.border : theme.errorBorder;
    final textStyleError = theme.errorStyle;
    final marginContent =
        widget.error == null ? widget.margin : widget.marginWithError;
    final padding = theme.contentPadding;
    return Container(
      margin: marginContent,
      child: Column(
        children: [
          SizedBox(
            height: widget.height,
            width: widget.width,
            child: TextFormField(
              readOnly: widget.readOnly,
              controller: widget.controller,
              obscureText: widget.obscureText,
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                contentPadding: padding ?? EdgeInsets.symmetric(horizontal: 16),
                hintText: widget.placeholder,
                border: effectiveBorder,
                enabledBorder: effectiveBorder,
                focusedBorder: effectiveBorder,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.error != null)
                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: errorLeftPadding),
                    child: Text(
                      widget.error!,
                      style: textStyleError,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              if (widget.helpWidget != null) widget.helpWidget!,
            ],
          ),
        ],
      ),
    );
  }
}
