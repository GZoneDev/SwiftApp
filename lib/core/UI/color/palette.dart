import 'package:flutter/material.dart';

class Palette {
  final Color? main;
  final Color? error;
  final Color? warning;
  final Color? hint;
  final Color? input;
  final Color? link;
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
    this.link,
    this.textButton,
    this.elevatedButton,
    this.floatingActionButton,
    this.scaffold,
    this.dashboarEmail,
    this.dashboarPhone,
  });

  Palette copyWith({
    Color? main,
    Color? error,
    Color? warning,
    Color? hint,
    Color? input,
    Color? link,
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
      link: link ?? this.link,
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
      link: Color.lerp(x?.link, y?.link, t),
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
