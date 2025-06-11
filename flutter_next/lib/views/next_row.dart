import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../flutter_next.dart';

class NextRow extends StatelessWidget {
  const NextRow({
    super.key,
    this.padding = EdgeInsets.zero,
    this.verticalDirection = VerticalDirection.down,
    this.verticalAlignment = WrapAlignment.start,
    required this.children,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.horizontalAlignment = WrapAlignment.start,
    this.horizontalSpacing = 20.0,
    this.verticalSpacing = 20.0,
  });

  ///
  /// List of [NextCol] childrens
  ///
  final List<NextCol> children;

  ///
  /// Spacing between childrens default value is 20.0
  ///
  final double verticalSpacing, horizontalSpacing;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [verticalAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  final WrapAlignment horizontalAlignment;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [Wrap] in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [horizontalAlignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.

  final WrapAlignment verticalAlignment;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [alignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [alignment]
  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;
  final WrapCrossAlignment crossAxisAlignment;

  ///
  /// Padding to the widget
  ///
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        final List<Widget> wrapChildrens = <Widget>[];
        final List<List<NextCol>> horizontalChildrens = <List<NextCol>>[];
        List<NextCol> verticalChildrens = <NextCol>[];
        double accumulatedPer = 0;
        for (int i = 0; i < children.length; i++) {
          final NextCol col = children.elementAt(i);
          final Map<GridPrefix, double> allColValues = col.widthPercentages;
          final GridPrefix currentPrefix =
              NextUtils.getPrefixEnumByWidth(maxWidth);

          final double colPercentage = allColValues[currentPrefix] ?? 100;
          if (accumulatedPer + colPercentage > 100) {
            horizontalChildrens.add(verticalChildrens);
            verticalChildrens = <NextCol>[];
            accumulatedPer = 0;
          }

          verticalChildrens.add(col);
          accumulatedPer += colPercentage;
        }

        if (accumulatedPer >= 0) {
          horizontalChildrens.add(verticalChildrens);
        }
        for (final List<NextCol> child in horizontalChildrens) {
          for (final NextCol subChild in child) {
            final double spaceToRemove = (child.length > 1
                    ? ((child.length - 1) * horizontalSpacing)
                    : 0) /
                child.length;

            final double subChildSize =
                (maxWidth / child.length) - spaceToRemove;
            wrapChildrens.add(SizedBox(
              width: subChildSize,
              child: subChild.child,
            ));
          }
        }
        return Wrap(
          alignment: horizontalAlignment,
          crossAxisAlignment: crossAxisAlignment,
          runAlignment: verticalAlignment,
          runSpacing: verticalSpacing,
          spacing: horizontalSpacing,
          verticalDirection: verticalDirection,
          children: wrapChildrens,
        );
      }),
    );
  }
}
