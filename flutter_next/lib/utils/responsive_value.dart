import 'package:flutter/widgets.dart';
import 'responsive_breakpoints.dart';

/// 📦 Gets a value based on current screen breakpoint.
///
/// Fallback order if value not found for exact breakpoint:
/// 1. 🔽 Larger sizes (right in list)
/// 2. 🔼 Smaller sizes (left in list)
dynamic responsiveValueForSize({
  required Map<Breakpoint, dynamic> sizes,
  required BuildContext context,
}) {
  final Breakpoint currentBp =
      breakpointForWidth(MediaQuery.of(context).size.width);
  final dynamic value = sizes[currentBp];

  if (value != null) {
    return value;
  }

  final int idx = kBreakpoints.indexOf(currentBp);

  // 🔽 Search right
  for (int i = idx + 1; i < kBreakpoints.length; i++) {
    final bp = kBreakpoints[i];
    if (sizes.containsKey(bp)) {
      return sizes[bp];
    }
  }

  // 🔼 Search left
  for (int j = idx - 1; j >= 0; j--) {
    final bp = kBreakpoints[j];
    if (sizes.containsKey(bp)) {
      return sizes[bp];
    }
  }

  return null;
}
