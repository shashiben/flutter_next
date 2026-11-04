import 'package:flutter/material.dart';

/// ✨ A handy extension for adding padding to any widget with ease!
extension PaddingExtension on Widget {
  /// 📏 Adds uniform padding to the widget on all sides.
  ///
  /// - `padding`: The amount of space to apply around the widget.
  /// - `key`: (Optional) A unique identifier for the padding widget.
  ///
  /// 📌 Example:
  /// ```dart
  /// Text('Hello').padding(16);
  /// ```
  Widget padding(double padding, {Key? key}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      key: key,
      child: this,
    );
  }

  /// ↔️↕️ Adds symmetric padding to the widget.
  ///
  /// - `horizontal`: Padding for the left and right sides (default: `0`).
  /// - `vertical`: Padding for the top and bottom sides (default: `0`).
  /// - `key`: (Optional) A unique identifier for the padding widget.
  ///
  /// 📌 Example:
  /// ```dart
  /// Text('Hello').symmetricPadding(horizontal: 12, vertical: 8);
  /// ```
  Widget symmetricPadding({
    double horizontal = 0.0,
    double vertical = 0.0,
    Key? key,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      key: key,
      child: this,
    );
  }

  /// 🎯 Adds precise custom padding to each side of the widget.
  ///
  /// - `left`: Padding on the left side (default: `0`).
  /// - `top`: Padding on the top side (default: `0`).
  /// - `right`: Padding on the right side (default: `0`).
  /// - `bottom`: Padding on the bottom side (default: `0`).
  /// - `key`: (Optional) A unique identifier for the padding widget.
  ///
  /// 📌 Example:
  /// ```dart
  /// Text('Hello').customPadding(left: 10, top: 5, right: 10, bottom: 5);
  /// ```
  Widget customPadding({
    Key? key,
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding:
          EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      key: key,
      child: this,
    );
  }

  /// 🔄 Conditionally applies padding **only if** the given condition is `true`.
  ///
  /// This method is useful when you need to apply padding dynamically based on a condition.
  ///
  /// - `condition`: A boolean that determines whether padding should be applied.
  /// - `padding`: The amount of space to apply around the widget if the condition is `true`.
  /// - `key`: (Optional) A unique identifier for the padding widget.
  ///
  /// 📌 Example:
  /// ```dart
  /// Text('Hello').ifPadding(isLargeScreen, 16);
  /// ```
  /// **Use case:**
  /// - Apply extra padding on larger screens while keeping the default layout for smaller screens.
  Widget ifPadding(bool condition, double padding, {Key? key}) {
    return condition ? this.padding(padding, key: key) : this;
  }

  /// 📏 Dynamically scales the padding based on a given factor.
  ///
  /// This method is useful when you need to **scale padding responsively** based on screen size, text size, or custom multipliers.
  ///
  /// - `padding`: The base `EdgeInsets` to be scaled.
  /// - `scaleFactor`: A multiplier to scale the padding dynamically.
  /// - `key`: (Optional) A unique identifier for the padding widget.
  ///
  /// 📌 Example:
  /// ```dart
  /// Text('Hello').expandedPadding(EdgeInsets.all(10), 1.5);
  /// ```
  /// **Use case:**
  /// - Increase padding proportionally when scaling UI elements for larger screens or accessibility settings.
  Widget expandedPadding(EdgeInsets padding, double scaleFactor, {Key? key}) {
    return Padding(
      padding: padding * scaleFactor,
      key: key,
      child: this,
    );
  }

  /// ✅ Ensures at least a **minimum padding** is applied to the widget.
  ///
  /// If `current` padding is provided, the method will apply the **greater** of `minPadding` and `current`.
  ///
  /// - `minPadding`: The minimum amount of padding that must be applied.
  /// - `current`: (Optional) A dynamically calculated padding value.
  /// - `key`: (Optional) A unique identifier for the padding widget.
  ///
  /// 📌 Example:
  /// ```dart
  /// Text('Hello').minPadding(8, screenPadding);
  /// ```
  /// **Use case:**
  /// - Ensure that padding never falls below a required threshold, even if it depends on dynamic values.
  Widget minPadding(double minPadding, [double? current, Key? key]) {
    final double appliedPadding = current != null
        ? current.clamp(minPadding, double.infinity)
        : minPadding;
    return Padding(
      padding: EdgeInsets.all(appliedPadding),
      key: key,
      child: this,
    );
  }
}
