import 'package:flutter/widgets.dart';

import '../utils/next_span.dart';
import 'next_col.dart';
import 'next_row.dart';

/// A [NextRow] that gives every child the same [span].
class NextGrid extends StatelessWidget {
  /// Creates a grid.
  const NextGrid({
    required this.children,
    required this.span,
    this.gutter,
    this.alignment = WrapAlignment.start,
    super.key,
  });

  /// Cells, in order.
  final List<Widget> children;

  /// Span applied to every child.
  final NextSpan span;

  /// Space between cells. Defaults to the active scope gutter.
  final double? gutter;

  /// Horizontal alignment of each row of cells.
  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return NextRow(
      gutter: gutter,
      alignment: alignment,
      children: [
        for (final child in children) NextCol(span: span, child: child),
      ],
    );
  }
}
