import 'package:flutter/material.dart';

/// Reports whether a pointer is over [child].
class HoverableWidget extends StatefulWidget {
  /// Creates a hover region.
  const HoverableWidget({
    required this.hoverBuilder,
    this.hoverTransitionDuration = const Duration(milliseconds: 300),
    super.key,
  });

  /// Kept so existing call sites compile. Hover state itself is not animated.
  final Duration hoverTransitionDuration;

  /// Builds the child for the current hover state.
  final Widget Function(BuildContext context, bool isHovered) hoverBuilder;

  @override
  State<HoverableWidget> createState() => _HoverableWidgetState();
}

class _HoverableWidgetState extends State<HoverableWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: widget.hoverBuilder(context, _hovered),
    );
  }

  void _setHovered(bool hovered) {
    if (_hovered == hovered || !mounted) {
      return;
    }
    setState(() => _hovered = hovered);
  }
}
