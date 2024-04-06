import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextUtils {
  static const List<String> _prefixes = <String>[
    'xxl',
    'xl',
    'lg',
    'md',
    'sm',
    'xs'
  ];
  static const List<String> _prefixesEnum = <String>[
    GridPrefixes.xxl,
    GridPrefixes.xl,
    GridPrefixes.lg,
    GridPrefixes.md,
    GridPrefixes.sm,
    GridPrefixes.xs
  ];
  static const List<int> _widthThresholds = <int>[1400, 1200, 992, 768, 576];
  static const List<int> _maxWidthsForNonFluid = <int>[
    1320,
    1140,
    960,
    720,
    540
  ];

  static double getMaxWidth(String sizes,
      {required BuildContext context, bool isOffset = false, double? width}) {
    final double maxWidth = width ?? context.width;
    final Map<String, int> sizeMap =
        isOffset ? getAllOffsetsValue(sizes) : getAllColValues(sizes);
    final String getCurrentPrefix = getPrefixByWidth(maxWidth);
    return maxWidth *
        ((sizeMap[getCurrentPrefix] ?? (isOffset ? 0.0 : 1.0)) / 12);
  }

  static String getPrefixByWidth(double width) {
    for (int i = 0; i < _widthThresholds.length; i++) {
      if (width >= _widthThresholds[i]) return _prefixes[i];
    }
    return 'xs';
  }

  static String getPrefixEnumByWidth(double width) {
    for (int i = 0; i < _widthThresholds.length; i++) {
      if (width >= _widthThresholds[i]) return _prefixesEnum[i];
    }
    return GridPrefixes.xs;
  }

  static double getMaxWidthForNonFluid(double width) {
    for (int i = 0; i < _widthThresholds.length; i++) {
      if (width >= _widthThresholds[i]) {
        return _maxWidthsForNonFluid[i].toDouble();
      }
    }
    return width;
  }

  static Map<String, int> getAllOffsetsValue(String sizes) {
    return _getValuesFromSizes(sizes, 'offset');
  }

  static Map<String, int> getAllColValues(String sizes) {
    return _getValuesFromSizes(sizes, 'col', defaultValue: 12);
  }

  static Map<String, int> _getValuesFromSizes(String sizes, String prefix,
      {int defaultValue = 0}) {
    final Map<String, int> subResult = <String, int>{};
    final List<String> getPrefixList = sizes
        .toLowerCase()
        .trim()
        .split(' ')
        .where((String order) => order.trim().isNotEmpty)
        .toList();
    for (final String element in getPrefixList) {
      final List<String> splittedList = element.split('-');
      if (splittedList.first == prefix &&
          int.tryParse(splittedList.last) != null &&
          int.parse(splittedList.last) <= 12) {
        subResult[splittedList.length == 2 ? 'sm' : splittedList[1]] =
            int.parse(splittedList.last);
      }
    }
    final Map<String, int> result = <String, int>{};
    for (int i = 0; i < _prefixes.length; i++) {
      final String prefix = _prefixes[i];
      final int nullValue = i == 0 ? defaultValue : result[_prefixes[i - 1]]!;
      result[prefix] = subResult[prefix] ?? nullValue;
    }
    return result;
  }
}
