import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title, subtitle;
  const TitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const height = 8.0, fontSizeTitle = 28.0, fontSizeSubtitle = 17.0;
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: height),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSizeSubtitle,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
