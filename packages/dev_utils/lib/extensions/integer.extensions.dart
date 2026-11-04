import 'package:flutter/widgets.dart';

/// ✨ Extension for adding custom utilities to the [num] type for widget-related sizing.
extension WidgetExtensions on num {
  /// 📏 Creates a vertical `SizedBox` with the given height.
  ///
  /// This method is useful for adding **vertical spacing** between widgets.
  ///
  /// - The height of the `SizedBox` is set to the value of this number.
  ///
  /// 📌 Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text('Above'),
  ///     10.verticalBox, // Adds 10 pixels of vertical spacing
  ///     Text('Below'),
  ///   ],
  /// );
  /// ```
  Widget get verticalBox => SizedBox(height: toDouble());

  /// 📏 Creates a horizontal `SizedBox` with the given width.
  ///
  /// This method is useful for adding **horizontal spacing** between widgets.
  ///
  /// - The width of the `SizedBox` is set to the value of this number.
  ///
  /// 📌 Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Icon(Icons.star),
  ///     8.horizontalBox, // Adds 8 pixels of horizontal spacing
  ///     Text('Favorite'),
  ///   ],
  /// );
  /// ```
  Widget get horizontalBox => SizedBox(width: toDouble());
}

/// ✨ Extension for adding asynchronous utilities to the [num] type for delayed operations.
extension AsyncExtensions on num {
  /// ⏳ Delays execution for the given number of seconds or milliseconds.
  ///
  /// This method allows you to delay execution by using a **numeric value** directly.
  ///
  /// - If the number is an `int`, it is treated as **seconds**.
  /// - If the number is a `double`, it is treated as **fractional seconds**.
  ///
  /// 📌 Example:
  /// ```dart
  /// await 2.delayed(); // Waits for 2 seconds
  /// await 1.5.delayed(); // Waits for 1.5 seconds (1500ms)
  /// print('Executed after delay');
  /// ```
  ///
  /// **Use case:**
  /// - Simulating network requests or async operations.
  /// - Adding delays before UI updates, animations, or API calls.
  Future<void> delayed() async {
    await Future<void>.delayed(Duration(milliseconds: (this * 1000).toInt()));
  }
}
