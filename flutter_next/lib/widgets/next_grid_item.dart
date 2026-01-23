import 'package:flutter/material.dart';

/// A grid item widget for the Next UI.
///
/// This is a simple wrapper widget that takes a child widget and builds it.
class NextGridItem extends StatelessWidget {
  const NextGridItem({super.key, required this.child});

  /// The child widget to be built by this grid item.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
