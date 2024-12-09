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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        const SizedBox(width: 8),
        InkWell(
          onTap: onTab,
          child: Text(
            linkText,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
