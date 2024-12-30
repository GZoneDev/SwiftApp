import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme.dart';

class LinkWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const LinkWidget({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.only(right: 8);
    final textStyle = context.font.caption1;
    return Container(
      margin: margin,
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
