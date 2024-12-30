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
      "Якщо обліковий запис “${email}” існує, на електронну пошту буде надіслано інструкцію з відновлення паролю.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountQuestion":
            MessageLookupByLibrary.simpleMessage("Вже маєте акаунт?"),
        "confirmPasswordChangeButton":
            MessageLookupByLibrary.simpleMessage("Підвердити зміну пароля"),
        "confirmPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("Підтвердження паролю"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Створити зараз"),
        "emailOrPhonePlaceholder":
            MessageLookupByLibrary.simpleMessage("Email/Телефон"),
        "forgottenPassword":
            MessageLookupByLibrary.simpleMessage("Забули пароль?"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Увійти"),
        "loginLink": MessageLookupByLibrary.simpleMessage("Увійти"),
        "loginSubtitle": MessageLookupByLibrary.simpleMessage(
            "Увійдіть до облікового запису"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Вхід"),
        "namePlaceholder": MessageLookupByLibrary.simpleMessage("Ім’я"),
        "newPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("Новий пароль"),
        "noAccountQuestion":
            MessageLookupByLibrary.simpleMessage("Не маєте акаунту?"),
        "passwordPlaceholder": MessageLookupByLibrary.simpleMessage("Пароль"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Створити"),
        "registerLink": MessageLookupByLibrary.simpleMessage("Зареєструватися"),
        "registerSubtitle":
            MessageLookupByLibrary.simpleMessage("Створіть новий акаунт"),
        "registerTitle": MessageLookupByLibrary.simpleMessage("Реєстрація"),
        "requiredEmailError":
            MessageLookupByLibrary.simpleMessage("Введіть пошту"),
        "restoreEmailMessage": m0,
        "restorePasswordButton":
            MessageLookupByLibrary.simpleMessage("Відновлення паролю"),
        "restorePasswordSubtitle": MessageLookupByLibrary.simpleMessage(
            "Введіть Email або номер телефону, який Ви використовували для реєстрації, і ми надішлемо Вам інструкцію"),
        "restorePasswordTitle":
            MessageLookupByLibrary.simpleMessage("Відновлення паролю"),
        "returnToLoginLink":
            MessageLookupByLibrary.simpleMessage("Повернутися до входу"),
        "smsCodePlaceholder":
            MessageLookupByLibrary.simpleMessage("Код підтвердження"),
        "smsSubtitle": MessageLookupByLibrary.simpleMessage(
            "На Ваш номер телефону відправлено SMS-повідомлення з кодом підтвердження для відновлення пароля"),
        "wantToCookQuestion":
            MessageLookupByLibrary.simpleMessage("Хочеш Щось Приготувати?")
      };
}
