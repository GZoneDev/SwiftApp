// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in`
  String get loginTitle {
    return Intl.message(
      'Sign in',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in to your account`
  String get loginSubtitle {
    return Intl.message(
      'Log in to your account',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailPlaceholder {
    return Intl.message(
      'Email',
      name: 'emailPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordPlaceholder {
    return Intl.message(
      'Password',
      name: 'passwordPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgottenPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgottenPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get loginButton {
    return Intl.message(
      'Sign in',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccountQuestion {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Create now`
  String get createAccount {
    return Intl.message(
      'Create now',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cook something?`
  String get wantToCookQuestion {
    return Intl.message(
      'Do you want to cook something?',
      name: 'wantToCookQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get registerLink {
    return Intl.message(
      'Sign up',
      name: 'registerLink',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registerTitle {
    return Intl.message(
      'Registration',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create a new account`
  String get registerSubtitle {
    return Intl.message(
      'Create a new account',
      name: 'registerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get namePlaceholder {
    return Intl.message(
      'Name',
      name: 'namePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phonePlaceholder {
    return Intl.message(
      'Phone number',
      name: 'phonePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get registerButton {
    return Intl.message(
      'Create',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get accountQuestion {
    return Intl.message(
      'Already have an account?',
      name: 'accountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get loginLink {
    return Intl.message(
      'Log in',
      name: 'loginLink',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
