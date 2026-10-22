import 'package:flutter/material.dart';

/// A bordered parent whose width is the layout the demo is teaching.
class DemoFrame extends StatelessWidget {
  /// Creates a frame of [width] around [child].
  const DemoFrame({required this.width, required this.child, super.key});

  /// Width of the parent the children measure.
  final double width;

  /// Contents. They should read this width, not the window.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: scheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          width: width,
          child: Padding(padding: const EdgeInsets.all(12), child: child),
        ),
      ),
    );
  }
}

/// A labeled block used inside grid demos.
class DemoCell extends StatelessWidget {
  /// Creates a cell showing [label].
  const DemoCell({required this.label, super.key});

  /// Text in the cell.
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 56,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 8),
      color: scheme.secondaryContainer,
      child: Text(label, style: TextStyle(color: scheme.onSecondaryContainer)),
    );
  }
}
