import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExDoublePoint = RegExp(r'^\d*\.?\d*');
    final regExStartingPoint = RegExp(r'^(?!\.).+');

    final String newDoublepointString =
        regExDoublePoint.stringMatch(newValue.text) ?? '';
    final String newStartingPointString =
        regExStartingPoint.stringMatch(newValue.text) ?? '';
    return newDoublepointString == newValue.text &&
            newStartingPointString == newValue.text
        ? newValue
        : oldValue;
  }
}
