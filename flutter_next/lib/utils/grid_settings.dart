class NextGridSettings {
  static int numberOfColumns = 12;
  static double gutterSize = 16.0;

  static double get oneColumnRatio => 1 / numberOfColumns;

  static void configure({
    int? columns,
    double? gutter,
  }) {
    if (columns != null && columns > 0) {
      numberOfColumns = columns;
    }
    if (gutter != null && gutter >= 0) {
      gutterSize = gutter;
    }
  }
}
