import 'package:flutter/material.dart';
import '../utils/responsive_container_utils.dart';

/// 🧱 ResponsiveContainer:
/// A wrapper that mimics Bootstrap-style containers (fluid or fixed).
///
/// If [fluid] is true, the container fills the available width.
/// If false (default), it uses standard max-width breakpoints.
///
/// You can optionally set [padding], [decoration], and [alignment].
///
/// Example:
/// ```dart
/// ResponsiveContainer(
///   fluid: false,
///   padding: EdgeInsets.all(16),
///   decoration: BoxDecoration(color: Colors.white),
///   children: [Text("Inside container")],
/// )
/// ```
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
