import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final String text, linkText;
  final VoidCallback? onTab;

  const FooterWidget({
    super.key,
    required this.text,
    required this.linkText,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    const spaceWidth = 8.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        const SizedBox(width: spaceWidth),
        InkWell(
          onTap: onTab,
          child: Text(
            linkText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
