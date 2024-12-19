import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final EdgeInsets padding;
  final String errorMessage;
  final Color color;

  const ErrorMessageWidget({
    super.key,
    required this.errorMessage,
    this.padding = const EdgeInsets.only(left: 16, right: 16),
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: Text(
        errorMessage,
        textAlign: TextAlign.left,
        style: TextStyle(color: color),
      ),
    );
  }
}
