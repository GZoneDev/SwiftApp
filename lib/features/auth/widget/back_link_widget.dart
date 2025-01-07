import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme.dart';

class BackLinkWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final double fontSize;

  const BackLinkWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    const offset = Offset(-22, 4);
    final textStyle = context.font.subheadBold;
    context.font.body;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Transform.translate(
              offset: offset,
              child: Icon(
                CupertinoIcons.chevron_back,
                size: fontSize,
                color: context.color.font.link.safe,
              ),
            ),
            Text(text, style: textStyle),
          ],
        ),
      ),
    );
  }
}
