import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/grid_settings.dart';
import '../utils/responsive_breakpoints.dart';
import 'next_row.dart' show RowContext;

/// A responsive column widget that adapts its size, offset, and order
/// based on the current screen breakpoint.
///
/// This widget is part of a responsive grid system similar to Bootstrap.
/// It supports:
/// - Responsive sizing (e.g., "col-md-6" for 50% width on medium screens)
/// - Responsive offsets (e.g., "offset-md-2" for left margin)
/// - Responsive ordering (e.g., "order-md-1" for reordering)
/// - Breakpoint-specific visibility
///
/// **Example:**
/// ```dart
/// NextCol(
///   sizes: 'col-md-6 col-sm-12',
///   offsets: 'offset-md-3',
///   child: Text('Responsive column'),
/// )
/// ```
///
/// See also:
/// - [NextRow] for containing responsive columns
/// - [NextContainer] for responsive containers
class NextCol extends StatelessWidget {
  /// Creates a [NextCol] widget.
  ///
  /// The [child] argument must not be null.
  ///
  /// The [sizes] parameter accepts a space-separated string of column sizes
  /// (e.g., "col-md-6 col-sm-12").
  ///
  /// The [offsets] parameter accepts a space-separated string of offsets
  /// (e.g., "offset-md-3").
  ///
  /// The [order] parameter accepts a space-separated string of orders
  /// (e.g., "order-md-1").
  ///
  /// The [invisibleForSizes] parameter accepts a space-separated string of
  /// breakpoint names where the column should be hidden (e.g., "xs sm").
  NextCol({
    super.key,
    required this.child,
    this.fit = FlexFit.loose,
    this.absoluteSizes = true,
    String sizes = '',
    String offsets = '',
    String order = '',
    this.invisibleForSizes,
  })  : sizes = sizes.trim(),
        offsets = offsets.trim(),
        order = order.trim() {
    _initialize();
  }

  final Widget child;
  final FlexFit fit;
  final String sizes;
  final String offsets;
  final String order;
  final String? invisibleForSizes;
  final bool absoluteSizes;

  /// Expose visibility map for use in responsive layout (e.g. NextRow)
  Map<Breakpoint, bool> get hidden => _hidden;

  /// Expose order map for responsive reordering (e.g. NextRow)
  Map<Breakpoint, int> get orders => _orders;

  /// Expose ratios map for flex calculations (e.g. NextRow)
  Map<Breakpoint, int> get ratios => _ratios;

  /// Expose offsets map for margin calculations (e.g. NextRow)
  Map<Breakpoint, int> get offsetRatios => _offsets;

  final Map<Breakpoint, int> _ratios = {
    for (var bp in Breakpoint.values) bp: -1, // Use -1 as noValue indicator
  };

  final Map<Breakpoint, int> _offsets = {
    for (var bp in Breakpoint.values) bp: -100,
  };

  final Map<Breakpoint, int> _orders = {
    for (var bp in Breakpoint.values) bp: 0,
  };

  final Map<Breakpoint, bool> _hidden = {
    for (var bp in Breakpoint.values) bp: false,
  };

  void _initialize() {
    _parseSizes(
      sizes,
      'col',
      _ratios,
      math.min,
      -1, // Use -1 as noValue instead of NextGridSettings.numberOfColumns
      0,
    );
    _parseSizes(
      offsets,
      'offset',
      _offsets,
      math.max,
      -100,
      -1,
    );
    _parseSizes(
      order,
      'order',
      _orders,
      math.max,
      -100,
      0,
    );
    _parseHiddenSizes();
  }

  /// Parses size strings (e.g., "col-md-6 col-sm-12") and populates the target map.
  ///
  /// The parsing follows Bootstrap's responsive design pattern:
  /// 1. Parse explicit values from the input string
  /// 2. Cascade values from larger to smaller breakpoints (mobile-first)
  /// 3. Fill remaining gaps with default values
  ///
  /// For example, "col-md-6" means:
  /// - md and above: 6 columns
  /// - sm and below: inherit from next larger breakpoint or default
  void _parseSizes(
    String input,
    String prefix,
    Map<Breakpoint, int> targetMap,
    int Function(int, int) reducer,
    int noValue,
    int lowerBoundValue,
  ) {
    // Step 1: Parse explicit values from input string
    final parts = input.isEmpty
        ? <String>[]
        : input.toLowerCase().split(' ').where((e) => e.trim().isNotEmpty);

    for (final part in parts) {
      for (final bp in Breakpoint.values) {
        final key = breakpointToString(bp);
        final pattern = '$prefix-$key-';

        if (part.startsWith(pattern)) {
          final valueStr = part.substring(pattern.length);
          final value = int.tryParse(valueStr);

          // Validate value is within acceptable range
          if (value != null &&
              value > lowerBoundValue &&
              value <= NextGridSettings.numberOfColumns) {
            // Apply reducer function (min for sizes, max for offsets/orders)
            final currentValue =
                targetMap[bp] == noValue ? value : targetMap[bp]!;
            targetMap[bp] = reducer(currentValue, value);
          }
        }
      }
    }

    // Step 2: Cascade values from larger to smaller breakpoints (mobile-first approach)
    // This means if you specify "col-md-6", it applies to md, lg, xl, xxl
    // We cascade backwards from xxl to xs
    for (int i = Breakpoint.values.length - 2; i >= 0; i--) {
      final currentBp = Breakpoint.values[i];
      final nextBp = Breakpoint.values[i + 1];

      if (targetMap[currentBp] == noValue && targetMap[nextBp] != noValue) {
        targetMap[currentBp] = targetMap[nextBp]!;
      }
    }

    // Step 3: Forward fill for any remaining gaps (fallback)
    // If a smaller breakpoint has a value but larger doesn't, copy it forward
    for (int i = 1; i < Breakpoint.values.length; i++) {
      final currentBp = Breakpoint.values[i];
      final prevBp = Breakpoint.values[i - 1];

      if (targetMap[currentBp] == noValue && targetMap[prevBp] != noValue) {
        targetMap[currentBp] = targetMap[prevBp]!;
      }
    }

    // Step 4: Fill any remaining noValue entries with the default lower bound
    for (final bp in Breakpoint.values) {
      if (targetMap[bp] == noValue) {
        targetMap[bp] = lowerBoundValue;
      }
    }
  }

  void _parseHiddenSizes() {
    final parts =
        (invisibleForSizes ?? '').split(' ').map((e) => e.trim().toLowerCase());
    for (final part in parts) {
      for (final bp in Breakpoint.values) {
        if (part == breakpointToString(bp)) {
          _hidden[bp] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get calculated dimensions from RowContext (provided by NextRow)
    // All width calculations are now done in NextRow
    final rowContext = RowContext.of(context);

    // If no row context (column used outside NextRow), fallback to old calculation
    if (rowContext == null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : 1200.0;
          final bp = breakpointForWidth(availableWidth);

          if (_hidden[bp] ?? false) {
            return const SizedBox.shrink();
          }

          final columnRatio = _ratios[bp]!;
          final offsetRatio = _offsets[bp]!;

          final columnWidth = _calculateColumnWidth(columnRatio, availableWidth);
          final leftMargin = offsetRatio > 0
              ? _calculateColumnWidth(offsetRatio, availableWidth)
              : 0.0;

          Widget widget = SizedBox(
            width: columnWidth,
            child: child,
          );

          if (leftMargin > 0) {
            widget = Padding(
              padding: EdgeInsets.only(left: leftMargin),
              child: widget,
            );
          }

          return widget;
        },
      );
    }

    // Use pre-calculated dimensions from NextRow
    final columnWidth = rowContext.columnWidth;
    final leftMargin = rowContext.leftMargin;

    // Check if column should be hidden (this should be handled by NextRow, but keep for safety)
    final bp = breakpointForWidth(rowContext.fullRowWidth);
    if (_hidden[bp] ?? false) {
      return const SizedBox.shrink();
    }

    // Build widget with calculated dimensions
    Widget widget = SizedBox(
      width: columnWidth,
      child: child,
    );

    // Apply left margin if offset is specified
    if (leftMargin > 0) {
      widget = Padding(
        padding: EdgeInsets.only(left: leftMargin),
        child: widget,
      );
    }

    return widget;
  }

  /// Calculates the width of a column based on the column ratio.
  /// This is only used as a fallback when NextCol is used outside NextRow.
  ///
  /// The column ratio represents how many columns (out of total) this column
  /// should occupy. For example:
  /// - col-md-6 means 6/12 = 50% width
  /// - col-md-4 means 4/12 = 33.33% width
  /// - col-md-12 means 12/12 = 100% width
  ///
  /// Formula: (columnRatio / numberOfColumns) * availableWidth
  double _calculateColumnWidth(int columnRatio, double availableWidth) {
    // Clamp column ratio to valid range [0, numberOfColumns]
    final clampedRatio = columnRatio.clamp(0, NextGridSettings.numberOfColumns);

    // If ratio is 0 or negative, return 0 width
    if (clampedRatio <= 0) {
      return 0.0;
    }

    // If ratio equals or exceeds total columns, return full width
    if (clampedRatio >= NextGridSettings.numberOfColumns) {
      return availableWidth;
    }

    // Calculate proportional width: (ratio / totalColumns) * availableWidth
    return (clampedRatio / NextGridSettings.numberOfColumns) * availableWidth;
  }
}
