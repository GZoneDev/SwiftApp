import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  // Устанавливаем начальную локаль
  Locale _locale = _getInitialLocale();

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // Метод для определения начальной локали
  static Locale _getInitialLocale() {
    final Locale currentLocale =
        WidgetsBinding.instance.platformDispatcher.locale;

    // Если язык устройства русский, возвращаем украинский
    if (currentLocale.languageCode == 'ru') {
      return const Locale('uk');
    }

    // В противном случае используем локаль устройства
    return currentLocale;
  }
}
