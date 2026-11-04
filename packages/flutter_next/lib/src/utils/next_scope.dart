import 'package:flutter/widgets.dart';

import 'responsive_breakpoints.dart';

/// Layout numbers for a subtree: breakpoints, columns, gutter, and container widths.
class NextScopeData {
  /// Creates layout numbers.
  const NextScopeData({
    this.breakpoints = defaultBreakpointWidths,
    this.columns = 12,
    this.gutter = 16,
    this.containerMaxWidths = defaultContainerMaxWidths,
  });

  /// Minimum width of each [Breakpoint].
  final Map<Breakpoint, double> breakpoints;

  /// Column count. Twelve matches the Bootstrap grid.
  final int columns;

  /// Space between columns, in logical pixels.
  final double gutter;

  /// Max content width at each breakpoint. `null` means full width.
  final Map<Breakpoint, double?> containerMaxWidths;

  /// Bootstrap 5.3 defaults.
  static const NextScopeData standard = NextScopeData();

  /// Breakpoint that [width] belongs to.
  Breakpoint breakpointFor(double width) =>
      breakpointForWidth(width, breakpoints);

  /// Container max width for [width], capped by the available space.
  double containerWidth(
    double availableWidth,
    Breakpoint breakpoint, {
    bool fluid = false,
    Breakpoint? minBreakpoint,
  }) {
    if (fluid) {
      return availableWidth;
    }
    if (minBreakpoint != null && breakpoint.index < minBreakpoint.index) {
      return availableWidth;
    }
    final maxWidth = containerMaxWidths[breakpoint];
    if (maxWidth == null || availableWidth < maxWidth) {
      return availableWidth;
    }
    return maxWidth;
  }
}

/// Publishes [data] and the width those numbers were resolved against.
class NextMetrics extends InheritedWidget {
  /// Publishes [data] for [width].
  const NextMetrics({
    required this.data,
    required this.width,
    required super.child,
    super.key,
  });

  /// Active layout numbers.
  final NextScopeData data;

  /// Width used to pick the breakpoint. This is the parent constraint, not the screen.
  final double width;

  /// Breakpoint for [width].
  Breakpoint get breakpoint => data.breakpointFor(width);

  /// Nearest metrics, or null when the tree has no [NextScope] or [NextRow].
  static NextMetrics? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NextMetrics>();
  }

  /// Nearest metrics, or [NextScopeData.standard] measured against the screen.
  static NextMetrics of(BuildContext context) {
    final metrics = maybeOf(context);
    if (metrics != null) {
      return metrics;
    }
    final width = MediaQuery.sizeOf(context).width;
    return NextMetrics(
      data: NextScopeData.standard,
      width: width,
      child: const SizedBox.shrink(),
    );
  }

  @override
  bool updateShouldNotify(NextMetrics oldWidget) {
    return width != oldWidget.width ||
        data.columns != oldWidget.data.columns ||
        data.gutter != oldWidget.data.gutter ||
        data.breakpoints != oldWidget.data.breakpoints ||
        data.containerMaxWidths != oldWidget.data.containerMaxWidths;
  }
}

/// Overrides layout numbers for [child] and resolves them against the parent width.
class NextScope extends StatelessWidget {
  /// Creates a scope.
  const NextScope({
    required this.child,
    this.breakpoints,
    this.columns,
    this.gutter,
    this.containerMaxWidths,
    super.key,
  });

  /// Subtree that reads these numbers.
  final Widget child;

  /// Minimum widths. Unset values keep the parent scope or the Bootstrap defaults.
  final Map<Breakpoint, double>? breakpoints;

  /// Column count. Unset keeps the parent scope or 12.
  final int? columns;

  /// Gutter. Unset keeps the parent scope or 16.
  final double? gutter;

  /// Container max widths. Unset keeps the parent scope or the Bootstrap defaults.
  final Map<Breakpoint, double?>? containerMaxWidths;

  /// Active data for [context].
  static NextScopeData dataOf(BuildContext context) {
    return NextMetrics.of(context).data;
  }

  @override
  Widget build(BuildContext context) {
    final parent = NextMetrics.maybeOf(context)?.data ?? NextScopeData.standard;
    final data = NextScopeData(
      breakpoints: breakpoints ?? parent.breakpoints,
      columns: columns ?? parent.columns,
      gutter: gutter ?? parent.gutter,
      containerMaxWidths: containerMaxWidths ?? parent.containerMaxWidths,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        return NextMetrics(data: data, width: width, child: child);
      },
    );
  }
}
