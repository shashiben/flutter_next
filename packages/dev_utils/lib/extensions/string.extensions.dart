import 'dart:convert';

extension StringExtensions on String {
  /// Returns the string with the first letter capitalized.
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

  /// Returns `true` if the string can be converted to an integer, `false` otherwise.
  bool isInt() {
    return int.tryParse(this) != null;
  }

  /// Returns `true` if the string can be converted to a double, `false` otherwise.
  bool isDouble() {
    return double.tryParse(this) != null;
  }

  /// Tries to parse the string as an integer and returns the result.
  ///
  /// Returns `null` if the string cannot be parsed as an integer.
  int? toInt({int? radix}) {
    return int.tryParse(this, radix: radix);
  }

  /// Tries to parse the string as a double and returns the result.
  ///
  /// Returns `null` if the string cannot be parsed as a double.
  double? toDouble() {
    return double.tryParse(this);
  }

  /// Returns `true` if the string can be parsed as a JSON object, `false` otherwise.
  bool isJson() {
    try {
      jsonDecode(this);
      return true;
    } on FormatException catch (_) {
      return false;
    }
  }

  /// Returns `true` if the string is blank or empty, `false` otherwise.
  bool isBlank() {
    return trim().isEmpty;
  }

  bool get isStrongPassword {
    final password = this;
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigits = RegExp(r'\d').hasMatch(password);
    final hasSpecialCharacters = RegExp(
      r'[!@#$%^&*(),.?":{}|<>]',
    ).hasMatch(password);
    final isValidLength = password.length >= 8;

    return hasUpperCase &&
        hasLowerCase &&
        hasDigits &&
        hasSpecialCharacters &&
        isValidLength;
  }

  // Optionally, provide a helper to give feedback
  String get passwordStrengthFeedback {
    if (length < 8) {
      return 'Password too short, must be at least 8 characters.';
    } else if (!RegExp(r'[A-Z]').hasMatch(this)) {
      return 'Password must contain at least one uppercase letter.';
    } else if (!RegExp(r'[a-z]').hasMatch(this)) {
      return 'Password must contain at least one lowercase letter.';
    } else if (!RegExp(r'\d').hasMatch(this)) {
      return 'Password must contain at least one number.';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this)) {
      return 'Password must contain at least one special character.';
    } else {
      return 'Password is strong!';
    }
  }

  /// Converts a kebab-case string to camelCase.
  ///
  /// Example:
  /// ```dart
  /// 'hello-world'.toCamelCase();  // helloWorld
  /// ```
  String get toCamelCase {
    final words = split('-');
    final firstWord = words.first.toLowerCase();
    final remainingWords = words.skip(1).map((word) => word.capitalize());
    return [firstWord, ...remainingWords].join();
  }

  /// Converts a kebab-case string to PascalCase.
  ///
  /// Example:
  /// ```dart
  /// 'hello-world'.toPascalCase();  // HelloWorld
  /// ```
  String get toPascalCase {
    final words = split('-');
    final capitalizedWords = words.map((word) => word.capitalize());
    return capitalizedWords.join();
  }

  /// Converts a snake_case string to camelCase.
  ///
  /// Example:
  /// ```dart
  /// 'hello_world'.toCamelCase();  // helloWorld
  /// ```
  String get toSnakeToCamelCase {
    final words = split('_');
    final firstWord = words.first.toLowerCase();
    final remainingWords = words.skip(1).map((word) => word.capitalize());
    return [firstWord, ...remainingWords].join();
  }

  /// Converts a snake_case string to PascalCase.
  ///
  /// Example:
  /// ```dart
  /// 'hello_world'.toPascalCase();  // HelloWorld
  /// ```
  String get toSnakeToPascalCase {
    final words = split('_');
    final capitalizedWords = words.map((word) => word.capitalize());
    return capitalizedWords.join();
  }

  /// Capitalizes the first letter of each word in the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeAllWords();  // Hello World
  /// ```
  String get capitalizeAllWords {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Trims leading and trailing spaces from the string.
  ///
  /// Example:
  /// ```dart
  /// '   hello   '.trimWhitespace();  // hello
  /// ```
  String get trimWhitespace => trim();

  /// Converts a string to title case (capitalizing each word).
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.toTitleCase();  // Hello World
  /// ```
  String get toTitleCase {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Returns true if the string is null or empty.
  ///
  /// Example:
  /// ```dart
  /// String? name;
  /// name.isNullOrEmpty;  // true
  /// ```
  bool get isNullOrEmpty => isEmpty;
}
