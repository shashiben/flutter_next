import '../flutter_next.dart';

class NextRow extends StatelessWidget {
  final List<NextCol> childrens;
  final double verticalSpacing, horizontalSpacing;
  final WrapAlignment horizontalAlignment;
  final WrapAlignment verticalAlignment;
  final VerticalDirection verticalDirection;
  const NextRow({
    Key? key,
    this.verticalDirection = VerticalDirection.down,
    this.verticalAlignment = WrapAlignment.start,
    required this.childrens,
    this.horizontalAlignment = WrapAlignment.start,
    this.horizontalSpacing = 20.0,
    this.verticalSpacing = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> wrapChildrens = [];
    List<List<NextCol>> horizontalChildrens = [];
    List<NextCol> verticalChildrens = [];
    int accumulatedWidth = 0;
    for (int i = 0; i < childrens.length; i++) {
      final NextCol col = childrens.elementAt(i);
      Map<String, int> allColValues = BootstrapUtils.getAllColValues(col.sizes);
      String currentPrefix = BootstrapUtils.getPrefixByWidth(context.width);

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
        String currentPrefix = BootstrapUtils.getPrefixByWidth(context.width);
        if (!subChild.invisibleFor.contains(currentPrefix)) {
          double offsetSize = subChild.getOffsetWidth(context);
          double spaceToRemove =
              child.length > 1 ? ((child.length - 1) * horizontalSpacing) : 0;
          for (NextCol offsetChecking in child) {
            double offsetSize = offsetChecking.getOffsetWidth(context);
            if (offsetSize > 0) {
              spaceToRemove += horizontalSpacing;
            }
          }

          double availableWidth = context.width - spaceToRemove;
          if (offsetSize > 0) {
            Map<String, int> prefixMap =
                BootstrapUtils.getAllOffsetsValue(subChild.offset);
            int currentSegmentValue = prefixMap[currentPrefix] ?? 0;
            double offsetWidth = availableWidth * (currentSegmentValue / 12);
            wrapChildrens.add(SizedBox(
              width: offsetWidth,
              child: Container(
                  color: Colors.orange,
                  height: 150,
                  child: Center(
                    child: Text("$offsetWidth"),
                  )),
            ));
          }
          Map<String, int> prefixMap =
              BootstrapUtils.getAllColValues(subChild.sizes);
          int currentSegmentValue = prefixMap[currentPrefix] ?? 0;
          double childWidth = availableWidth * (currentSegmentValue / 12);
          wrapChildrens.add(SizedBox(
            // child: subChild.child,
            child: Container(
                color: Colors.orange,
                height: 150,
                child: Center(
                  child: Text("$childWidth"),
                )),
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
  }
}
