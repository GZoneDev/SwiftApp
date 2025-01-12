import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/UI/color/palette.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ColorTheme extends ThemeExtension<ColorTheme> {
  Palette font, background, border;

  ColorTheme({
    Palette? defaultPalette,
    Palette? font,
    Palette? background,
    Palette? border,
  })  : font = font ?? defaultPalette ?? Palette(),
        background = background ?? defaultPalette ?? Palette(),
        border = border ?? defaultPalette ?? Palette();

  @override
  ColorTheme copyWith({
    Palette? font,
    Palette? background,
    Palette? border,
  }) {
    return ColorTheme(
      font: font ?? this.font,
      background: background ?? this.background,
      border: border ?? this.border,
    );
  }

  @override
  ColorTheme lerp(ThemeExtension<ColorTheme>? other, double t) {
    if (other is! ColorTheme) return this;

    return ColorTheme(
      font: Palette.lerp(font, other.font, t),
      background: Palette.lerp(background, other.background, t),
      border: Palette.lerp(border, other.border, t),
    );
  }
}

extension ColorThemeExtension on BuildContext {
  ColorTheme get color => Theme.of(this).extension<ColorTheme>()!;
}

extension SafeColor on Color? {
  Color get safe {
    if (this == null) {
      final errorLocation = StackTrace.current.toString().split('\n')[1];
      final error =
          'Error: NULL color used. Initialize variable in ThemeBuilder. \n$errorLocation';
      GetIt.I<Talker>().critical(error);
    }
    return this ?? Colors.transparent;
  }
}
