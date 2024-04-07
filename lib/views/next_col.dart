import 'package:flutter/material.dart';

import '../flutter_next.dart';

class NextCol extends StatelessWidget {
  const NextCol(
      {super.key,
      required this.widthPercentages, 
      required this.child,
      this.decoration,
      this.margin,
      this.padding,
      this.offset = const{},
      this.invisibleFor = const <GridPrefix>[]});
  final Map<GridPrefix, double>
      widthPercentages; 
  final BoxDecoration? decoration;
  final  Map<GridPrefix,double> offset;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final List<GridPrefix> invisibleFor;
  final Widget child;

  double getWidthOfChild(double availableWidth, GridPrefix prefix) {
    double? widthPercentage;
    for (final GridPrefix p in GridPrefix.values.reversed) {
      widthPercentage = widthPercentages[p];
      if (widthPercentage != null || p == prefix) {
        break;
      }
    }
    widthPercentage ??=
        100; 

    return availableWidth * (widthPercentage / 100);
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
