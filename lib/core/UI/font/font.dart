import 'package:flutter/material.dart';

enum Font {
  displayLarge(34.0),
  title1(28.0),
  title2(22.0),
  title3(20.0),
  headline(17.0),
  body(17.0),
  callout(16.0),
  subhead(15.0),
  footnote(13.0),
  caption1(12.0),
  caption2(11.0);

  final double size;
  TextStyle textStyle(
          {Color? color, FontWeight? fontWeight = FontWeight.normal}) =>
      TextStyle(fontSize: size, fontWeight: fontWeight, color: color);
  const Font(this.size);
}
