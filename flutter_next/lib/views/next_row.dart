import 'package:flutter/material.dart';

import '../utils/grid_settings.dart';
import '../utils/responsive_breakpoints.dart';
import 'next_col.dart';

/// 💡 A responsive row layout that arranges [NextCol] widgets
/// based on the current screen breakpoint.
///
/// This widget automatically handles:
/// - Hiding columns based on breakpoint visibility settings
/// - Reordering columns based on breakpoint order settings
/// - Wrapping columns when they don't fit on one line
/// - Applying gutters (spacing between columns) - Bootstrap style
///
/// **Example:**
/// ```dart
/// NextRow(
///   children: [
///     NextCol(sizes: 'col-md-6', child: Text('Column 1')),
///     NextCol(sizes: 'col-md-6', child: Text('Column 2')),
///   ],
/// )
/// ```
///
/// See also:
/// - [NextCol] for individual column widgets
/// - [NextContainer] for responsive containers
class NextRow extends StatelessWidget {
  /// Creates a [NextRow] widget.
  ///
  /// The [children] argument must not be null and should contain
  /// [NextCol] widgets.
  const NextRow({
    super.key,
    required this.children,
    this.decoration,
    this.height,
    this.gutterSize,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  });

  /// 🌐 Children `NextCol` widgets to layout responsively.
  ///
  /// These columns will be automatically hidden, reordered, and wrapped
  /// based on their breakpoint settings and the current screen size.
  final List<NextCol> children;

  /// 🎨 Optional container decoration (e.g., background, border).
  final BoxDecoration? decoration;

  /// 📏 Optional minimum height for the row container.
  final double? height;

  /// 📐 Gutter size (spacing between columns).
  /// If null, uses `NextGridSettings.gutterSize` (default: 16.0).
  /// Set to 0 to remove gutters.
  final double? gutterSize;

  /// 🎯 Alignment of children along the main axis (horizontal).
  /// Default: `WrapAlignment.start` (Bootstrap default - left aligned).
  ///
  /// Options:
  /// - `WrapAlignment.start` - Align to start (left)
  /// - `WrapAlignment.center` - Center align
  /// - `WrapAlignment.end` - Align to end (right)
  /// - `WrapAlignment.spaceAround` - Space around items
  /// - `WrapAlignment.spaceBetween` - Space between items
  /// - `WrapAlignment.spaceEvenly` - Space evenly
  final WrapAlignment alignment;

  /// 🎯 Alignment of children along the cross axis (vertical).
  /// Default: `WrapCrossAlignment.start` (top aligned).
  final WrapCrossAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final breakpoint = breakpointForWidth(availableWidth);

        final visibleChildren = children.where((col) {
          return !(col.hidden[breakpoint] ?? false);
        }).toList();

        visibleChildren.sort((a, b) {
          final aOrder = a.orders[breakpoint] ?? 0;
          final bOrder = b.orders[breakpoint] ?? 0;
          return aOrder.compareTo(bOrder);
        });

        // Get gutter size (use provided value or default from settings)
        final gutter = gutterSize ?? NextGridSettings.gutterSize;
        final gutterHalf = gutter / 2;

        // Calculate widths for all visible columns in the row
        // This centralizes width calculation logic in NextRow
        final childrenWithCalculatedWidths = visibleChildren.map((col) {
          // Get column ratio and offset for current breakpoint
          final columnRatio = col.ratios[breakpoint] ?? 0;
          final offsetRatio = col.offsetRatios[breakpoint] ?? 0;

          // Calculate column width based on ratio
          final columnWidth = _calculateColumnWidth(columnRatio, availableWidth);
          
          // Calculate offset margin
          final leftMargin = (offsetRatio > 0)
              ? _calculateColumnWidth(offsetRatio, availableWidth)
              : 0.0;

          // Wrap column with calculated dimensions and gutter padding
          return _GutterWrapper(
            fullRowWidth: availableWidth,
            gutterHalf: gutter > 0 ? gutterHalf : 0,
            columnWidth: columnWidth,
            leftMargin: leftMargin,
            child: col,
          );
        }).toList();

        // Bootstrap gutter pattern: negative margin on row to offset column padding
        // Since Flutter doesn't support negative margins/padding, we use Transform.translate
        // to shift the content left, achieving the same visual effect
        Widget rowContent = Wrap(
          alignment: alignment,
          crossAxisAlignment: crossAxisAlignment,
          children: childrenWithCalculatedWidths,
        );

        // Apply negative horizontal translation to offset gutter padding (Bootstrap pattern)
        // This pulls columns back to align with container edges
        if (gutter > 0) {
          rowContent = Transform.translate(
            offset: Offset(-gutterHalf, 0),
            child: rowContent,
          );
          // Clip overflow from negative translation using ClipRect
          rowContent = ClipRect(child: rowContent);
        }

        return Container(
          decoration: decoration,
          constraints: BoxConstraints(
            minHeight: height ?? 0,
            minWidth: availableWidth,
            maxWidth: availableWidth,
          ),
          child: rowContent,
        );
      },
    );
  }

  /// Calculates the width of a column based on the column ratio.
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

/// Widget that provides row context (calculated width, offset, and gutter info) to NextCol.
/// This allows NextCol to use pre-calculated dimensions from NextRow.
class RowContext extends InheritedWidget {
  const RowContext({
    super.key,
    required this.fullRowWidth,
    required this.gutterHalf,
    required this.columnWidth,
    required this.leftMargin,
    required super.child,
  });

  final double fullRowWidth;
  final double gutterHalf;
  final double columnWidth;
  final double leftMargin;

  static RowContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RowContext>();
  }

  @override
  bool updateShouldNotify(RowContext oldWidget) {
    return fullRowWidth != oldWidget.fullRowWidth ||
        gutterHalf != oldWidget.gutterHalf ||
        columnWidth != oldWidget.columnWidth ||
        leftMargin != oldWidget.leftMargin;
  }
}

/// Wrapper widget that provides row context and applies gutter padding.
class _GutterWrapper extends StatelessWidget {
  const _GutterWrapper({
    required this.fullRowWidth,
    required this.gutterHalf,
    required this.columnWidth,
    required this.leftMargin,
    required this.child,
  });

  final double fullRowWidth;
  final double gutterHalf;
  final double columnWidth;
  final double leftMargin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget widget = RowContext(
      fullRowWidth: fullRowWidth,
      gutterHalf: gutterHalf,
      columnWidth: columnWidth,
      leftMargin: leftMargin,
      child: child,
    );

    // Apply gutter padding (Bootstrap pattern)
    if (gutterHalf > 0) {
      widget = Padding(
        padding: EdgeInsets.symmetric(horizontal: gutterHalf),
        child: widget,
      );
    }

    return widget;
  }
}
