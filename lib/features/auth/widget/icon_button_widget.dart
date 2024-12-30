import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final double assetWidth, assetHeight;
  final String assetPath;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.assetPath,
    this.assetWidth = 24,
    this.assetHeight = 24,
  });

  @override
  Widget build(BuildContext context) {
    final widgetStateProperty = WidgetStateProperty.all(const Size(99, 50));
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: widgetStateProperty,
      ),
      child: SvgPicture.asset(
        assetPath,
        width: assetWidth,
        height: assetHeight,
      ),
    );
  }
}
