import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double width, height;

  const CircleWidget({
    super.key,
    this.width = 100,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 8,
        ),
      ),
    );
  }
}
