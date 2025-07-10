import 'package:flutter/material.dart';
import '../utils/responsive_breakpoints.dart';

/// 🌐 ResponsiveVisibility: Conditionally renders a widget at breakpoints.
///
/// Pass a string like `"col-lg col-md"` to control when this widget appears.
class NextResponsiveVisibility extends StatelessWidget {
  NextResponsiveVisibility({
    required this.child,
    String breakpoints = '',
    super.key,
  }) : breakpoints = breakpoints.trim() {
    _initializeVisibility();
  }
  final Widget child;
  final String breakpoints;

  final Map<Breakpoint, bool> _visibilityMap = {
    Breakpoint.xxl: false,
    Breakpoint.xl: false,
    Breakpoint.lg: false,
    Breakpoint.md: false,
    Breakpoint.sm: false,
    Breakpoint.xs: false,
  };

  void _initializeVisibility() {
    if (breakpoints.isEmpty) {
      return;
    }

    final parts = breakpoints
        .toLowerCase()
        .split(' ')
        .where((p) => p.trim().isNotEmpty)
        .toList();

    for (final part in parts) {
      for (final bp in kBreakpoints) {
        if (bp != 'xs' && part.startsWith('col-$bp')) {
          _visibilityMap[bp] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Breakpoint currentBp =
        breakpointForWidth(MediaQuery.of(context).size.width);
    final bool isVisible = _visibilityMap[currentBp] ?? false;

    return isVisible ? child : const SizedBox.shrink();
  }
}
