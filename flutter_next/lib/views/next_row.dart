import 'package:flutter/material.dart';
import '../utils/responsive_breakpoints.dart';
import 'next_col.dart';

/// 💡 A responsive row layout that arranges [NextCol] widgets
/// based on the current screen breakpoint.
///
/// This widget automatically handles:
/// - Hiding columns based on breakpoint visibility settings
/// - Reordering columns based on breakpoint order settings
/// - Wrapping columns when they don't fit on one line
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

        return Container(
          decoration: decoration,
          constraints: BoxConstraints(
            minHeight: height ?? 0,
            minWidth: availableWidth,
            maxWidth: availableWidth,
          ),
          child: Wrap(
            children: visibleChildren,
          ),
        );
      },
    );
  }
}
