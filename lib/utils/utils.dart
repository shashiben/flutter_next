import '../flutter_next.dart';

class NextUtils {
  static const List<GridPrefix> _prefixes = [
    GridPrefix.xxl,
    GridPrefix.xl,
    GridPrefix.lg,
    GridPrefix.md,
    GridPrefix.sm,
    GridPrefix.xs
  ];
  static const List<GridPrefix> _prefixesEnum = [
    GridPrefix.xxl,
    GridPrefix.xl,
    GridPrefix.lg,
    GridPrefix.md,
    GridPrefix.sm,
    GridPrefix.xs
  ];
  static const List<int> _widthThresholds = <int>[1400, 1200, 992, 768, 576];
  static const List<int> _maxWidthsForNonFluid = <int>[
    1320,
    1140,
    960,
    720,
    540
  ];

  static GridPrefix getPrefixByWidth(double width) {
    for (int i = 0; i < _widthThresholds.length; i++) {
      if (width >= _widthThresholds[i]) {
        return _prefixes[i];
      }
    }
    return GridPrefix.xs;
  }

  static GridPrefix getPrefixEnumByWidth(double width) {
    for (int i = 0; i < _widthThresholds.length; i++) {
      if (width >= _widthThresholds[i]) {
        return _prefixesEnum[i];
      }
    }
    return GridPrefix.xs;
  }

  static double getMaxWidthForNonFluid(double width) {
    for (int i = 0; i < _widthThresholds.length; i++) {
      if (width >= _widthThresholds[i]) {
        return _maxWidthsForNonFluid[i].toDouble();
      }
    }
    return width;
  }

  //Define similar for getAllColValues from sizes of Map<GridPrefix, double>
  static Map<GridPrefix, int> getAllColValuesFromMap(
      Map<GridPrefix, double> sizes) {
    final Map<GridPrefix, int> subResult = <GridPrefix, int>{};
    for (final GridPrefix prefix in GridPrefix.values) {
      final double? value = sizes[prefix];
      if (value != null && value <= 12) {
        subResult[prefix] = value.toInt();
      }
    }
    final Map<GridPrefix, int> result = <GridPrefix, int>{};
    for (int i = 0; i < _prefixes.length; i++) {
      final GridPrefix prefix = _prefixes[i];
      final int nullValue = i == 0 ? 12 : result[_prefixes[i - 1]]!;
      result[prefix] = subResult[prefix] ?? nullValue;
    }
    return result;
  }

}
