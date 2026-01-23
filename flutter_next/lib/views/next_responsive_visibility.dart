import 'package:flutter/material.dart';
import '../utils/responsive_breakpoints.dart';

/// 🌐 ResponsiveVisibility: Conditionally renders a widget at breakpoints.
///
/// This widget allows you to show or hide content based on the current screen
/// breakpoint. Pass a string with breakpoint names to control visibility.
///
/// **Example:**
/// ```dart
/// NextResponsiveVisibility(
///   breakpoints: 'lg md sm',
///   child: Text('Visible on large, medium, and small screens'),
/// )
/// ```
///
/// **Breakpoint values:**
/// - `xs` - Extra small devices (< 576px)
/// - `sm` - Small devices (≥ 576px)
/// - `md` - Medium devices (≥ 768px)
/// - `lg` - Large devices (≥ 992px)
/// - `xl` - Extra large devices (≥ 1200px)
/// - `xxl` - Extra extra large devices (≥ 1400px)
class NextResponsiveVisibility extends StatelessWidget {
  /// Creates a [NextResponsiveVisibility] widget.
  ///
  /// The [child] is the widget to conditionally display.
  /// The [breakpoints] string should contain space-separated breakpoint names
  /// (e.g., "lg md sm") where the widget should be visible.
  /// If [breakpoints] is empty, the widget will be hidden on all breakpoints.
  const NextResponsiveVisibility({
    required this.child,
    this.breakpoints = '',
    super.key,
  });

  /// The widget to conditionally display.
  final Widget child;

  /// Space-separated breakpoint names where the widget should be visible.
  ///
  /// Example: "lg md sm" makes the widget visible on large, medium,
  /// and small screens.
  final String breakpoints;

  /// Determines if the widget should be visible at the given breakpoint.
  bool _isVisibleAtBreakpoint(Breakpoint breakpoint) {
    if (breakpoints.isEmpty) {
      return false;
    }

    final parts = breakpoints
        .toLowerCase()
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toSet();

    final breakpointName = breakpointToString(breakpoint);
    return parts.contains(breakpointName);
  }

  @override
  Widget build(BuildContext context) {
    final Breakpoint currentBp = breakpointForWidth(
      MediaQuery.of(context).size.width,
    );
    final bool isVisible = _isVisibleAtBreakpoint(currentBp);

    return isVisible ? child : const SizedBox.shrink();
  }
}
