import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final double width, height, fontSize, borderRadius;
  final Color placeholderColor, inputTextColor, backgroundColor;
  final EdgeInsets margin, padding;
  final String placeholder;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? errorMessage;
  final bool obscureText;
  final Widget? helpWidget;

  const TextInputWidget({
    super.key,
    required this.placeholder,
    this.width = 278,
    this.height = 42,
    this.borderRadius = 8,
    this.fontSize = 17,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.only(left: 16, right: 16),
    this.placeholderColor = const Color(0xFF8E8E93),
    this.inputTextColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.onTap,
    this.controller,
    this.errorMessage,
    this.obscureText = false,
    this.helpWidget,
  });

  @override
  Widget build(BuildContext context) {
    const marginBackground = EdgeInsets.only(top: 3);
    const borderWidth = 1.0;
    const errorColor = Colors.red;
    const errorLeftPadding = 8.0;
    const errorTopPadding = 2.0;
    const errorFontSize = 12.0;
    return Container(
      margin: margin,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: marginBackground,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: errorMessage != null
                      ? Border.all(color: errorColor, width: borderWidth)
                      : null,
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
                        ? Text(
                            errorMessage!,
                            style: TextStyle(
                              fontSize: errorFontSize,
                              color: errorColor,
                            ),
                          )
                        : null,
                  ),
                  Container(child: errorMessage != null ? helpWidget : null),
                ],
              ),
              Container(child: errorMessage == null ? helpWidget : null),
              // Container(
              //   alignment: Alignment.bottomLeft,
              //   padding: EdgeInsets.only(
              //       left: errorLeftPadding, top: errorTopPadding),
              //   child: errorMessage != null
              //       ? Text(
              //           errorMessage!,
              //           style: TextStyle(
              //             fontSize: errorFontSize,
              //             color: errorColor,
              //           ),
              //         )
              //       : null,
              // ),
            ],
          ),
          Container(
            padding: padding,
            child: TextFormField(
              controller: controller,
              onTap: onTap,
              obscureText: obscureText,
              style: TextStyle(
                color: inputTextColor,
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: placeholderColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
