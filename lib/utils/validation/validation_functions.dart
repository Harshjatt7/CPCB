class Validations {
  final RegExp passRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final RegExp numbericWithDotRegex = RegExp(r'^\d*\.?\d*$');
  final RegExp alphaNumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
  final RegExp gstRegex =
      RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9A-Z]{1}$');
  final RegExp dateRegex =
      RegExp(r'^(0[1-9]|[12]\d|3[01])(0[1-9]|1[0-2])\d{2}$');

  String? validateEmail(String value) {
    RegExp regex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$');

    if (value.isEmpty) {
      return 'Please enter email';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid email';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String value) {
    RegExp regex = RegExp(
        r'^(?!.*[\s])(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
}
