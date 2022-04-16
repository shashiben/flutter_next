import 'package:flutter/material.dart';

class NextGridItem extends StatelessWidget {
  ///
  /// Child
  ///
  final Widget child;
  const NextGridItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
