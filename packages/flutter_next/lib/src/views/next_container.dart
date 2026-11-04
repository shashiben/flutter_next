import 'package:flutter/widgets.dart';

import '../utils/next_scope.dart';
import '../utils/responsive_breakpoints.dart';

/// Centers a max-width column. The breakpoint comes from the parent width.
class NextContainer extends StatelessWidget {
  /// Creates a container.
  const NextContainer({
    required this.children,
    this.alignment = Alignment.topCenter,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.fluid = false,
    this.minBreakpoint,
    this.decoration,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  /// How the fixed-width column sits in the parent.
  final Alignment alignment;

  /// Children of the inner column.
  final List<Widget> children;

  /// Vertical alignment of [children].
  final MainAxisAlignment mainAxisAlignment;

  /// How much vertical space the inner column takes.
  final MainAxisSize mainAxisSize;

  /// Horizontal alignment of [children].
  final CrossAxisAlignment crossAxisAlignment;

  /// When true, the column uses the full parent width.
  final bool fluid;

  /// Width stays full until this breakpoint, then uses the fixed max widths.
  final Breakpoint? minBreakpoint;

  /// Decoration of the inner column.
  final BoxDecoration? decoration;

  /// Padding inside the inner column.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final data = NextScope.dataOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final breakpoint = data.breakpointFor(available);
        final columnWidth = data.containerWidth(
          available,
          breakpoint,
          fluid: fluid,
          minBreakpoint: minBreakpoint,
        );
        return SizedBox(
          width: available,
          child: Align(
            alignment: alignment,
            child: NextMetrics(
              data: data,
              width: columnWidth,
              child: Container(
                decoration: decoration,
                padding: padding,
                width: columnWidth,
                child: Column(
                  mainAxisAlignment: mainAxisAlignment,
                  mainAxisSize: mainAxisSize,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
