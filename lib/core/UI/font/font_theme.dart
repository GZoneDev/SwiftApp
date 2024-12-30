import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FontTheme extends ThemeExtension<FontTheme> {
  final TextStyle? displayLarge;
  final TextStyle? title1;
  final TextStyle? title2;
  final TextStyle? title3;
  final TextStyle? headline;
  final TextStyle? body;
  final TextStyle? callout;
  final TextStyle? subhead;
  final TextStyle? footnote;
  final TextStyle? caption1;
  final TextStyle? caption2;
  final TextStyle? displayLargeBold;
  final TextStyle? title1Bold;
  final TextStyle? title2Bold;
  final TextStyle? title3Bold;
  final TextStyle? headlineBold;
  final TextStyle? bodyBold;
  final TextStyle? calloutBold;
  final TextStyle? subheadBold;
  final TextStyle? footnoteBold;
  final TextStyle? caption1Bold;
  final TextStyle? caption2Bold;

  FontTheme({
    this.displayLarge,
    this.title1,
    this.title2,
    this.title3,
    this.headline,
    this.body,
    this.callout,
    this.subhead,
    this.footnote,
    this.caption1,
    this.caption2,
    this.displayLargeBold,
    this.title1Bold,
    this.title2Bold,
    this.title3Bold,
    this.headlineBold,
    this.bodyBold,
    this.calloutBold,
    this.subheadBold,
    this.footnoteBold,
    this.caption1Bold,
    this.caption2Bold,
  });

  @override
  FontTheme copyWith({
    TextStyle? displayLarge,
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? title3,
    TextStyle? headline,
    TextStyle? body,
    TextStyle? callout,
    TextStyle? subhead,
    TextStyle? footnote,
    TextStyle? caption1,
    TextStyle? caption2,
    TextStyle? displayLargeBold,
    TextStyle? title1Bold,
    TextStyle? title2Bold,
    TextStyle? title3Bold,
    TextStyle? headlineBold,
    TextStyle? bodyBold,
    TextStyle? calloutBold,
    TextStyle? subheadBold,
    TextStyle? footnoteBold,
    TextStyle? caption1Bold,
    TextStyle? caption2Bold,
  }) {
    return FontTheme(
      displayLarge: displayLarge ?? this.displayLarge,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      headline: headline ?? this.headline,
      body: body ?? this.body,
      callout: callout ?? this.callout,
      subhead: subhead ?? this.subhead,
      footnote: footnote ?? this.footnote,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
      displayLargeBold: displayLargeBold ?? this.displayLargeBold,
      title1Bold: title1Bold ?? this.title1Bold,
      title2Bold: title2Bold ?? this.title2Bold,
      title3Bold: title3Bold ?? this.title3Bold,
      headlineBold: headlineBold ?? this.headlineBold,
      bodyBold: bodyBold ?? this.bodyBold,
      calloutBold: calloutBold ?? this.calloutBold,
      subheadBold: subheadBold ?? this.subheadBold,
      footnoteBold: footnoteBold ?? this.footnoteBold,
      caption1Bold: caption1Bold ?? this.caption1Bold,
      caption2Bold: caption2 ?? this.caption2Bold,
    );
  }

  @override
  FontTheme lerp(ThemeExtension<FontTheme>? other, double t) {
    if (other is! FontTheme) return this;
    return FontTheme(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t),
      title1: TextStyle.lerp(title1, other.title1, t),
      title2: TextStyle.lerp(title2, other.title2, t),
      title3: TextStyle.lerp(title3, other.title3, t),
      headline: TextStyle.lerp(headline, other.headline, t),
      body: TextStyle.lerp(body, other.body, t),
      callout: TextStyle.lerp(callout, other.callout, t),
      subhead: TextStyle.lerp(subhead, other.subhead, t),
      footnote: TextStyle.lerp(footnote, other.footnote, t),
      caption1: TextStyle.lerp(caption1, other.caption1, t),
      caption2: TextStyle.lerp(caption2, other.caption2, t),
      displayLargeBold:
          TextStyle.lerp(displayLargeBold, other.displayLargeBold, t),
      title1Bold: TextStyle.lerp(title1Bold, other.title1Bold, t),
      title2Bold: TextStyle.lerp(title2Bold, other.title2Bold, t),
      title3Bold: TextStyle.lerp(title3Bold, other.title3Bold, t),
      headlineBold: TextStyle.lerp(headlineBold, other.headlineBold, t),
      bodyBold: TextStyle.lerp(bodyBold, other.bodyBold, t),
      calloutBold: TextStyle.lerp(calloutBold, other.calloutBold, t),
      subheadBold: TextStyle.lerp(subheadBold, other.subheadBold, t),
      footnoteBold: TextStyle.lerp(footnoteBold, other.footnoteBold, t),
      caption1Bold: TextStyle.lerp(caption1Bold, other.caption1Bold, t),
      caption2Bold: TextStyle.lerp(caption2Bold, other.caption2Bold, t),
    );
  }
}

extension FontThemeExtension on BuildContext {
  FontTheme get font => Theme.of(this).extension<FontTheme>()!;
}

extension SafeTextStyle on TextStyle? {
  TextStyle get safe {
    if (this == null) {
      final errorLocation = StackTrace.current.toString().split('\n')[1];
      final error =
          'Error: NULL font used. Initialize variable in ThemeBuilder. \n$errorLocation';
      GetIt.I<Talker>().handle(error);
    }
    return this ?? TextStyle();
  }
}
