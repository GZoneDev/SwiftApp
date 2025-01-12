import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme.dart';

class TitleWidget extends StatelessWidget {
  final String title, subtitle;
  const TitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const spacing = 8.0;
    final textStyleTitle = context.font.title1Bold,
        textStyleSubtitle = context.font.body;
    return Column(
      spacing: spacing,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: textStyleTitle,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: textStyleSubtitle,
        ),
      ],
    );
  }
}
