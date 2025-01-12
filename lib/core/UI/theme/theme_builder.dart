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
        errorStyle: EFont.caption1.textStyle(color: colorTheme.font.error),
        hintStyle: EFont.body.textStyle(color: colorTheme.font.hint),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            EFont.body.textStyle(color: colorTheme.font.elevatedButton),
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
          textStyle: WidgetStateProperty.all(EFont.headline.textStyle()),
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
          displayLarge: EFont.title1.textStyle(color: colorTheme.font.main),
          title1: EFont.title1.textStyle(color: colorTheme.font.main),
          title2: EFont.title2.textStyle(color: colorTheme.font.main),
          title3: EFont.title3.textStyle(color: colorTheme.font.main),
          headline: EFont.headline.textStyle(color: colorTheme.font.main),
          body: EFont.body.textStyle(color: colorTheme.font.main),
          callout: EFont.callout.textStyle(color: colorTheme.font.main),
          subhead: EFont.subhead.textStyle(color: colorTheme.font.main),
          footnote: EFont.footnote.textStyle(color: colorTheme.font.main),
          caption1: EFont.caption1.textStyle(color: colorTheme.font.main),
          caption2: EFont.caption2.textStyle(color: colorTheme.font.main),
          displayLargeBold: EFont.displayLarge.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          title1Bold: EFont.title1.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          title2Bold: EFont.title2.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          title3Bold: EFont.title3.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          headlineBold: EFont.headline.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          bodyBold: EFont.body.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          calloutBold: EFont.callout.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          subheadBold: EFont.subhead.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          footnoteBold: EFont.footnote.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          caption1Bold: EFont.caption1.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
          caption2Bold: EFont.caption2.textStyle(
              color: colorTheme.font.main, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
