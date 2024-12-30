import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final double width, height;
  final EdgeInsets margin, marginWithError;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? errorMessage, placeholder;
  final bool obscureText, readOnly;
  final Widget? helpWidget;

  const TextInputWidget({
    super.key,
    this.placeholder,
    this.width = 278,
    this.height = 42,
    this.marginWithError = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.padding,
    this.onTap,
    this.controller,
    this.errorMessage,
    this.obscureText = false,
    this.helpWidget,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    const errorLeftPadding = 8.0,
        errorTopPadding = 2.0,
        widthErrorMessageWithHelpWidget = 150.0;
    final border = errorMessage != null
        ? Theme.of(context).inputDecorationTheme.errorBorder
        : null;
    final textStyleError = Theme.of(context).inputDecorationTheme.errorStyle;
    return Container(
      margin: errorMessage == null ? margin : marginWithError,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: TextFormField(
                  readOnly: readOnly,
                  controller: controller,
                  onTap: onTap,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    contentPadding: padding,
                    hintText: placeholder,
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: errorLeftPadding, top: errorTopPadding),
                    child: errorMessage != null
                        ? SizedBox(
                            width: helpWidget == null
                                ? width - errorLeftPadding * 2
                                : widthErrorMessageWithHelpWidget,
                            child: Text(
                              errorMessage!,
                              style: textStyleError,
                            ))
                        : null,
                  ),
                  Container(child: errorMessage != null ? helpWidget : null),
                ],
              ),
              Container(child: errorMessage == null ? helpWidget : null),
            ],
          ),
        ],
      ),
    );
  }
}
