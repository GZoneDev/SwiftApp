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

  static ValidationBuilder _password(S localization) {
    return ValidationBuilder()
        .required(localization.requiredError)
        .minLength(
            minPasswordLeng, localization.minPasswordLengError(minPasswordLeng))
        .regExp(RegExp(r'[A-Z]'), localization.passwordUppercaseError)
        .regExp(RegExp(r'[a-z]'), localization.passwordLowercaseError)
        .regExp(RegExp(r'[0-9]'), localization.passwordNumberError)
        .regExp(RegExp(r'^[a-zA-Z0-9]*$'),
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
