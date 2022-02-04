import 'package:flutter_next/flutter_next.dart';

class NextGridView extends StatelessWidget {
  ///
  /// Give bootstrap grid sizes
  ///
  final String sizes;

  ///
  /// List of [NextGridItem] widgets
  ///
  final List<NextGridItem> childrens;

  ///
  /// Give Horizontal and vertical spacing
  ///
  final double horizontalSpacing, verticalSpacing;
  const NextGridView(
      {Key? key,
      required this.sizes,
      required this.childrens,
      this.horizontalSpacing = 20.0,
      this.verticalSpacing = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String type = "";
    Map<String, int> sizeMap = {};
    List<List<Widget>> resultChildrens = [];
    resultChildrens = List.generate(12, (index) => []);
    sizeMap = NextUtils.getAllColValues(sizes);
    type = NextUtils.getPrefixByWidth(context.width);
    int sizeIndex = 0;
    for (Widget child in childrens) {
      resultChildrens[sizeIndex].add(child);
      sizeIndex = (sizeIndex + 1) % (12 ~/ (sizeMap[type]!));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildHorizontalChildrens(List.generate(
          12 ~/ (sizeMap[type] ?? 12),
          (index) => Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildVerticalChildrens(resultChildrens[index]),
              )))),
    );
  }

  List<Widget> _buildVerticalChildrens(List<Widget> childrens) {
    List<Widget> result = [];
    for (Widget element in childrens) {
      result.add(element);
      if (childrens.last != element) {
        result.add(SizedBox(
          height: verticalSpacing,
        ));
      }
    }
    return result;
  }

  List<Widget> _buildHorizontalChildrens(List<Widget> childrens) {
    List<Widget> result = [];
    for (Widget element in childrens) {
      result.add(element);
      if (childrens.last != element) {
        result.add(SizedBox(
          width: verticalSpacing,
        ));
      }
    }
    return result;
  }
}
