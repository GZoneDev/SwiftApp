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
        "aboutUsLableCustomList":
            MessageLookupByLibrary.simpleMessage("Про нас"),
        "accountQuestion":
            MessageLookupByLibrary.simpleMessage("Вже маєте акаунт?"),
        "callbackLableCustomList":
            MessageLookupByLibrary.simpleMessage("Зворотній зв\'язок"),
        "confirmEmailMessage": m0,
        "confirmPasswordChangeButton":
            MessageLookupByLibrary.simpleMessage("Підвердити зміну пароля"),
        "confirmPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("Підтвердження паролю"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Створити зараз"),
        "credentialAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "Аккаунт вже використовується"),
        "currentPlanLable":
            MessageLookupByLibrary.simpleMessage("Поточний план"),
        "displayLableCustomList":
            MessageLookupByLibrary.simpleMessage("Дисплей"),
        "duringFourteenDayTrialLable": MessageLookupByLibrary.simpleMessage(
            "\nпідписки безкоштовно протягом\n14-денного пробного періоду!"),
        "emailExistError": MessageLookupByLibrary.simpleMessage(
            "Цей електронний лист вже використовується"),
        "emailPlaceholder": MessageLookupByLibrary.simpleMessage("Email"),
        "forgottenPassword":
            MessageLookupByLibrary.simpleMessage("Забули пароль?"),
        "freePlan": MessageLookupByLibrary.simpleMessage("Безкоштовно"),
        "helpLableCustomList":
            MessageLookupByLibrary.simpleMessage("Повідомити про помилку"),
        "helpTitleList": MessageLookupByLibrary.simpleMessage("Підтримка"),
        "iconsLableCustomList":
            MessageLookupByLibrary.simpleMessage("Іконки додатку"),
        "infoLableCustomList":
            MessageLookupByLibrary.simpleMessage("Правова інформація"),
        "infoTitleList": MessageLookupByLibrary.simpleMessage("Інформація"),
        "invalidCharacterEnteredError":
            MessageLookupByLibrary.simpleMessage("Введено недійсний символ"),
        "invalidEmailError":
            MessageLookupByLibrary.simpleMessage("Недійсна пошта"),
        "invalidVerificationCodeError":
            MessageLookupByLibrary.simpleMessage("Невірний код підтвердження"),
        "langLableCustomList": MessageLookupByLibrary.simpleMessage("Мови"),
        "logOutLableCustomList": MessageLookupByLibrary.simpleMessage("Вийти"),
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
        "notificationLableCustomList":
            MessageLookupByLibrary.simpleMessage("Повідомлення"),
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
        "profilePageTitle": MessageLookupByLibrary.simpleMessage("Профіль"),
        "questionLableCustomList":
            MessageLookupByLibrary.simpleMessage("Поширені запитання"),
        "recomendLableCustomList":
            MessageLookupByLibrary.simpleMessage("Розповісти другу!"),
        "recomendTitleList":
            MessageLookupByLibrary.simpleMessage("Рекомендація"),
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
        "sendEmailMessage": MessageLookupByLibrary.simpleMessage(
            "Ми надіслали вам електронний лист. Будь ласка, перевірте свою поштову скриньку."),
        "smsCodePlaceholder":
            MessageLookupByLibrary.simpleMessage("Код підтвердження"),
        "starLableCustomList":
            MessageLookupByLibrary.simpleMessage("Оцінити додаток"),
        "systemTitleList": MessageLookupByLibrary.simpleMessage("Система"),
        "testAllFunctionLable":
            MessageLookupByLibrary.simpleMessage("Спробуйте всі функції"),
        "tryAgainButton":
            MessageLookupByLibrary.simpleMessage("Спробувати знову"),
        "tryAgainMessage":
            MessageLookupByLibrary.simpleMessage("Спробуйте знову через"),
        "trySubscribeButtonLable":
            MessageLookupByLibrary.simpleMessage("Спробувати"),
        "unknownPlan": MessageLookupByLibrary.simpleMessage("Невідомий"),
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
