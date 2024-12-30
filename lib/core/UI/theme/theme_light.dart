import 'package:flutter/material.dart';
import 'package:receptico/core/UI/color/color_theme.dart';
import 'theme_builder.dart';

final lightTheme = ThemeBuilder(
  assetThemeDirectory: 'light',
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
    ),
    background: Palette(
      scaffold: const Color(0xFFFFC60F),
      textButton: const Color(0xFF32ADE6),
      elevatedButton: Colors.white,
      input: Colors.white,
      dashboarPhone: const Color(0xFFF1E3B6),
      dashboarEmail: const Color(0xFF5AC8FA),
    ),
    border: Palette(
      error: Colors.red,
      input: Colors.white,
      dashboarPhone: const Color(0xFF8E8E93),
      dashboarEmail: const Color(0xFF007AFF),
    ),
  ),
).build();
