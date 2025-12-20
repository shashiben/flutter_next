import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A responsive container widget inspired by Bootstrap's container system.
///
/// This widget provides a container that can be either fixed-width (like
/// Bootstrap's `.container`) or fluid (like `.container-fluid`). The fixed
/// width container has a maximum width that adapts to the screen size.
///
/// **Example:**
/// ```dart
/// NextContainer(
///   fluid: false, // Fixed width container
///   padding: EdgeInsets.all(16),
///   children: [
///     Text('Content here'),
///   ],
/// )
/// ```
///
/// See also:
/// - [NextRow] for responsive row layouts
/// - [NextCol] for responsive column layouts
class NextContainer extends StatelessWidget {
  /// Creates a [NextContainer] widget.
  ///
  /// The [children] argument must not be null.
  /// If [fluid] is true, the container takes the full width.
  /// If [fluid] is false (default), the container has a maximum width
  /// that adapts to the screen size.
  const NextContainer({
    super.key,
    this.alignment = Alignment.topCenter,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.fluid = false,
    this.decoration,
    this.padding = EdgeInsets.zero,
  });

  ///
  /// Is the container fluid => if yes, takes the whole width
  /// Default value: false
  ///
  final bool fluid;

  ///
  /// Box Decoration to the widget
  ///
  final BoxDecoration? decoration;

  ///
  /// List of childrens
  ///
  final List<Widget> children;

  ///
  /// Padding
  ///
  final EdgeInsets padding;

  ///
  /// Alignment of children
  ///
  final Alignment alignment;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: Align(
            alignment: alignment,
            child: Container(
              decoration: decoration,
              padding: padding,
              width: fluid
                  ? context.width
                  : NextUtils.getMaxWidthForNonFluid(context.width),
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: mainAxisSize,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}
