import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorMessageWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      width: double.infinity,
      child: Text(
        errorMessage,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
