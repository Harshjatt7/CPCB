class Validations {
  final RegExp passRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final RegExp numbericWithDotRegex = RegExp('[0-9.]');
  final RegExp alphaNumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
  final RegExp gstRegex =
      RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9A-Z]{1}$');
  final RegExp dateRegex =
      RegExp(r'^(0[1-9]|[12]\d|3[01])(0[1-9]|1[0-2])\d{2}$');

  String? numbericWithDotValidation(String value) {
    String pattern = r'^\d*\.?\d*$';
    RegExp regExp = RegExp(pattern);
    if (value.toString().isEmpty) {
      return "Please provide a value";
    } else if (!regExp.hasMatch(value)) {
      return "Decimals cannot be repeated";
    }
    return null;
  }

  String? gstValidation(String value) {
    String pattern =
        r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (value.toString().isEmpty) {
      return "Please provide a value";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid GST number";
    }
    return null;
  }

  String? dateValidation(String value) {
    String pattern = r'^(((0[1-9])|([12][0-9])|(3[01]))-((0[0-9])|(1[012]))-((20[012]\d|19\d\d)|(1\d|2[3])))';
    RegExp regExp = RegExp(pattern);
    if (value.toString().isEmpty) {
      return "Please provide a Date";
    } else if (!regExp.hasMatch(value)) {
      return "Date Format DD-MM-YYYY";
    }
    return null;
  }
}
