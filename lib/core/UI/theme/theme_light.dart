// class CustomContainerTheme extends ThemeExtension<CustomContainerTheme> {
//   final Color? borderColor;
//   final double? borderWidth;

//   const CustomContainerTheme({
//     this.borderColor,
//     this.borderWidth,
//   });

//   @override
//   CustomContainerTheme copyWith({
//     Color? borderColor,
//     double? borderWidth,
//   }) {
//     return CustomContainerTheme(
//       borderColor: borderColor ?? this.borderColor,
//       borderWidth: borderWidth ?? this.borderWidth,
//     );
//   }

//   @override
//   CustomContainerTheme lerp(
//       ThemeExtension<CustomContainerTheme>? other, double t) {
//     if (other is! CustomContainerTheme) return this;
//     return CustomContainerTheme(
//       borderColor: Color.lerp(borderColor, other.borderColor, t),
//       borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
//     );
//   }
// }

// final lightTheme = ThemeData(
//   scaffoldBackgroundColor: const Color(0xFFFFC60F),
//   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF3C644)),
//   useMaterial3: true,
//   extensions: <ThemeExtension<dynamic>>[
//     const CustomContainerTheme(
//       borderColor: Colors.white,
//       borderWidth: 8,
//     ),
//   ],
// );

// import 'package:flutter/material.dart';

// final lightTheme = ThemeData(
//   scaffoldBackgroundColor: const Color(0xFFFFC60F),
//   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF3C644)),
//   useMaterial3: true,
//   textTheme: const TextTheme(
//     bodyMedium: TextStyle(
//       fontFamily: 'SFProText',
//       fontSize: 15,
//       fontWeight: FontWeight.w400,
//       color: Colors.white,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       border: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.white,
//           width: 8,
//         ),
//       ),
//     ),
//   ),
// );

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
