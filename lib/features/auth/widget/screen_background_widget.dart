import 'package:flutter/material.dart';
import 'package:receptico/core/UI/color/color.dart';
import 'widget.dart';

class ScreenBackgroundWidget extends StatelessWidget {
  final bool IsMirrored;

  const ScreenBackgroundWidget({
    super.key,
    this.IsMirrored = false,
  });

  @override
  Widget build(BuildContext context) {
    final matrix4 = Matrix4.diagonal3Values(IsMirrored ? -1 : 1, 1, 1);
    final borderColor = context.color.border.main.safe;
    return Transform(
      alignment: Alignment.center,
      transform: matrix4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -95,
            left: -73,
            child: CircleWidget(color: borderColor, width: 254, height: 254),
          ),
          Positioned(
            bottom: -34,
            left: -47,
            child: CircleWidget(color: borderColor, width: 123, height: 123),
          ),
          Positioned(
            bottom: -72,
            right: -41,
            child: CircleWidget(color: borderColor, width: 196, height: 196),
          ),
        ],
      ),
    );
  }
}
