// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(email) =>
      "Якщо обліковий запис “${email}” існує, на електронну пошту буде надіслано інструкцію з підтвердження пошти.";

  static String m1(min) => "Пароль має бути не менше ${min} символів";

  static String m2(min) => "Ім’я не може бути меньшим ніж ${min} символів";

  static String m3(email) =>
      "Якщо обліковий запис “${email}” існує, на електронну пошту буде надіслано інструкцію з відновлення паролю.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountQuestion":
            MessageLookupByLibrary.simpleMessage("Вже маєте акаунт?"),
        "confirmEmailMessage": m0,
        "confirmPasswordChangeButton":
            MessageLookupByLibrary.simpleMessage("Підвердити зміну пароля"),
        "confirmPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("Підтвердження паролю"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Створити зараз"),
        "credentialAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "Аккаунт вже використовується"),
        "emailExistError": MessageLookupByLibrary.simpleMessage(
            "Цей електронний лист вже використовується"),
        "emailPlaceholder": MessageLookupByLibrary.simpleMessage("Email"),
        "forgottenPassword":
            MessageLookupByLibrary.simpleMessage("Забули пароль?"),
        "invalidCharacterEnteredError":
            MessageLookupByLibrary.simpleMessage("Введено недійсний символ"),
        "invalidEmailError":
            MessageLookupByLibrary.simpleMessage("Недійсна пошта"),
        "invalidVerificationCodeError":
            MessageLookupByLibrary.simpleMessage("Невірний код підтвердження"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Увійти"),
        "loginLink": MessageLookupByLibrary.simpleMessage("Увійти"),
        "loginSubtitle": MessageLookupByLibrary.simpleMessage(
            "Увійдіть до облікового запису"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Вхід"),
        "minPasswordLengError": m1,
        "minUsernameLengError": m2,
        "namePlaceholder": MessageLookupByLibrary.simpleMessage("Ім’я"),
        "newPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("Новий пароль"),
        "noAccountQuestion":
            MessageLookupByLibrary.simpleMessage("Не маєте акаунту?"),
        "oopsTitle":
            MessageLookupByLibrary.simpleMessage("Ой, щось пішло не так"),
        "passwordLowercaseError": MessageLookupByLibrary.simpleMessage(
            "Пароль має містити принаймні одну малу літеру"),
        "passwordNumberError": MessageLookupByLibrary.simpleMessage(
            "Пароль повинен містити хоча б одне число"),
        "passwordPlaceholder": MessageLookupByLibrary.simpleMessage("Пароль"),
        "passwordSpecialCharacterError": MessageLookupByLibrary.simpleMessage(
            "Пароль повинен містити хоча б один спеціальний символ (_-./\\)"),
        "passwordUppercaseError": MessageLookupByLibrary.simpleMessage(
            "Пароль має містити принаймні одну велику літеру"),
        "passwordsNoMatchError":
            MessageLookupByLibrary.simpleMessage("Паролі не співпадають"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Створити"),
        "registerLink": MessageLookupByLibrary.simpleMessage("Зареєструватися"),
        "registerSubtitle":
            MessageLookupByLibrary.simpleMessage("Створіть новий акаунт"),
        "registerTitle": MessageLookupByLibrary.simpleMessage("Реєстрація"),
        "requiredError":
            MessageLookupByLibrary.simpleMessage("Поле не має бути пустим"),
        "restoreEmailMessage": m3,
        "restorePasswordButton":
            MessageLookupByLibrary.simpleMessage("Відновлення паролю"),
        "restorePasswordSubtitle": MessageLookupByLibrary.simpleMessage(
            "Введіть Email або номер телефону, який Ви використовували для реєстрації, і ми надішлемо Вам інструкцію"),
        "restorePasswordTitle":
            MessageLookupByLibrary.simpleMessage("Відновлення паролю"),
        "returnToLoginLink":
            MessageLookupByLibrary.simpleMessage("Повернутися до входу"),
        "sendAgainButton":
            MessageLookupByLibrary.simpleMessage("Надіслати знову"),
        "smsCodePlaceholder":
            MessageLookupByLibrary.simpleMessage("Код підтвердження"),
        "tryAgainButton":
            MessageLookupByLibrary.simpleMessage("Спробувати знову"),
        "tryAgainMessage":
            MessageLookupByLibrary.simpleMessage("Спробуйте знову через"),
        "userDisabledError":
            MessageLookupByLibrary.simpleMessage("Користувач заблокований"),
        "userNoVerifiedError":
            MessageLookupByLibrary.simpleMessage("Користувача не підтверджено"),
        "userNotFoundError":
            MessageLookupByLibrary.simpleMessage("Користувача не знайдено"),
        "wantToCookQuestion":
            MessageLookupByLibrary.simpleMessage("Хочеш Щось Приготувати?"),
        "weakPasswordError":
            MessageLookupByLibrary.simpleMessage("Слабкий пароль"),
        "wrongPasswordError":
            MessageLookupByLibrary.simpleMessage("Невірний пароль")
      };
}
