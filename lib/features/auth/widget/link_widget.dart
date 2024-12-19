import 'package:flutter/material.dart';

class LinkWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color fontColor;

  const LinkWidget({
    super.key,
    required this.text,
    this.onTap,
    this.fontColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.only(right: 8);
    const fontSize = 12.0;
    return Container(
      margin: margin,
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: fontColor ,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
