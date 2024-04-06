import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextGridView extends StatelessWidget {
  const NextGridView(
      {super.key,
      required this.sizes,
      required this.childrens,
      this.horizontalSpacing = 20.0,
      this.verticalSpacing = 20.0});

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

  @override
  Widget build(BuildContext context) {
    String type = '';
    Map<String, int> sizeMap = <String, int>{};
    List<List<Widget>> resultChildrens = <List<Widget>>[];
    resultChildrens = List.generate(12, (int index) => <Widget>[]);
    sizeMap = NextUtils.getAllColValues(sizes);
    type = NextUtils.getPrefixByWidth(context.width);
    int sizeIndex = 0;
    for (final Widget child in childrens) {
      resultChildrens[sizeIndex].add(child);
      sizeIndex = (sizeIndex + 1) % (12 ~/ (sizeMap[type]!));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildHorizontalChildrens(List.generate(
          12 ~/ (sizeMap[type] ?? 12),
          (int index) => Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildVerticalChildrens(resultChildrens[index]),
              )))),
    );
  }

  List<Widget> _buildVerticalChildrens(List<Widget> childrens) {
    final List<Widget> result = <Widget>[];
    for (final Widget element in childrens) {
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
    final List<Widget> result = <Widget>[];
    for (final Widget element in childrens) {
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
