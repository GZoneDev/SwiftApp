import 'package:flutter/material.dart';
import 'package:receptico/common/valitation/validation_builder.dart';

class TemplateValidate {
  static const int minPasswordLeng = 6;
  BuildContext context;

  TemplateValidate(this.context);

  ValidationBuilder _email() {
    return ValidationBuilder()
        .required('Поле не має бути пустим')
        .email('Недійсна пошта');
  }

  ValidationBuilder _phone() {
    return ValidationBuilder()
        .required('Поле не має бути пустим')
        .phone('Недійсний номер телефону');
  }

  ValidationBuilder _password() {
    return ValidationBuilder()
        .required('Поле не має бути пустим')
        .minLength(minPasswordLeng,
            'Пароль має бути не менше $minPasswordLeng символів')
        .regExp(
            RegExp(r'[A-Z]'), 'Пароль має містити принаймні одну велику літеру')
        .regExp(
            RegExp(r'[a-z]'), 'Пароль має містити принаймні одну малу літеру')
        .regExp(RegExp(r'[0-9]'), 'Пароль повинен містити хоча б одне число')
        .regExp(RegExp(r'[\W_]'),
            'Пароль повинен містити хоча б один спеціальний символ');
  }

  ValidationBuilder _username() {
    return ValidationBuilder().required('Поле не має бути пустим').minLength(
        minPasswordLeng,
        'Ім’я не може бути меньшим ніж $minPasswordLeng символів');
  }

  String? emailOrPhoneValidate(String value) {
    final validateEmail = _email().build();
    final validatePhone = _phone().build();
    final resultEmail = validateEmail(value);
    final resultPhone = validatePhone(value);
    if (resultEmail == null) {
      return null;
    } else if (resultPhone == null) {
      return null;
    }

    return resultEmail ?? resultPhone;
  }

  String? emailValidate(String value) {
    final validateEmail = _email().build();
    final result = validateEmail(value);
    return result;
  }

  String? phoneValidate(String value) {
    final validatePhone = _phone().build();
    final result = validatePhone(value);
    return result;
  }

  String? passwordValidate(String value) {
    final validatePassword = _password().build();
    final result = validatePassword(value);
    return result;
  }

  String? usernameValidate(String value) {
    final validateUsername = _username().build();
    final result = validateUsername(value);
    return result;
  }
}
