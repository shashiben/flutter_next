import 'package:flutter/material.dart';

import '../flutter_next.dart';

/// A responsive container widget inspired by Bootstrap's container system.
///
/// This widget supports all Bootstrap container types:
/// - `.container` - responsive max-width at each breakpoint
/// - `.container-sm` - 100% until sm (≥576px), then fixed widths
/// - `.container-md` - 100% until md (≥768px), then fixed widths
/// - `.container-lg` - 100% until lg (≥992px), then fixed widths
/// - `.container-xl` - 100% until xl (≥1200px), then fixed widths
/// - `.container-xxl` - 100% until xxl (≥1400px), then fixed widths
/// - `.container-fluid` - always 100% width
///
/// **Example:**
/// ```dart
/// NextContainer(
///   minBreakpoint: null, // .container (responsive)
///   padding: EdgeInsets.all(16),
///   children: [
///     Text('Content here'),
///   ],
/// )
/// ```
///
/// See also:
/// - [NextRow] for responsive row layouts
/// - [NextCol] for responsive column layouts
class NextContainer extends StatelessWidget {
  /// Creates a [NextContainer] widget.
  ///
  /// The [children] argument must not be null.
  ///
  /// If [fluid] is true, the container always takes full width (`.container-fluid`).
  /// If [fluid] is false and [minBreakpoint] is null, uses responsive max-widths (`.container`).
  /// If [minBreakpoint] is specified, container is 100% until that breakpoint, then uses fixed widths.
  const NextContainer({
    super.key,
    this.alignment = Alignment.topCenter,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.fluid = false,
    this.minBreakpoint,
    this.decoration,
    this.padding = EdgeInsets.zero,
  });

  /// If true, container always takes full width (`.container-fluid`).
  /// Default: false
  final bool fluid;

  /// Minimum breakpoint at which container starts using fixed max-widths.
  /// If null, container uses responsive max-widths at all breakpoints (`.container`).
  /// If specified, container is 100% width until this breakpoint (`.container-{breakpoint}`).
  /// Default: null
  final Breakpoint? minBreakpoint;

  /// Box Decoration to the widget
  final BoxDecoration? decoration;

  /// List of children
  final List<Widget> children;

  /// Padding
  final EdgeInsets padding;

  /// Alignment of children
  final Alignment alignment;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final availableWidth = constraints.maxWidth;
        final currentBreakpoint = breakpointForWidth(availableWidth);

        // Calculate the container width based on fluid, minBreakpoint, and current breakpoint
        final containerWidth = _calculateContainerWidth(
          availableWidth,
          currentBreakpoint,
        );

        return SizedBox(
          width: availableWidth,
          child: Align(
            alignment: alignment,
            child: Container(
              decoration: decoration,
              padding: padding,
              width: containerWidth,
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: mainAxisSize,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Calculates the container width based on Bootstrap's container logic.
  ///
  /// Bootstrap container max-widths:
  /// - xs (<576px): 100%
  /// - sm (≥576px): 540px
  /// - md (≥768px): 720px
  /// - lg (≥992px): 960px
  /// - xl (≥1200px): 1140px
  /// - xxl (≥1400px): 1320px
  ///
  /// For `.container-{breakpoint}` classes:
  /// - Container is 100% width until the specified breakpoint
  /// - Then uses the standard max-widths from that breakpoint onwards
  double _calculateContainerWidth(
    double availableWidth,
    Breakpoint currentBreakpoint,
  ) {
    // If fluid, always return full width
    if (fluid) {
      return availableWidth;
    }

    // If minBreakpoint is specified, check if we've reached it
    if (minBreakpoint != null) {
      // Compare breakpoints (larger enum value = larger breakpoint)
      final minBreakpointIndex = Breakpoint.values.indexOf(minBreakpoint!);
      final currentBreakpointIndex =
          Breakpoint.values.indexOf(currentBreakpoint);

      // If current breakpoint is smaller than minBreakpoint, return full width
      if (currentBreakpointIndex < minBreakpointIndex) {
        return availableWidth;
      }
    }

    // Calculate max-width based on current breakpoint
    return _getMaxWidthForBreakpoint(availableWidth, currentBreakpoint);
  }

  /// Returns the max-width for a given breakpoint according to Bootstrap 5.3.
  ///
  /// Bootstrap max-widths:
  /// - xs (<576px): 100% (full width)
  /// - sm (≥576px): 540px
  /// - md (≥768px): 720px
  /// - lg (≥992px): 960px
  /// - xl (≥1200px): 1140px
  /// - xxl (≥1400px): 1320px
  double _getMaxWidthForBreakpoint(
    double availableWidth,
    Breakpoint breakpoint,
  ) {
    // Bootstrap 5.3 container max-widths
    const maxWidths = {
      Breakpoint.xs: null, // 100% width
      Breakpoint.sm: 540.0,
      Breakpoint.md: 720.0,
      Breakpoint.lg: 960.0,
      Breakpoint.xl: 1140.0,
      Breakpoint.xxl: 1320.0,
    };

    final maxWidth = maxWidths[breakpoint];

    // If no max-width specified (xs) or available width is smaller, return full width
    if (maxWidth == null || availableWidth < maxWidth) {
      return availableWidth;
    }

    // Return the fixed max-width
    return maxWidth;
  }
}
