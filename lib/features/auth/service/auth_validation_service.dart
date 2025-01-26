enum EFormatError {
  requiredField,
  tooShort,
  tooLong,

  invalidEmailFormat,

  missingUppercase,
  missingLowercase,
  missingNumber,
  invalidCharacter,
}

abstract interface class AuthValidationService {
  EFormatError? emailValidate(String? value);
  EFormatError? passwordValidate(String? value);
  EFormatError? usernameValidate(String? value);
}
