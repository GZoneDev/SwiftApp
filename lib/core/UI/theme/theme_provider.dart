import 'package:flutter/material.dart';
import 'package:receptico/core/UI/theme/themes/theme_dark.dart';
import 'package:receptico/core/UI/theme/themes/theme_light.dart';
import 'package:hive/hive.dart';

enum ETheme {
  light,
  dark,
  mix,
}

class ThemeProvider extends ChangeNotifier {
  static const settingThemekey = 'theme';
  final Map<ETheme, ThemeData> _themeMap = {
    ETheme.light: lightTheme,
    ETheme.dark: darkTheme,
    ETheme.mix: ThemeData.lerp(lightTheme, darkTheme, 50),
  };

  final Box settingBox;

  late ETheme _currentTheme;

  ThemeProvider({required this.settingBox}) {
    ETheme? saveTheme =
        settingBox.get(settingThemekey, defaultValue: ETheme.light);
    _currentTheme = saveTheme ?? ETheme.light;
  }

  set theme(ETheme value) {
    _currentTheme = value;
    settingBox.put(settingThemekey, value);
    notifyListeners();
  }

  ThemeData get currentTheme => _themeMap[_currentTheme]!;
}
