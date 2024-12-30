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

  /// `Password`
  String get passwordPlaceholder {
    return Intl.message(
      'Password',
      name: 'passwordPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgottenPassword {
    return Intl.message(
      'Forgot password?',
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

  /// `Sign up`
  String get registerTitle {
    return Intl.message(
      'Sign up',
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

  /// `Sign up`
  String get registerButton {
    return Intl.message(
      'Sign up',
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

  /// `Sign in`
  String get loginLink {
    return Intl.message(
      'Sign in',
      name: 'loginLink',
      desc: '',
      args: [],
    );
  }

  /// `Email/Phone`
  String get emailOrPhonePlaceholder {
    return Intl.message(
      'Email/Phone',
      name: 'emailOrPhonePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Restore password`
  String get restorePasswordButton {
    return Intl.message(
      'Restore password',
      name: 'restorePasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Return to login`
  String get returnToLoginLink {
    return Intl.message(
      'Return to login',
      name: 'returnToLoginLink',
      desc: '',
      args: [],
    );
  }

  /// `An SMS message with a confirmation code to recover your password has been sent to your phone number.`
  String get smsSubtitle {
    return Intl.message(
      'An SMS message with a confirmation code to recover your password has been sent to your phone number.',
      name: 'smsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPasswordPlaceholder {
    return Intl.message(
      'New password',
      name: 'newPasswordPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation code`
  String get smsCodePlaceholder {
    return Intl.message(
      'Confirmation code',
      name: 'smsCodePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordPlaceholder {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Change password `
  String get confirmPasswordChangeButton {
    return Intl.message(
      'Change password ',
      name: 'confirmPasswordChangeButton',
      desc: '',
      args: [],
    );
  }

  /// `Restore password`
  String get restorePasswordTitle {
    return Intl.message(
      'Restore password',
      name: 'restorePasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Email or phone number you used to register and we will send you instructions.`
  String get restorePasswordSubtitle {
    return Intl.message(
      'Enter the Email or phone number you used to register and we will send you instructions.',
      name: 'restorePasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `If the account {email} exists, password recovery instructions will be sent to your email.`
  String restoreEmailMessage(String email) {
    return Intl.message(
      'If the account $email exists, password recovery instructions will be sent to your email.',
      name: 'restoreEmailMessage',
      desc: '',
      args: [email],
    );
  }

  /// `Введіть пошту`
  String get requiredEmailError {
    return Intl.message(
      'Введіть пошту',
      name: 'requiredEmailError',
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
