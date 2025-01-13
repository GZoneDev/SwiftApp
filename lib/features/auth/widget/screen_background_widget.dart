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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double size = 1.0;
    bool isVisible = screenHeight > 540;

    // if (screenWidth <= 530) {
    //   size = 1.2;
    // }

    // if (screenWidth <= 430) {
    //   size = 1.5;
    // }

    // if (screenHeight <= 580) {
    //   size = 1.8;
    // }

    // if (screenHeight <= 540) {
    //   size = 2;
    // }

    return !isVisible
        ? SizedBox.shrink()
        : Transform(
            alignment: Alignment.center,
            transform: matrix4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: -95 / size,
                  left: -73 / size,
                  child: CircleWidget(color: borderColor, radius: 254 / size),
                ),
                Positioned(
                  bottom: -34 / size,
                  left: -47 / size,
                  child: CircleWidget(color: borderColor, radius: 123 / size),
                ),
                Positioned(
                  bottom: -72 / size,
                  right: -41 / size,
                  child: CircleWidget(color: borderColor, radius: 196 / size),
                ),
              ],
            ),
          );
  }
}
