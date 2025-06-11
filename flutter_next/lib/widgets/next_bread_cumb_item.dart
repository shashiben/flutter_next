import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A breadcrumb item that changes its appearance when hovered over.
///
/// The appearance of the breadcrumb item is defined by a builder function, which
/// receives the current hover state as a parameter.
class NextBreadcrumbItem extends StatelessWidget {
  const NextBreadcrumbItem({super.key, required this.hoverBuilder});

  /// A function that builds the breadcrumb item depending on its hover state.
  ///
  /// The function should return a widget that represents the current appearance
  /// of the NextBreadcrumbItem. It receives a boolean indicating whether the widget
  /// is currently being hovered over.
  final Widget Function(BuildContext context, bool isHovered) hoverBuilder;

  @override
  Widget build(BuildContext context) {
    return HoverableWidget(
      hoverBuilder: (_, bool isHovered) => hoverBuilder(context, isHovered),
    );
  }
}
