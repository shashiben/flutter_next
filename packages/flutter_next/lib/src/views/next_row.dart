import 'package:flutter/widgets.dart';

import '../utils/next_scope.dart';
import '../utils/next_span.dart';
import 'next_col.dart';

/// Lays out [NextCol] children using the parent width and [NextScope] numbers.
class NextRow extends StatelessWidget {
  /// Creates a row of [children].
  const NextRow({
    required this.children,
    this.decoration,
    this.height,
    this.gutter,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    super.key,
  });

  /// Columns in source order. [NextCol.order] can reorder them per breakpoint.
  final List<NextCol> children;

  /// Optional box decoration around the row.
  final BoxDecoration? decoration;

  /// Minimum height of the row.
  final double? height;

  /// Space between columns. Defaults to the active [NextScope] gutter.
  final double? gutter;

  /// Horizontal alignment of the wrapped columns.
  final WrapAlignment alignment;

  /// Vertical alignment of the wrapped columns.
  final WrapCrossAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final data = NextScope.dataOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final gap = gutter ?? data.gutter;
        final breakpoint = data.breakpointFor(available);
        final track = nextTrackSize(available, gap, data.columns);
        final visible = <NextCol>[
          for (final column in children)
            if (!column.hidden.contains(breakpoint)) column,
        ];
        final ordered = visible.indexed.toList()
          ..sort((a, b) {
            final order = a.$2.order.resolve()[breakpoint]!.compareTo(
              b.$2.order.resolve()[breakpoint]!,
            );
            if (order != 0) {
              return order;
            }
            return a.$1.compareTo(b.$1);
          });

        return NextMetrics(
          data: data,
          width: available,
          child: Container(
            decoration: decoration,
            constraints: BoxConstraints(
              minHeight: height ?? 0,
              minWidth: available,
              maxWidth: available,
            ),
            child: Wrap(
              alignment: alignment,
              crossAxisAlignment: crossAxisAlignment,
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final entry in ordered)
                  _NextSlot(
                    span: entry.$2.span.resolve(
                      columns: data.columns,
                    )[breakpoint]!,
                    offset: entry.$2.offset.resolve()[breakpoint]!,
                    track: track,
                    gutter: gap,
                    child: entry.$2.child,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NextSlot extends StatelessWidget {
  const _NextSlot({
    required this.span,
    required this.offset,
    required this.track,
    required this.gutter,
    required this.child,
  });

  final int span;
  final int offset;
  final double track;
  final double gutter;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final lead = offset <= 0 ? 0.0 : offset * track + offset * gutter;
    return SizedBox(
      width: nextSpanWidth(span + offset, track, gutter),
      child: Padding(
        padding: EdgeInsets.only(left: lead),
        child: child,
      ),
    );
  }
}
