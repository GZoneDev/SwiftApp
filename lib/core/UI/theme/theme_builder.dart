import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme.dart';

import '../font/font.dart';

class ThemeBuilder {
  final String assetThemeDirectory;
  final Color? primaryColor;
  final String? fontFamily;
  final ColorTheme colorTheme;

  ThemeBuilder({
    this.assetThemeDirectory = 'light',
    this.fontFamily,
    this.primaryColor,
    ColorTheme? colorTheme,
  }) : colorTheme = colorTheme ?? ColorTheme();

  ThemeData build() {
    final inputTextBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorTheme.border.input.safe),
    );
    final inputTextErrorBorder = inputTextBorder.copyWith(
      borderSide: BorderSide(color: colorTheme.border.error.safe),
    );
    const inputTextPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        elevatedButtonPadding = EdgeInsets.all(14),
        textButtonPadding = EdgeInsets.all(14);
    final borderRadiusElevatedButton = BorderRadius.circular(12),
        borderRadiusTextButton = BorderRadius.circular(12);
    return ThemeData(
      scaffoldBackgroundColor:
          colorTheme.background.scaffold ?? colorTheme.background.main,
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      hintColor: colorTheme.font.hint,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorTheme.background.input,
        contentPadding: inputTextPadding,
        border: inputTextBorder,
        focusedBorder: inputTextBorder,
        enabledBorder: inputTextBorder,
        focusedErrorBorder: inputTextErrorBorder,
        errorBorder: inputTextErrorBorder,
        errorStyle: Font.caption1.textStyle(color: colorTheme.font.error),
        hintStyle: Font.body.textStyle(color: colorTheme.font.hint),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            Font.body.textStyle(color: colorTheme.font.elevatedButton),
          ),
          padding: WidgetStateProperty.all(elevatedButtonPadding),
          backgroundColor:
              WidgetStateProperty.all(colorTheme.background.elevatedButton),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: borderRadiusElevatedButton),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(Font.headline.textStyle()),
          foregroundColor: WidgetStateProperty.all(colorTheme.font.textButton),
          backgroundColor:
              WidgetStateProperty.all(colorTheme.background.textButton),
          padding: WidgetStateProperty.all(textButtonPadding),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: borderRadiusTextButton),
          ),
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: colorTheme.font.main),
      ),
      extensions: <ThemeExtension<dynamic>>[
        Asset(assetDirectory: assetThemeDirectory),
        colorTheme,
        FontTheme(
          displayLarge: Font.title1.textStyle(color: colorTheme.font.main),
          title1: Font.title1.textStyle(color: colorTheme.font.main),
          title2: Font.title2.textStyle(color: colorTheme.font.main),
          title3: Font.title3.textStyle(color: colorTheme.font.main),
          headline: Font.headline.textStyle(color: colorTheme.font.main),
          body: Font.body.textStyle(color: colorTheme.font.main),
          callout: Font.callout.textStyle(color: colorTheme.font.main),
          subhead: Font.subhead.textStyle(color: colorTheme.font.main),
          footnote: Font.footnote.textStyle(color: colorTheme.font.main),
          caption1: Font.caption1.textStyle(color: colorTheme.font.main),
          caption2: Font.caption2.textStyle(color: colorTheme.font.main),
          displayLargeBold: Font.displayLarge.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          title1Bold: Font.title1.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          title2Bold: Font.title2.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          title3Bold: Font.title3.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          headlineBold: Font.headline.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          bodyBold: Font.body.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          calloutBold: Font.callout.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          subheadBold: Font.subhead.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          footnoteBold: Font.footnote.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          caption1Bold: Font.caption1.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          caption2Bold: Font.caption2.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
