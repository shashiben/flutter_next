/// Extension on [bool] to provide additional functionality.
extension BoolExtension on bool {
  /// Toggles the boolean value.
  ///
  /// Returns `true` if the original value was `false`, and vice versa.
  bool toggle() {
    return !this;
  }

  /// Converts the boolean value to an integer.
  ///
  /// Returns `1` if the value is `true`, and `0` if the value is `false`.
  int toInt() {
    return this ? 1 : 0;
  }
}
