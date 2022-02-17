import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextBreadCumbItem extends StatelessWidget {
  ///
  /// if [isHovered] --> true then widget is hovered
  /// By this hover value we can show highlight for that widget
  final Widget Function(bool isHovered) child;
  const NextBreadCumbItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
        builder: (_, isHovered) => child(
              isHovered,
            ));
  }
}
