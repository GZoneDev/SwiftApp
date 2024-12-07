import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final double width, height;
  final EdgeInsets margin, padding;
  final double borderRadius;
  final String placeholder;

  const TextInputWidget({
    super.key,
    required this.placeholder,
    this.width = 278,
    this.height = 42,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.only(bottom: 3, left: 16, right: 16),
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
