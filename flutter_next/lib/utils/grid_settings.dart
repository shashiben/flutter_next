import 'flutter_next_config.dart';

/// Grid settings that use FlutterNext configuration.
class NextGridSettings {
  /// Number of columns in the grid system.
  /// This value is read from FlutterNext.noOfColumns.
  static int get numberOfColumns => FlutterNext.noOfColumns;

  /// Gutter size (spacing between columns).
  static double gutterSize = 16.0;

  /// Ratio of one column (1 / numberOfColumns).
  static double get oneColumnRatio => 1 / numberOfColumns;

  /// Configure grid settings.
  ///
  /// **Note:** For number of columns, use `FlutterNext.noOfColumns` directly.
  /// This method is kept for backward compatibility.
  ///
  /// **Example:**
  /// ```dart
  /// // Preferred way:
  /// FlutterNext.noOfColumns = 16;
  ///
  /// // Legacy way (still works):
  /// NextGridSettings.configure(columns: 16);
  /// ```
  static void configure({
    int? columns,
    double? gutter,
  }) {
    if (columns != null && columns > 0) {
      FlutterNext.noOfColumns = columns;
    }
    if (gutter != null && gutter >= 0) {
      gutterSize = gutter;
    }
  }
}
