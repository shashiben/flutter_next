import 'dart:convert';

extension StringExtension on String {
  /// Returns capitalised string
  ///
  /// ```dart
  /// print('flutter'.capitalize()) // Flutter
  /// print('Flutter'.capitalize()) // Flutter
  /// ```
  String capitalize() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toUpperCase();
      default:
        return substring(0, 1).toUpperCase() + substring(1);
    }
  }

  ///Returns whether string can be converted to int or not
  bool isInt() {
    return int.tryParse(this) != null;
  }

  ///Returns whether string can be converted to double or not
  bool isDouble() {
    return double.tryParse(this) != null;
  }

  /// Parse [source] as a, possibly signed, integer literal.
  int? toInt({int? radix}) {
    return int.tryParse(this, radix: radix);
  }

  /// Parse [source] as an double literal and return its value.
  double? toDouble() {
    return double.tryParse(this);
  }

  ///Returns if string can be converted to json or not
  bool isJson() {
    try {
      jsonDecode(this);
      return true;
    } on FormatException catch (_) {
      return false;
    }
  }
}
