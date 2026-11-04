import 'package:flutter/material.dart';

/// Padding helpers for any widget.
extension PaddingExtension on Widget {
  /// Pads every side by [padding].
  Widget pad(double padding, {Key? key}) {
    return Padding(padding: EdgeInsets.all(padding), key: key, child: this);
  }

  /// Pads [horizontal] and [vertical] independently.
  Widget paddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
    Key? key,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      key: key,
      child: this,
    );
  }

  /// Pads each side by its own amount.
  Widget customPadding({
    Key? key,
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      key: key,
      child: this,
    );
  }
}
