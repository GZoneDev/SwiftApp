import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Size size;
  final double borderRadius;
  final EdgeInsets padding;
  final double assetWidth, assetHeight;
  final String assetPath;
  final Color color;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.assetPath,
    this.size = const Size(99, 50),
    this.padding = const EdgeInsets.all(14),
    this.assetWidth = 24,
    this.assetHeight = 24,
    this.borderRadius = 12,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: color,
        fixedSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: SvgPicture.asset(
        assetPath,
        width: assetWidth,
        height: assetHeight,
      ),
    );
  }
}
