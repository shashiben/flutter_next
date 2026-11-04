/// ✨ Extension on [bool] to provide additional utility methods.
extension BoolExtension on bool {
  /// 🔄 Toggles the boolean value.
  ///
  /// Returns `true` if the original value was `false`, and vice versa.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool isEnabled = true;
  /// isEnabled = isEnabled.toggle(); // Now, isEnabled is false.
  /// ```
  ///
  /// **Use case:**
  /// - Easily switching between two states (e.g., dark mode, toggles, selections).
  bool toggle() => !this;

  /// 🔢 Converts the boolean value to an integer.
  ///
  /// - Returns `1` if the value is `true`.
  /// - Returns `0` if the value is `false`.
  ///
  /// 📌 Example:
  /// ```dart
  /// bool isActive = true;
  /// int activeStatus = isActive.toInt(); // activeStatus = 1
  /// ```
  ///
  /// **Use case:**
  /// - Storing boolean values in databases or APIs that expect integers (e.g., `1` for `true`, `0` for `false`).
  int toInt() => this ? 1 : 0;

  /// 🔄 Returns a specific string representation based on the boolean value.
  ///
  /// - Accepts `trueValue` (default: `"True"`) and `falseValue` (default: `"False"`).
  ///
  /// 📌 Example:
  /// ```dart
  /// bool isAvailable = false;
  /// String availability = isAvailable.toStringValue("Available", "Not Available"); // "Not Available"
  /// ```
  ///
  /// **Use case:**
  /// - Customizing string outputs for different states.
  String toStringValue(String trueValue, String falseValue) =>
      this ? trueValue : falseValue;
}
