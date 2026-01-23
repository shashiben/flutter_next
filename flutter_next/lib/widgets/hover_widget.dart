import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as io;

/// A widget that changes its appearance when hovered over or touched.
///
/// This widget provides a builder function that defines how it should appear
/// based on its hover state. It can be used for both mouse and touch interactions.
/// The hover effect is customizable with a transition duration.
///
/// ## Example Usage:
/// ```dart
/// HoverableWidget(
///   hoverTransitionDuration: Duration(milliseconds: 500),
///   hoverBuilder: (context, isHovered) {
///     return Container(
///       color: isHovered ? Colors.blue : Colors.green,
///       child: Center(child: Text('Hover Me')),
///     );
///   },
/// )
/// ```
class HoverableWidget extends StatefulWidget {
  const HoverableWidget({
    super.key,
    required this.hoverBuilder,
    this.hoverTransitionDuration = const Duration(milliseconds: 300),
  });

  /// The duration for the widget to return to its original state after
  /// being hovered over.
  ///
  /// Defaults to 300 milliseconds. This is the time taken for the widget
  /// to transition back to its original state after the hover state ends.
  final Duration hoverTransitionDuration;

  /// A function that builds the widget depending on its hover state.
  ///
  /// The function takes the [BuildContext] and a boolean [isHovered] indicating
  /// whether the widget is currently hovered or touched. It should return a
  /// widget that represents the current appearance of the HoverableWidget.
  final Widget Function(BuildContext context, bool isHovered) hoverBuilder;

  @override
  State<HoverableWidget> createState() => _HoverableWidgetState();
}

class _HoverableWidgetState extends State<HoverableWidget> {
  /// The current hover state of the widget (true if hovered, false otherwise).
  bool _isHovered = false;

  /// A flag to determine whether a touch event has ended and hover should reset.
  bool _isTouchEventInProgress = false;

  @override
  Widget build(BuildContext context) {
    return io.Platform.isAndroid || io.Platform.isIOS
        ? GestureDetector(
            // Handle touch events by setting the hover state to true when a touch begins
            // and resetting after the hover transition duration ends.
            onPanDown: (_) {
              _updateHoverState(true);
            },
            onPanCancel: () {
              _resetHoverStateAfterDelay();
            },
            onPanEnd: (_) {
              _resetHoverStateAfterDelay();
            },
            child: widget.hoverBuilder(context, _isHovered),
          )
        : MouseRegion(
            // When the mouse enters, update the hover state to true
            onEnter: (_) => _updateHoverState(true),
            // When the mouse exits, update the hover state to false
            onExit: (_) => _updateHoverState(false),
            child: widget.hoverBuilder(context, _isHovered),
          );
  }

  /// Updates the hover state to the specified value and triggers a rebuild if necessary.
  void _updateHoverState(bool isHovered) {
    if (_isHovered != isHovered && mounted) {
      setState(() {
        _isHovered = isHovered;
      });
    }
  }

  /// Resets the hover state to false after the specified delay.
  ///
  /// This is triggered when a touch event ends or when a user stops hovering.
  void _resetHoverStateAfterDelay() {
    if (_isTouchEventInProgress) {
      return;
    }
    _isTouchEventInProgress = true;
    Future.delayed(widget.hoverTransitionDuration, () {
      _updateHoverState(false);
      _isTouchEventInProgress = false;
    });
  }
}
