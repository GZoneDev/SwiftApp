class ValidationBuilder {
  static final RegExp _defaultEmailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  static final RegExp _defaultPhoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');

  final List<String? Function(String)> _validators = [];

  ValidationBuilder add(String? Function(String) validator) {
    _validators.add(validator);
    return this;
  }

  ValidationBuilder required(String message) =>
      add((value) => value.isEmpty ? message : null);

  ValidationBuilder minLength(int minLengh, String message) =>
      add((value) => value.length < minLengh ? message : null);

  ValidationBuilder maxLength(int maxLengh, String message) =>
      add((value) => value.length > maxLengh ? message : null);

  ValidationBuilder regExp(RegExp regex, String message) =>
      add((value) => regex.hasMatch(value) ? null : message);

  ValidationBuilder email(String message) =>
      add((value) => _defaultEmailRegExp.hasMatch(value) ? null : message);

  ValidationBuilder phone(String message) =>
      add((value) => _defaultPhoneRegExp.hasMatch(value) ? null : message);

  String? Function(String) build() => validate;

  String? validate(String value) {
    for (var validator in _validators) {
      var result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
