String emailRegExp =
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

extension Validations on String {
  Function isRequired({String? errorText}) =>
      () => isEmpty ? errorText ?? "This Field is required" : null;

  Function isEmail({String? errorText}) => () => this == ""
      ? null
      : !RegExp(emailRegExp).hasMatch(this)
          ? errorText ?? "invalid Email address"
          : null;

  Function minLength(int min, {String? errorText}) => () => this == ""
      ? null
      : length < min
          ? errorText ?? "minimum length is $min characters"
          : null;

  Function maxLength(int max, {String? errorText}) => () => this == ""
      ? null
      : length > max
          ? errorText ?? "maximum length is $max characters"
          : null;

  Function lengthRange(int min, int max, {String? errorText}) =>
      () => this == ""
          ? null
          : length < min || length > max
              ? errorText ?? "length must be between $min & $max characters"
              : null;

  Function match(String? stringToMatch, {String? errorText}) => () => this == ""
      ? null
      : !RegExp("^$stringToMatch\$").hasMatch(this)
          ? errorText ?? "Values doesn't match"
          : null;

  Function matchPattern(String? regExp, {String? errorText}) => () => this == ""
      ? null
      : !RegExp(regExp!).hasMatch(this)
          ? errorText ?? "Pattern doesn't match"
          : null;

  Function isInt({String? errorText}) => () => this == ""
      ? null
      : int.tryParse(this) == null
          ? errorText ?? "invalid integer"
          : null;

  Function isDouble({String? errorText}) => () => this == ""
      ? null
      : double.tryParse(this) == null
          ? errorText ?? "invalid double"
          : null;

  Function min(int min, {String? errorText}) => () => this == ""
      ? null
      : double.tryParse(this) == null || double.parse(this) < min
          ? errorText ?? "Number must be bigger than $min"
          : null;

  Function max(int max, {String? errorText}) => () => this == ""
      ? null
      : double.tryParse(this) == null || double.parse(this) > max
          ? errorText ?? "Number must be smaller than $max"
          : null;

  Function range(int min, int max, {String? errorText}) => () => this == ""
      ? null
      : double.tryParse(this) == null &&
              double.parse(this) < min &&
              double.parse(this) > max
          ? errorText ?? "Number must be between $min & $max"
          : null;
}
