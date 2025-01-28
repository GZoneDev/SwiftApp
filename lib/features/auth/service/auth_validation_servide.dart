import 'package:receptico/common/valitation/validation_builder.dart';
import 'package:receptico/generated/l10n.dart';

abstract interface class IAuthValidation {
  String? emailValidate(String? value);
}

class AuthValidationService {
  static const minPasswordLeng = 6;

  AuthValidationService();

  ValidationBuilder _email(S localization) {
    return ValidationBuilder()
        .required(localization.requiredError)
        .email(localization.invalidEmailError);
  }

  ValidationBuilder _password(S localization) {
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

  ValidationBuilder _username(S localization) {
    return ValidationBuilder().required(localization.requiredError).minLength(
        minPasswordLeng, localization.minUsernameLengError(minPasswordLeng));
  }

  String? emailValidate(String? value, S localization) {
    final validateEmail = _email(localization).build();
    final result = validateEmail(value ?? '');
    return result;
  }

  String? passwordValidate(String? value, S localization) {
    final validatePassword = _password(localization).build();
    final result = validatePassword(value ?? '');
    return result;
  }

  String? usernameValidate(String? value, S localization) {
    final validateUsername = _username(localization).build();
    final result = validateUsername(value ?? '');
    return result;
  }
}
