import 'package:flutter/material.dart';

extension GestureExtension on Widget {
  Widget onTap(void Function() onTap, {bool autoFocus = false}) => InkWell(
        onTap: onTap,
        autofocus: autoFocus,
        child: this,
      );
  Widget onDoubleTap(void Function() onDoubleTap, {bool autoFocus = false}) =>
      InkWell(
        autofocus: autoFocus,
        onDoubleTap: onDoubleTap,
        child: this,
      );
  Widget onLongPress(void Function() onLongPress, {bool autoFocus = false}) =>
      InkWell(
        autofocus: autoFocus,
        onLongPress: onLongPress,
        child: this,
      );
}
