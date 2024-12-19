import 'package:form_validator/form_validator.dart';

class TemplateValidate {
  static const int minPasswordLeng = 6;

  static ValidationBuilder _email() {
    return ValidationBuilder()
        .required('Введіть пошту ')
        .email('Недійсна пошта');
  }

  static ValidationBuilder _phone() {
    return ValidationBuilder()
        .required('Введіть дійсний номер телефону')
        .phone('Недійсний номер телефону');
  }

  static ValidationBuilder _password() {
    return ValidationBuilder()
        .required('Введіть пароль')
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

  static String? emailValidate(String? value) {
    final validateEmail = TemplateValidate._email().build();
    final result = validateEmail(value);
    return result;
  }

  static String? passwordValidate(String? value) {
    final validatePassword = TemplateValidate._password().build();
    final result = validatePassword(value);
    return result;
  }

  static String? phoneValidate(String? value) {
    final validatePhone = TemplateValidate._phone().build();
    final result = validatePhone(value);
    return result;
  }
}
