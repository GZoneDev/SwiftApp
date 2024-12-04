import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFC60F),
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF3C644)),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontFamily: 'SFProText',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
);
