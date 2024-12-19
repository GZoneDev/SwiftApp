import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double width, height, borderWidth;
  final Color color;

  const CircleWidget({
    super.key,
    this.width = 100,
    this.height = 100,
    this.color = Colors.white,
    this.borderWidth = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: borderWidth,
        ),
      ),
    );
  }
}
