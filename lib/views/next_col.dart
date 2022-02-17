import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextCol extends StatelessWidget {
  final String sizes;
  final BoxDecoration? decoration;
  final String offset;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final List<String> invisibleFor;
  final Widget child;
  const NextCol(
      {Key? key,
      this.sizes = "col-12",
      required this.child,
      this.decoration,
      this.margin,
      this.padding,
      this.offset = "",
      this.invisibleFor = const <String>[]})
      : super(key: key);
  double getWidthOfChild(context) {
    return NextUtils.getMaxWidth(sizes, context: context);
  }

  double getOffsetWidth(context) {
    return NextUtils.getMaxWidth(offset, context: context, isOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
