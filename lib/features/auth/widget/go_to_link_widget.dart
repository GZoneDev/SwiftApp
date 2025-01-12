import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme.dart';

class GoToLinkWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final double iconSize;

  const GoToLinkWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.iconSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    const offset = Offset(-22, 4);
    final textStyle = context.font.subheadBold;
    final color = context.color.font.link.safe;
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
                size: iconSize,
                color: color,
              ),
            ),
            Text(text, style: textStyle),
          ],
        ),
      ),
    );
  }
}
