import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme.dart';

class BackLinkWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final TextStyle? textStyle;
  final Color fontColor;
  final double fontSize;

  const BackLinkWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.fontColor = Colors.white,
    this.fontSize = 15,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    const spacing = 16.0;
    const offset = Offset(spacing + 6, 0);
    final textStyle = context.font.subheadBold;
    context.font.body;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Transform.translate(
          offset: offset,
          child: Row(
            spacing: spacing,
            children: [
              Icon(
                CupertinoIcons.chevron_back,
                size: fontSize,
                color: fontColor,
              ),
              Text(text, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
