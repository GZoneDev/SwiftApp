import 'package:flutter/material.dart';

class LinkButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final double wight, height;
  final String text;

  const LinkButtonWidget({
    super.key,
    required this.onPressed,
    this.text = 'Увійти',
    this.wight = 278,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(14),
        backgroundColor: Color(0xFF32ADE6),
        fixedSize: Size(wight, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
