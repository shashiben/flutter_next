import 'package:flutter/widgets.dart';

import '../utils/next_scope.dart';
import '../utils/next_span.dart';
import '../utils/responsive_breakpoints.dart';

/// One cell in a [NextRow].
///
/// [span] is mobile-first: [NextSpan.md] applies at medium widths and wider,
/// and narrower widths stay full width unless a smaller span is set.
class NextCol extends StatelessWidget {
  /// Creates a column.
  const NextCol({
    required this.child,
    this.span = const NextSpan(),
    this.offset = const NextTrack(),
    this.order = const NextTrack(),
    this.hidden = const <Breakpoint>{},
    super.key,
  });

  /// Contents of the column.
  final Widget child;

  /// How many of the scope's columns this cell occupies.
  final NextSpan span;

  /// Empty columns inserted before [child].
  final NextTrack offset;

  /// Sort key. Lower values are placed first. Ties keep source order.
  final NextTrack order;

  /// Breakpoints where the column is omitted.
  final Set<Breakpoint> hidden;

  @override
  Widget build(BuildContext context) {
    final metrics = NextMetrics.maybeOf(context);
    if (metrics != null) {
      return child;
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        const data = NextScopeData.standard;
        final available = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 1200.0;
        final breakpoint = data.breakpointFor(available);
        if (hidden.contains(breakpoint)) {
          return const SizedBox.shrink();
        }
        final gap = data.gutter;
        final track = nextTrackSize(available, gap, data.columns);
        final spanCount = span.resolve(columns: data.columns)[breakpoint]!;
        final offsetCount = offset.resolve()[breakpoint]!;
        final lead = offsetCount <= 0
            ? 0.0
            : offsetCount * track + offsetCount * gap;
        return SizedBox(
          width: nextSpanWidth(spanCount + offsetCount, track, gap),
          child: Padding(
            padding: EdgeInsets.only(left: lead),
            child: child,
          ),
        );
      },
    );
  }
}
