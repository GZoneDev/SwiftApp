import 'package:flutter/material.dart';
import 'package:receptico/core/UI/color/color.dart';

class ScaffoldWithGradientWidget extends StatelessWidget {
  final Widget body;
  const ScaffoldWithGradientWidget({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.color.background.themeGradientTop.safe,
              context.color.background.themeGradientBottom.safe,
            ],
            stops: [0.29, 1.0],
          ),
        ),
        child: body,
      ),
    );
  }
}
