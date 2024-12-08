import 'package:form_validator/form_validator.dart';

class TemplateValidate {
  static const int minPasswordLeng = 6;

  static ValidationBuilder _email() {
    return ValidationBuilder()
        .required('Поле не має бути пустим')
        .email('Невірний формат');
  }

  static ValidationBuilder _phone() {
    return ValidationBuilder()
        .required('Поле не має бути пустим')
        .phone('Не вірний формат телефона');
  }

  static ValidationBuilder _password() {
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
