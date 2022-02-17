import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget padding(
    double padding, {
    Key? key,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      key: key,
      child: this,
    );
  }

  Widget paddingSymmetric({
    required double horizontal,
    required double vertical,
    Key? key,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      key: key,
      child: this,
    );
  }

  Widget customPadding({
    Key? key,
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      key: key,
      child: this,
    );
  }
}
