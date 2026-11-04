/// ✨ A collection of utility methods for validating common string formats.
class NextValidations {
  /// 🔢 Checks if the given string is a **valid UUID**.
  ///
  /// - A UUID (Universally Unique Identifier) is a 36-character string with a specific format.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidUUID("123e4567-e89b-12d3-a456-426614174000");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Ensuring unique identifiers conform to UUID format.
  static bool isValidUUID(String uuid) {
    final regex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    return regex.hasMatch(uuid);
  }

  /// 🖧 Checks if the given string is a **valid MAC address**.
  ///
  /// - A MAC address consists of 6 pairs of hexadecimal digits separated by colons.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidMacAddress("00:1A:2B:3C:4D:5E");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Verifying hardware network addresses.
  static bool isValidMacAddress(String mac) {
    final regex = RegExp(r'^[0-9A-Fa-f]{2}(:[0-9A-Fa-f]{2}){5}$');
    return regex.hasMatch(mac);
  }

  /// 🌍 Checks if the given string is a **valid IPv4 address**.
  ///
  /// - IPv4 consists of four sets of numbers (0-255) separated by dots.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidIPv4("192.168.1.1");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Validating IP addresses in network applications.
  static bool isValidIPv4(String ip) {
    final regex = RegExp(
        r'^((25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.){3}(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$');
    return regex.hasMatch(ip);
  }

  /// 🌐 Checks if the given string is a **valid IPv6 address**.
  ///
  /// - IPv6 consists of eight groups of four hexadecimal digits separated by colons.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidIPv6("2001:0db8:85a3:0000:0000:8a2e:0370:7334");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Ensuring network compatibility with IPv6.
  static bool isValidIPv6(String ip) {
    final regex = RegExp(r'^([a-fA-F0-9]{1,4}:){7}[a-fA-F0-9]{1,4}$');
    return regex.hasMatch(ip);
  }

  /// 💳 Checks if the given string is a **valid credit card number**.
  ///
  /// - A valid card number typically has 13 to 19 digits.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidCreditCard("4111111111111111");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Validating credit/debit card inputs in payment forms.
  static bool isValidCreditCard(String number) {
    if (!RegExp(r'^[0-9]{13,19}$').hasMatch(number)) return false;
    var sum = 0;
    var alternate = false;
    for (var i = number.length - 1; i >= 0; i--) {
      var n = int.parse(number[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0 && sum > 0;
  }

  /// 📧 Checks if the given string is a **valid email address**.
  ///
  /// - An email must contain an `@` and a valid domain.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidEmail("user@example.com");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Ensuring email inputs conform to standard format.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

  /// 📱 Checks if the given string is a **valid phone number**.
  ///
  /// - Supports international formats with optional `+` at the beginning.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidPhoneNumber("+1234567890");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Ensuring phone numbers meet global dialing standards.
  static bool isValidPhoneNumber(String phone) {
    final regex = RegExp(r'^\+?[1-9]\d{1,14}$');
    return regex.hasMatch(phone);
  }

  /// 🔗 Checks if the given string is a **valid URL**.
  ///
  /// - A valid URL should have `http://` or `https://` and a domain.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isValidUrl("https://www.example.com");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Validating user-inputted URLs in web or mobile apps.
  static bool isValidUrl(String url) {
    final regex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    return regex.hasMatch(url);
  }

  /// 🔤 Checks if the given string contains **only alphanumeric characters**.
  ///
  /// - Alphanumeric means letters (A-Z, a-z) and numbers (0-9) only.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool result = NextValidations.isAlphanumeric("Flutter123");
  /// ```
  ///
  /// ✅ **Use case:**
  /// - Ensuring usernames, codes, or passwords contain only allowed characters.
  static bool isAlphanumeric(String input) {
    final regex = RegExp(r'^[a-zA-Z0-9]+$');
    return regex.hasMatch(input);
  }
}
