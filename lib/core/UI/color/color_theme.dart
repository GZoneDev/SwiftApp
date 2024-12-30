import 'package:flutter/material.dart';

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
  Color get safe => this ?? Colors.tealAccent;
}

class Palette {
  final Color? main;
  final Color? error;
  final Color? warning;
  final Color? hint;
  final Color? input;
  final Color? textButton;
  final Color? elevatedButton;
  final Color? floatingActionButton;
  final Color? scaffold;
  final Color? dashboarEmail;
  final Color? dashboarPhone;

  const Palette({
    this.main,
    this.error,
    this.warning,
    this.hint,
    this.input,
    this.textButton,
    this.elevatedButton,
    this.floatingActionButton,
    this.scaffold,
    this.dashboarEmail,
    this.dashboarPhone,
  });

  @override
  Palette copyWith({
    Color? main,
    Color? error,
    Color? warning,
    Color? hint,
    Color? input,
    Color? textButton,
    Color? elevatedButton,
    Color? floatingActionButton,
    Color? scaffold,
    Color? dashboarEmail,
    Color? dashboarPhone,
  }) {
    return Palette(
      main: main ?? this.main,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      hint: hint ?? this.hint,
      input: input ?? this.input,
      textButton: textButton ?? this.textButton,
      elevatedButton: elevatedButton ?? this.elevatedButton,
      floatingActionButton: floatingActionButton ?? this.floatingActionButton,
      scaffold: scaffold ?? this.scaffold,
      dashboarEmail: dashboarEmail ?? this.dashboarEmail,
      dashboarPhone: dashboarPhone ?? this.dashboarPhone,
    );
  }

  static Palette lerp(Palette? x, Palette? y, double t) {
    return Palette(
      main: Color.lerp(x?.main, y?.main, t),
      error: Color.lerp(x?.error, y?.error, t),
      warning: Color.lerp(x?.warning, y?.warning, t),
      hint: Color.lerp(x?.hint, y?.hint, t),
      input: Color.lerp(x?.input, y?.input, t),
      textButton: Color.lerp(x?.textButton, y?.textButton, t),
      elevatedButton: Color.lerp(x?.elevatedButton, y?.elevatedButton, t),
      floatingActionButton:
          Color.lerp(x?.floatingActionButton, y?.floatingActionButton, t),
      scaffold: Color.lerp(x?.scaffold, y?.scaffold, t),
      dashboarEmail: Color.lerp(x?.dashboarEmail, y?.dashboarEmail, t),
      dashboarPhone: Color.lerp(x?.dashboarPhone, y?.dashboarPhone, t),
    );
  }
}
