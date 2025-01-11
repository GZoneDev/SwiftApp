// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(email) =>
      "If the account “${email}” exists, instructions for verifying the email will be sent to your email.";

  static String m1(min) => "Password must be at least ${min} characters long";

  static String m2(min) => "Username must be at least ${min} characters long";

  static String m3(email) =>
      "If the account ${email} exists, password recovery instructions will be sent to your email.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountQuestion":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "confirmEmailMessage": m0,
        "confirmPasswordChangeButton":
            MessageLookupByLibrary.simpleMessage("Change password "),
        "confirmPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create now"),
        "credentialAlreadyInUse":
            MessageLookupByLibrary.simpleMessage("Account already in use"),
        "emailExistError":
            MessageLookupByLibrary.simpleMessage("Email already in use"),
        "emailPlaceholder": MessageLookupByLibrary.simpleMessage("Email"),
        "forgottenPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "invalidCharacterEnteredError":
            MessageLookupByLibrary.simpleMessage("Invalid character entered"),
        "invalidEmailError":
            MessageLookupByLibrary.simpleMessage("Invalid email"),
        "invalidVerificationCodeError":
            MessageLookupByLibrary.simpleMessage("Invalid verification code"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "loginLink": MessageLookupByLibrary.simpleMessage("Sign in"),
        "loginSubtitle":
            MessageLookupByLibrary.simpleMessage("Log in to your account"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Sign in"),
        "minPasswordLengError": m1,
        "minUsernameLengError": m2,
        "namePlaceholder": MessageLookupByLibrary.simpleMessage("Name"),
        "newPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("New password"),
        "noAccountQuestion":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "oopsTitle":
            MessageLookupByLibrary.simpleMessage("Oops, something went wrong"),
        "passwordLowercaseError": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one lowercase letter"),
        "passwordNumberError": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one number"),
        "passwordPlaceholder": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordSpecialCharacterError": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one special character (_-./\\)"),
        "passwordUppercaseError": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one uppercase letter"),
        "passwordsNoMatchError":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Sign up"),
        "registerLink": MessageLookupByLibrary.simpleMessage("Sign up"),
        "registerSubtitle":
            MessageLookupByLibrary.simpleMessage("Create a new account"),
        "registerTitle": MessageLookupByLibrary.simpleMessage("Sign up"),
        "requiredError": MessageLookupByLibrary.simpleMessage(
            "The field must not be empty."),
        "restoreEmailMessage": m3,
        "restorePasswordButton":
            MessageLookupByLibrary.simpleMessage("Restore password"),
        "restorePasswordSubtitle": MessageLookupByLibrary.simpleMessage(
            "Enter the Email or phone number you used to register and we will send you instructions."),
        "restorePasswordTitle":
            MessageLookupByLibrary.simpleMessage("Restore password"),
        "returnToLoginLink":
            MessageLookupByLibrary.simpleMessage("Return to login"),
        "sendAgainButton": MessageLookupByLibrary.simpleMessage("Send again"),
        "smsCodePlaceholder":
            MessageLookupByLibrary.simpleMessage("Confirmation code"),
        "tryAgainButton": MessageLookupByLibrary.simpleMessage("Try again"),
        "tryAgainMessage":
            MessageLookupByLibrary.simpleMessage("Try again through"),
        "userDisabledError":
            MessageLookupByLibrary.simpleMessage("User disabled"),
        "userNoVerifiedError":
            MessageLookupByLibrary.simpleMessage("User not verified"),
        "userNotFoundError":
            MessageLookupByLibrary.simpleMessage("User not found"),
        "wantToCookQuestion": MessageLookupByLibrary.simpleMessage(
            "Do you want to cook something?"),
        "weakPasswordError":
            MessageLookupByLibrary.simpleMessage("Weak password"),
        "wrongPasswordError":
            MessageLookupByLibrary.simpleMessage("Wrong password")
      };
}
