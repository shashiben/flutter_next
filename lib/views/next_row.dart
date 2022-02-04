import 'package:nil/nil.dart';

import '../flutter_next.dart';

class NextRow extends StatelessWidget {
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

  ///
  /// Padding to the widget
  ///
  final EdgeInsets padding;
  const NextRow({
    Key? key,
    this.padding = const EdgeInsets.all(0),
    this.verticalDirection = VerticalDirection.down,
    this.verticalAlignment = WrapAlignment.start,
    required this.children,
    this.horizontalAlignment = WrapAlignment.start,
    this.horizontalSpacing = 20.0,
    this.verticalSpacing = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: LayoutBuilder(builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        List<Widget> wrapChildrens = [];
        List<List<NextCol>> horizontalChildrens = [];
        List<NextCol> verticalChildrens = [];
        int accumulatedWidth = 0;
        for (int i = 0; i < children.length; i++) {
          final NextCol col = children.elementAt(i);
          Map<String, int> allColValues = NextUtils.getAllColValues(col.sizes);
          String currentPrefix = NextUtils.getPrefixByWidth(maxWidth);

          final int colWidth = allColValues[currentPrefix] ?? 12;
          if (accumulatedWidth + colWidth > 12) {
            horizontalChildrens.add((verticalChildrens));
            verticalChildrens = <NextCol>[];
            accumulatedWidth = 0;
          }

          verticalChildrens.add(col);
          accumulatedWidth += colWidth;
        }

        if (accumulatedWidth >= 0) {
          horizontalChildrens.add(
            verticalChildrens,
          );
        }
        for (List<NextCol> child in horizontalChildrens) {
          for (NextCol subChild in child) {
            String currentPrefix = NextUtils.getPrefixByWidth(maxWidth);
            if (!subChild.invisibleFor.contains(currentPrefix)) {
              double offsetSize = subChild.getOffsetWidth(context);
              double spaceToRemove = child.length > 1
                  ? ((child.length - 1) * horizontalSpacing)
                  : 0;
              for (NextCol offsetChecking in child) {
                double offsetSize = offsetChecking.getOffsetWidth(context);
                if (offsetSize > 0) {
                  spaceToRemove += horizontalSpacing;
                }
              }

              double availableWidth = maxWidth - spaceToRemove;
              if (offsetSize > 0) {
                Map<String, int> prefixMap =
                    NextUtils.getAllOffsetsValue(subChild.offset);
                int currentSegmentValue = prefixMap[currentPrefix] ?? 0;
                double offsetWidth =
                    availableWidth * (currentSegmentValue / 12);
                wrapChildrens.add(SizedBox(
                  width: offsetWidth,
                  child: const Nil(),
                ));
              }
              Map<String, int> prefixMap =
                  NextUtils.getAllColValues(subChild.sizes);
              int currentSegmentValue = prefixMap[currentPrefix] ?? 0;
              double childWidth = availableWidth * (currentSegmentValue / 12);
              wrapChildrens.add(Container(
                padding: subChild.padding,
                margin: subChild.margin,
                decoration: subChild.decoration,
                child: subChild.child,
                width: childWidth,
              ));
            }
          }
        }
        return Wrap(
          runSpacing: verticalSpacing,
          spacing: horizontalSpacing,
          verticalDirection: verticalDirection,
          alignment: horizontalAlignment,
          runAlignment: verticalAlignment,
          children: wrapChildrens,
        );
      }),
    );
  }
}
