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

  /// `Email`
  String get emailPlaceholder {
    return Intl.message(
      'Email',
      name: 'emailPlaceholder',
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

  /// `The field must not be empty.`
  String get requiredError {
    return Intl.message(
      'The field must not be empty.',
      name: 'requiredError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsNoMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsNoMatchError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmailError {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmailError',
      desc: '',
      args: [],
    );
  }

  /// `The string must be at least {min} characters long`
  String minLineLengError(int min) {
    return Intl.message(
      'The string must be at least $min characters long',
      name: 'minLineLengError',
      desc: '',
      args: [min],
    );
  }

  /// `The string length must be no more than {max} characters.`
  String maxLineLengError(int max) {
    return Intl.message(
      'The string length must be no more than $max characters.',
      name: 'maxLineLengError',
      desc: '',
      args: [max],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passwordUppercaseError {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passwordUppercaseError',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter`
  String get passwordLowercaseError {
    return Intl.message(
      'Password must contain at least one lowercase letter',
      name: 'passwordLowercaseError',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passwordNumberError {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passwordNumberError',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character (_-./\)`
  String get passwordSpecialCharacterError {
    return Intl.message(
      'Password must contain at least one special character (_-./\\)',
      name: 'passwordSpecialCharacterError',
      desc: '',
      args: [],
    );
  }

  /// `Username must be at least {min} characters long`
  String minUsernameLengError(int min) {
    return Intl.message(
      'Username must be at least $min characters long',
      name: 'minUsernameLengError',
      desc: '',
      args: [min],
    );
  }

  /// `Oops, something went wrong`
  String get oopsTitle {
    return Intl.message(
      'Oops, something went wrong',
      name: 'oopsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgainButton {
    return Intl.message(
      'Try again',
      name: 'tryAgainButton',
      desc: '',
      args: [],
    );
  }

  /// `If the account “{email}” exists, instructions for verifying the email will be sent to your email.`
  String confirmEmailMessage(String email) {
    return Intl.message(
      'If the account “$email” exists, instructions for verifying the email will be sent to your email.',
      name: 'confirmEmailMessage',
      desc: '',
      args: [email],
    );
  }

  /// `User not verified`
  String get userNoVerifiedError {
    return Intl.message(
      'User not verified',
      name: 'userNoVerifiedError',
      desc: '',
      args: [],
    );
  }

  /// `User disabled`
  String get userDisabledError {
    return Intl.message(
      'User disabled',
      name: 'userDisabledError',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFoundError {
    return Intl.message(
      'User not found',
      name: 'userNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get wrongPasswordError {
    return Intl.message(
      'Wrong password',
      name: 'wrongPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get emailExistError {
    return Intl.message(
      'Email already in use',
      name: 'emailExistError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid verification code`
  String get invalidVerificationCodeError {
    return Intl.message(
      'Invalid verification code',
      name: 'invalidVerificationCodeError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid character entered`
  String get invalidCharacterEnteredError {
    return Intl.message(
      'Invalid character entered',
      name: 'invalidCharacterEnteredError',
      desc: '',
      args: [],
    );
  }

  /// `Send again`
  String get sendAgainButton {
    return Intl.message(
      'Send again',
      name: 'sendAgainButton',
      desc: '',
      args: [],
    );
  }

  /// `Weak password`
  String get weakPasswordError {
    return Intl.message(
      'Weak password',
      name: 'weakPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Account already in use`
  String get credentialAlreadyInUse {
    return Intl.message(
      'Account already in use',
      name: 'credentialAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Try again through`
  String get tryAgainMessage {
    return Intl.message(
      'Try again through',
      name: 'tryAgainMessage',
      desc: '',
      args: [],
    );
  }

  /// `We have sent you an email. Please check your email.`
  String get sendEmailMessage {
    return Intl.message(
      'We have sent you an email. Please check your email.',
      name: 'sendEmailMessage',
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
