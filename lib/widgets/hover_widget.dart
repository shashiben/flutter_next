import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as io;

/// A widget that changes its appearance when hovered over.
///
/// The appearance of the widget is defined by a builder function, which
/// receives the current hover state as a parameter.
class HoverableWidget extends StatefulWidget {
  const HoverableWidget({
    super.key,
    required this.hoverBuilder,
    this.hoverTransitionDuration = const Duration(milliseconds: 1200),
  });

  /// The duration for the widget to return back to its original state after
  /// being hovered over.
  ///
  /// Defaults to 1200 milliseconds.
  final Duration hoverTransitionDuration;

  /// A function that builds the widget depending on its hover state.
  ///
  /// The function should return a widget that represents the current appearance
  /// of the HoverableWidget. It receives the current [BuildContext] and a boolean
  /// indicating whether the widget is currently being hovered over.
  final Widget Function(BuildContext context, bool isHovered) hoverBuilder;

  @override
  State<HoverableWidget> createState() => _HoverableWidgetState();
}

class _HoverableWidgetState extends State<HoverableWidget> {
  /// Indicates whether the widget is currently being hovered over.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // For touch devices (Android and iOS), we use a GestureDetector to handle
    // the hover state. For non-touch devices, we use a MouseRegion.
    return io.Platform.isAndroid || io.Platform.isIOS
        ? GestureDetector(
            // When the user stops touching the screen, we start a timer that
            // resets the hover state after the specified duration.
            onPanCancel: () => _updateHoverStateAfterDelay(false),
            // When the user starts touching the screen, we set the hover state
            // to true.
            onPanDown: (_) => _updateHoverState(true),
            child: widget.hoverBuilder(context, _isHovered),
          )
        : MouseRegion(
            // When the mouse enters the widget, we set the hover state to true.
            onEnter: (_) => _updateHoverState(true),
            // When the mouse leaves the widget, we set the hover state to false.
            onExit: (_) => _updateHoverState(false),
            child: widget.hoverBuilder(context, _isHovered),
          );
  }

  void _updateHoverState(bool isHovered) {
    if (_isHovered != isHovered && mounted) {
      setState(() {
        _isHovered = isHovered;
      });
    }
  }

  void _updateHoverStateAfterDelay(bool isHovered) {
    Future<bool>.delayed(widget.hoverTransitionDuration)
        .then((_) => _updateHoverState(isHovered));
  }
}
