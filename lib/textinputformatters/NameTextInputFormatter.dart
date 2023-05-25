import 'package:flutter/services.dart';

class NameTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExDoubleSpace = RegExp(r'^(?!.*  ).+');
    final regExStartingSpace = RegExp(r'^(?! ).+');

    final String newDoubleSpaceString =
        regExDoubleSpace.stringMatch(newValue.text) ?? '';
    final String newStartingSpaceString =
        regExStartingSpace.stringMatch(newValue.text) ?? '';

    return newDoubleSpaceString == newValue.text &&
            newStartingSpaceString == newValue.text
        ? newValue
        : oldValue;
  }
}
