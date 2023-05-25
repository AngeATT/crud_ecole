import 'package:flutter/services.dart';

class CustomMaxValueInputFormatter extends TextInputFormatter {
  final double maxInputValue;
  CustomMaxValueInputFormatter({required this.maxInputValue});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    try {
      final double value = double.parse(newValue.text);
      if (value > maxInputValue) {
        truncated = maxInputValue.toString();
      }
    } catch (e) {
      //nothing to catch
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}
