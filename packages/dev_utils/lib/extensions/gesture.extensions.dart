import 'package:flutter/material.dart';

/// ✨ Extension on [Widget] to add gesture handling with a cleaner syntax.
extension GestureExtension on Widget {
  /// 👆 Wraps the widget with an `InkWell` to handle tap gestures.
  ///
  /// This provides a **convenient way** to add an `onTap` interaction.
  ///
  /// ---
  /// 📝 **Example Usage**
  /// ```dart
  /// Text("Tap Me").onTap(() {
  ///   print("Widget tapped!");
  /// });
  /// ```
  /// ---
  ///
  /// ✅ **Use Cases:**
  /// - Making any widget **clickable**.
  /// - Simplifying gesture handling for **buttons, cards, or icons**.
  ///
  /// ---
  ///
  /// **🔹 Parameters:**
  /// - `onTap` 🖱 *(required)*: Callback function triggered when the widget is tapped.
  /// - `autoFocus` 🎯 *(default: `false`)*: Automatically focuses the widget when rendered.
  ///
  Widget onTap(void Function() onTap, {bool autoFocus = false}) {
    return GestureDetector(
      onTap: onTap,
      child: autoFocus ? Focus(autofocus: true, child: this) : this,
    );
  }

  /// 👆 Wraps the widget with an `InkWell` to handle **double-tap** gestures.
  ///
  /// ---
  /// 📝 **Example Usage**
  /// ```dart
  /// Text("Double-Tap Me").onDoubleTap(() {
  ///   print("Widget double-tapped!");
  /// });
  /// ```
  /// ---
  ///
  /// ✅ **Use Cases:**
  /// - Handling **double-tap** interactions for UI elements.
  /// - Implementing **custom actions** like zooming or toggling.
  ///
  /// ---
  ///
  /// **🔹 Parameters:**
  /// - `onDoubleTap` 🖱 *(required)*: Callback function triggered when the widget is double-tapped.
  /// - `autoFocus` 🎯 *(default: `false`)*: Automatically focuses the widget when rendered.
  ///
  Widget onDoubleTap(void Function() onDoubleTap, {bool autoFocus = false}) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: autoFocus ? Focus(autofocus: true, child: this) : this,
    );
  }

  /// 🤲 Wraps the widget with an `InkWell` to handle **long press** gestures.
  ///
  /// ---
  /// 📝 **Example Usage**
  /// ```dart
  /// Text("Long Press Me").onLongPress(() {
  ///   print("Widget long-pressed!");
  /// });
  /// ```
  /// ---
  ///
  /// ✅ **Use Cases:**
  /// - Triggering **context menus or tooltips** on long press.
  /// - Implementing **drag or selection behavior**.
  ///
  /// ---
  ///
  /// **🔹 Parameters:**
  /// - `onLongPress` 🤲 *(required)*: Callback function triggered when the widget is long-pressed.
  /// - `autoFocus` 🎯 *(default: `false`)*: Automatically focuses the widget when rendered.
  ///
  Widget onLongPress(void Function() onLongPress, {bool autoFocus = false}) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: autoFocus ? Focus(autofocus: true, child: this) : this,
    );
  }
}
