import 'package:flutter/widgets.dart';

import '../utils/next_scope.dart';
import '../utils/responsive_breakpoints.dart';

/// Shows [child] only for the selected breakpoints.
class NextShow extends StatelessWidget {
  /// Creates a visibility switch.
  ///
  /// [only] limits the child to those breakpoints. Otherwise the child is
  /// visible from [from] inclusive until [until] exclusive.
  const NextShow({
    required this.child,
    this.from,
    this.until,
    this.only,
    this.fallback = const SizedBox.shrink(),
    super.key,
  });

  /// Widget shown when the breakpoint matches.
  final Widget child;

  /// First breakpoint where [child] is shown, inclusive.
  final Breakpoint? from;

  /// First breakpoint where [child] is hidden, exclusive.
  final Breakpoint? until;

  /// Exact breakpoints where [child] is shown.
  final Set<Breakpoint>? only;

  /// Widget shown when [child] is hidden.
  final Widget fallback;

  /// Whether [breakpoint] should show [child].
  bool visibleAt(Breakpoint breakpoint) {
    final exact = only;
    if (exact != null) {
      return exact.contains(breakpoint);
    }
    final afterStart = from == null || breakpoint.index >= from!.index;
    final beforeEnd = until == null || breakpoint.index < until!.index;
    return afterStart && beforeEnd;
  }

  @override
  Widget build(BuildContext context) {
    if (visibleAt(NextMetrics.of(context).breakpoint)) {
      return child;
    }
    return fallback;
  }
}
