import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width, height;
  final String text;

  const TextButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
