import 'package:receptico/common/valitation/validation_builder.dart';
import 'package:receptico/features/auth/service/auth_validation_service.dart';

class AuthValidationServiceImpl implements AuthValidationService {
  static const minPasswordLength = 6;

  late final EFormatError? Function(String) _passwordValidator;
  late final EFormatError? Function(String) _emailValidator;
  late final EFormatError? Function(String) _usernameValidator;

  AuthValidationServiceImpl() {
    _emailValidator = (value) => _email().build()(value);
    _passwordValidator = (value) => _password().build()(value);
    _usernameValidator = (value) => _username().build()(value);
  }

  ValidationBuilder _email() {
    return ValidationBuilder<EFormatError>()
        .required(EFormatError.requiredField)
        .email(EFormatError.invalidEmailFormat);
  }

  ValidationBuilder _password() {
    return ValidationBuilder<EFormatError>()
        .required(EFormatError.requiredField)
        .minLength(minPasswordLength, EFormatError.tooShort)
        .regExp(RegExp(r'[A-Z]'), EFormatError.missingUppercase)
        .regExp(RegExp(r'[a-z]'), EFormatError.missingLowercase)
        .regExp(RegExp(r'[0-9]'), EFormatError.missingNumber)
        .regExp(RegExp(r'^[a-zA-Z0-9]*$'), EFormatError.invalidCharacter);
  }

  ValidationBuilder _username() {
    return ValidationBuilder<EFormatError>()
        .required(EFormatError.requiredField)
        .minLength(minPasswordLength, EFormatError.tooShort);
  }

  @override
  EFormatError? emailValidate(String? value) => _emailValidator(value ?? '');

  @override
  EFormatError? passwordValidate(String? value) =>
      _passwordValidator(value ?? '');

  @override
  EFormatError? usernameValidate(String? value) =>
      _usernameValidator(value ?? '');
}
