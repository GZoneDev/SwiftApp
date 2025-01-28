import 'package:flutter/material.dart';
import 'package:receptico/core/UI/color/color_theme.dart';
import 'package:receptico/core/UI/color/palette.dart';
import '../theme_builder.dart';

final darkTheme = ThemeBuilder(
  assetThemeDirectory: 'dark',
  primaryColor: Colors.white,
  fontFamily: 'SFProText',
  colorTheme: ColorTheme(
    font: Palette(
      main: Colors.white,
      textButton: Colors.white,
      elevatedButton: Colors.white,
      input: Colors.black,
      error: Colors.red,
      hint: const Color(0xFF8E8E93),
      link: Colors.white,
      timer: const Color(0xFFFFA11E),
    ),
    background: Palette(
      scaffold: const Color(0xFFFFC60F),
      textButton: const Color(0xFFFFA11E),
      elevatedButton: Colors.white,
      input: Colors.white,
      inputReadonly: Color(0xFFF1E3B6),
      dashboarPhone: const Color(0xFFF1E3B6),
      hint: const Color(0xFFFFC60F),
      themeGradientTop: const Color(0xFF9F07D6),
      themeGradientBottom: const Color(0xFF350147),
    ),
    border: Palette(
      main: Colors.white,
      error: Colors.red,
      input: Colors.white,
      dashboarPhone: const Color(0xFF8E8E93),
      timer: const Color(0xFF007AFF),
      hint: Colors.white,
    ),
  ),
).build();
