import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double radius, borderWidth;

  final Color color;

  const CircleWidget({
    super.key,
    this.radius = 100,
    required this.color,
    this.borderWidth = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
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
