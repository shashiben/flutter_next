import 'package:flutter/material.dart';
import '../utils/responsive_breakpoints.dart';
import 'next_col.dart';

/// 💡 A responsive row layout that arranges [NextCol] widgets
/// based on the current screen breakpoint.
class NextRow extends StatelessWidget {
  const NextRow({
    super.key,
    required this.children,
    this.decoration,
    this.height,
  });

  /// 🌐 Children `NextCol` widgets to layout responsively.
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
