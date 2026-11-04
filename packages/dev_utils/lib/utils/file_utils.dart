/// A Utility class for file-related operations.
class FileUtils {
  /// Converts a file size in bytes to a human-readable format.
  ///
  /// Units step by 1000. The optional [round] parameter is the number of
  /// decimal places above bytes (default is 2).
  ///
  /// Examples:
  /// ```dart
  /// FileUtils.getFileSize(0); // '0 B'
  /// FileUtils.getFileSize(1000); // '1.00 KB'
  /// FileUtils.getFileSize(1000000, 0); // '1 MB'
  /// ```
  static String getFileSize(double size, [int round = 2]) {
    if (size < 0 || size.isNaN) {
      throw ArgumentError('Size must be zero or positive.');
    }
    const divider = 1000.0;
    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB'];
    var value = size;
    var unit = 0;
    while (value >= divider && unit < units.length - 1) {
      value /= divider;
      unit++;
    }
    if (unit == 0) return '${value.round()} B';
    return '${value.toStringAsFixed(round)} ${units[unit]}';
  }
}
