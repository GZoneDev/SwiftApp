import 'package:email_validator/email_validator.dart';

class ValidationBuilder<T> {
  static final RegExp _defaultPhoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');

  final List<T? Function(String)> _validators = [];

  ValidationBuilder add(T? Function(String) validator) {
    _validators.add(validator);
    return this;
  }

  ValidationBuilder required(T message) =>
      add((value) => value.isEmpty ? message : null);

  ValidationBuilder minLength(int minLengh, T message) =>
      add((value) => value.length < minLengh ? message : null);

  ValidationBuilder maxLength(int maxLengh, T message) =>
      add((value) => value.length > maxLengh ? message : null);

  ValidationBuilder regExp(RegExp regex, T message) =>
      add((value) => regex.hasMatch(value) ? null : message);

  ValidationBuilder email(T message) =>
      add((value) => EmailValidator.validate(value) ? null : message);

  ValidationBuilder phone(T message) =>
      add((value) => _defaultPhoneRegExp.hasMatch(value) ? null : message);

  T? Function(String) build() => validate;

  T? validate(String value) {
    for (var validator in _validators) {
      var result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
