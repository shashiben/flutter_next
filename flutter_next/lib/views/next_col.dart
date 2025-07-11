import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/grid_settings.dart';
import '../utils/responsive_breakpoints.dart';

class NextCol extends StatelessWidget {
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

  final Map<Breakpoint, int> _ratios = {
    for (var bp in Breakpoint.values) bp: NextGridSettings.numberOfColumns,
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
        sizes, 'col', _ratios, math.min, NextGridSettings.numberOfColumns, 0);
    _parseSizes(offsets, 'offset', _offsets, math.max, -100, -1);
    _parseSizes(order, 'order', _orders, math.max, -100, 0);
    _parseHiddenSizes();
  }

  void _parseSizes(
    String input,
    String prefix,
    Map<Breakpoint, int> targetMap,
    int Function(int, int) reducer,
    int noValue,
    int lowerBoundValue,
  ) {
    final parts = input.isEmpty
        ? <String>[]
        : input.toLowerCase().split(' ').where((e) => e.trim().isNotEmpty);

    for (final part in parts) {
      for (final bp in Breakpoint.values) {
        final key = breakpointToString(bp);
        final pfx = '$prefix-$key${key == 'xs' ? '' : '-'}';

        if (part.startsWith(pfx)) {
          final valueStr = part.substring(pfx.length);
          final value = int.tryParse(valueStr);

          if (value != null &&
              value > lowerBoundValue &&
              value <= NextGridSettings.numberOfColumns) {
            targetMap[bp] = reducer(targetMap[bp]!, value);
          }
        }
      }
    }

    for (int i = Breakpoint.values.length - 1; i >= 0; i--) {
      final bp = Breakpoint.values[i];
      if (targetMap[bp] == noValue) {
        int? fallback;

        for (int j = i + 1; j < Breakpoint.values.length; j++) {
          final altBp = Breakpoint.values[j];
          if (targetMap[altBp] != noValue) {
            fallback = targetMap[altBp];
            break;
          }
        }

        fallback ??= targetMap.entries
                .where((e) => e.value != noValue)
                .map((e) => e.value)
                .firstOrNull ??
            lowerBoundValue;

        targetMap[bp] = fallback;
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final bp = breakpointForWidth(availableWidth);

        if (_hidden[bp] ?? false) {
          return const SizedBox.shrink();
        }

        final flexRatio = _ratios[bp]!;
        final leftMarginRatio = _offsets[bp]!;

        Widget widget = SizedBox(
          width: flexRatio * availableWidth * NextGridSettings.oneColumnRatio,
          child: Padding(
            padding: NextGridSettings.gutterSize == 0.0
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(
                    horizontal: NextGridSettings.gutterSize / 2),
            child: child,
          ),
        );

        if (leftMarginRatio > 0) {
          final leftMargin = availableWidth *
              leftMarginRatio *
              NextGridSettings.oneColumnRatio;
          widget = Padding(
            padding: EdgeInsets.only(left: leftMargin),
            child: widget,
          );
        }

        return widget;
      },
    );
  }
}
