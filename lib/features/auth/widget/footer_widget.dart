import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme.dart';

class FooterWidget extends StatelessWidget {
  final double spacing;
  final String text, linkText;
  final VoidCallback? onTab;

  const FooterWidget({
    super.key,
    required this.text,
    required this.linkText,
    this.spacing = 8.0,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleLink = context.font.subheadBold,
        textStyleText = context.font.subhead;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: spacing,
      children: [
        Text(text, style: textStyleText),
        InkWell(
          onTap: onTab,
          child: Text(linkText, style: textStyleLink),
        ),
      ],
    );
  }
}
