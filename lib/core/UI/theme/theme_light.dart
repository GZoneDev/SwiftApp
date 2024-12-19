import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFC60F),
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF3C644)),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontFamily: 'SFProText',
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 8,
      ),
    ),
  ),
);

// class Theme {
//   final Color fontColor, backgroundColor;
//   const Theme({
//     this.fontColor = Colors.transparent,
//     this.backgroundColor = Colors.transparent,
//   });
// }

// const actionButtomTheme = Theme(
//   fontColor: Colors.white,
//   backgroundColor: Color(0xFF32ADE6),
// );

// const linkButtomTheme = Theme(backgroundColor: Colors.white);
// const errorTheme = Theme(fontColor: Colors.red);
// const warningTheme = Theme(fontColor: Colors.red);

class Palette {
  final Color error, warning, buttom, link, text, textbox, placeholder;

  const Palette({
    required this.error,
    required this.warning,
    required this.buttom,
    required this.link,
    required this.text,
    required this.textbox,
    required this.placeholder,
  });
}

class Theme {
  final Palette font, background;

  Theme({required this.font, required this.background});
}
