import 'package:flutter/material.dart';

/// Tap gestures as widget methods.
extension GestureExtension on Widget {
  /// Wraps this widget in an [InkWell] that calls [onTap].
  Widget onTap(void Function() onTap, {bool autoFocus = false}) =>
      InkWell(onTap: onTap, autofocus: autoFocus, child: this);

  /// Wraps this widget in an [InkWell] that calls [onDoubleTap].
  Widget onDoubleTap(void Function() onDoubleTap, {bool autoFocus = false}) =>
      InkWell(autofocus: autoFocus, onDoubleTap: onDoubleTap, child: this);

  /// Wraps this widget in an [InkWell] that calls [onLongPress].
  Widget onLongPress(void Function() onLongPress, {bool autoFocus = false}) =>
      InkWell(autofocus: autoFocus, onLongPress: onLongPress, child: this);
}
