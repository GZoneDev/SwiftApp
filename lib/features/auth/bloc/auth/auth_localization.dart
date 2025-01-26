import 'package:get_it/get_it.dart';
import 'package:receptico/features/auth/service/service.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AuthLocalizationHelper {
  static final Map<String, String Function(S)> _localizationMap = {
    AuthError.userNoVerified.name: (local) => local.userNoVerifiedError,
    AuthError.userDisabled.name: (local) => local.userDisabledError,
    AuthError.userNotFound.name: (local) => local.userNotFoundError,
    AuthError.resetUserNotFound.name: (local) => local.userNotFoundError,
    AuthError.invalidCredential.name: (local) => local.userNotFoundError,
    AuthError.wrongPassword.name: (local) => local.wrongPasswordError,
    AuthError.emailAlreadyInUse.name: (local) => local.emailExistError,
    AuthError.invalidEmail.name: (local) => local.invalidEmailError,
    AuthError.resetInvalidEmail.name: (local) => local.invalidEmailError,
    AuthError.weakPassword.name: (local) => local.weakPasswordError,
    AuthError.invalidVerificationId.name: (local) => local.userNoVerifiedError,
    EFormatError.invalidCharacter.name: (local) =>
        local.invalidCharacterEnteredError,
    EFormatError.invalidEmailFormat.name: (local) => local.invalidEmailError,
    EFormatError.missingLowercase.name: (local) => local.passwordLowercaseError,
    EFormatError.missingUppercase.name: (local) => local.passwordUppercaseError,
    EFormatError.missingNumber.name: (local) => local.passwordNumberError,
    EFormatError.requiredField.name: (local) => local.requiredError,
    //TODO: fix magic value
    EFormatError.tooShort.name: (local) => local.minPasswordLengError(6),
  };

  static String? localizate(String? key, S local) {
    if (key == null) return key;

    if (_localizationMap.containsKey(key)) {
      return _localizationMap[key]!(local);
    } else {
      final errorLocation = StackTrace.current.toString().split('\n')[1];
      final error =
          'Error: AuthLocalization key: $key does not exist. \n$errorLocation';
      GetIt.I<Talker>().critical(error);
      return key;
    }
  }
}
