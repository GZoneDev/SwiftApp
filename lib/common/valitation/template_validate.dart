import 'package:receptico/common/valitation/validation_builder.dart';
import 'package:receptico/generated/l10n.dart';

class TemplateValidate {
  static const _defoult = '';
  static const int minPasswordLeng = 6;

  static ValidationBuilder _email(S localization) {
    return ValidationBuilder()
        .required(localization.requiredError)
        .email(localization.invalidEmailError);
  }

  static ValidationBuilder _phone(S localization) {
    return ValidationBuilder()
        .required(localization.requiredError)
        .phone(localization.invalidPhoneError);
  }

  static ValidationBuilder _password(S localization) {
    return ValidationBuilder()
        .required(localization.requiredError)
        .minLength(
            minPasswordLeng, localization.minPasswordLengError(minPasswordLeng))
        .regExp(RegExp(r'[A-Z]'), localization.passwordUppercaseError)
        .regExp(RegExp(r'[a-z]'), localization.passwordLowercaseError)
        .regExp(RegExp(r'[0-9]'), localization.passwordNumberError)
        .regExp(
            RegExp(r'[._\/\\-]'), localization.passwordSpecialCharacterError)
        .regExp(RegExp(r'^[a-zA-Z0-9._\/\\-]*$'),
            localization.invalidCharacterEnteredError);
  }

  static ValidationBuilder _username(S localization) {
    return ValidationBuilder().required(localization.requiredError).minLength(
        minPasswordLeng, localization.minUsernameLengError(minPasswordLeng));
  }

  static String? emailValidate(String? value, S localization) {
    final validateEmail = _email(localization).build();
    final result = validateEmail(value ?? _defoult);
    return result;
  }

  static String? phoneValidate(String? value, S localization) {
    final validatePhone = _phone(localization).build();
    final result = validatePhone(value ?? _defoult);
    return result;
  }

  static String? emailOrPhoneValidate(String? value, S localization) {
    final emailEror = emailValidate(value, localization);
    final phoneError = phoneValidate(value, localization);

    return emailEror == null || phoneError == null ? null : emailEror;
  }

  static String? passwordValidate(String? value, S localization) {
    final validatePassword = _password(localization).build();
    final result = validatePassword(value ?? _defoult);
    return result;
  }

  static String? usernameValidate(String? value, S localization) {
    final validateUsername = _username(localization).build();
    final result = validateUsername(value ?? _defoult);
    return result;
  }
}
