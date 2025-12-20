import 'package:flutter/material.dart';
import '../utils/responsive_container_utils.dart';

/// A responsive container widget that mimics Bootstrap-style containers.
///
/// This widget provides two modes:
/// - **Fixed width** (fluid: false): Uses standard max-width breakpoints
///   that adapt to screen size
/// - **Fluid** (fluid: true): Fills the entire available width
///
/// **Example:**
/// ```dart
/// ResponsiveContainer(
///   fluid: false,
///   padding: EdgeInsets.all(16),
///   decoration: BoxDecoration(color: Colors.white),
///   children: [Text("Inside container")],
/// )
/// ```
///
/// See also:
/// - [NextContainer] for a similar container with more layout options
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.children,
    this.fluid = false,
    this.decoration,
    this.padding,
    this.alignment = Alignment.topCenter,
  });
  final bool fluid;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final List<Widget> children;

  /// 🧭 Optional alignment (default is `topCenter`)
  final Alignment alignment;

  double _resolveWidth(double screenWidth) {
    return fluid ? screenWidth : responsiveMaxWidth(screenWidth);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = _resolveWidth(constraints.maxWidth);

        Widget content = Container(
          width: width,
          decoration: decoration,
          child: Wrap(
            children: children,
          ),
        );

        if (padding != null) {
          content = Padding(
            padding: padding!,
            child: content,
          );
        }

        return Align(
          alignment: alignment,
          child: content,
        );
      },
    );
  }
}
