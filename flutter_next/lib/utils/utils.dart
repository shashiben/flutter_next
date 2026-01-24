part of '../flutter_next.dart';

class NextUtils {
  static const List<GridPrefix> _prefixes = [
    GridPrefix.xxl,
    GridPrefix.xl,
    GridPrefix.lg,
    GridPrefix.md,
    GridPrefix.sm,
    GridPrefix.xs,
  ];

  // Bootstrap 5.3 default breakpoint thresholds (can be overridden via FlutterNext.configureBreakpoints)
  // These are used as fallback when breakpointForWidth is not accessible
  static const List<double> _defaultBreakpointThresholds = [
    1400,
    1200,
    992,
    768,
    576
  ];

  /// Gets width thresholds - uses configured breakpoints if available
  /// Since part files can't directly access exported functions, we use a cached approach
  static List<double> _getWidthThresholds() {
    // Try to get configured values, fallback to defaults
    // Note: This will use defaults until we can properly access BreakpointConfig
    // The actual breakpoint logic in other files (next_col, next_container) will use
    // the configured values via breakpointForWidth which has access to BreakpointConfig
    return List<double>.from(_defaultBreakpointThresholds);
  }

  /// Gets the GridPrefix based on screen width.
  /// Used by NextGridView to determine the current breakpoint.
  static GridPrefix getPrefixByWidth(double width) {
    // Use the thresholds to determine GridPrefix
    final thresholds = _getWidthThresholds();
    for (int i = 0; i < thresholds.length; i++) {
      if (width >= thresholds[i]) {
        return _prefixes[i];
      }
    }
    return GridPrefix.xs;
  }

  static Map<GridPrefix, double> populateAllColValues(
    Map<GridPrefix, double> sizes,
  ) {
    final Map<GridPrefix, double> result = <GridPrefix, double>{};
    double? lastSize;

    for (final GridPrefix prefix in _prefixes) {
      if (sizes.containsKey(prefix)) {
        lastSize = sizes[prefix];
      }
      result[prefix] = lastSize ?? 100.0;
    }

    return result;
  }
}
