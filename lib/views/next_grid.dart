import '../flutter_next.dart';

class NextGrid extends StatefulWidget {
  final String sizes;
  final List<NextGridItem> childrens;
  final double horizontalSpacing, verticalSpacing;
  const NextGrid(
      {Key? key,
      required this.sizes,
      required this.childrens,
      this.horizontalSpacing = 20.0,
      this.verticalSpacing = 20.0})
      : super(key: key);

  @override
  State<NextGrid> createState() => _NextGridState();
}

class _NextGridState extends State<NextGrid> {
  Map<String, int> sizeMap = {};
  List<List<NextGridItem>> childrens = [];
  String type = "";
  void arrangeChildrens() {
    childrens = List.generate(12, (index) => []);
    type = BootstrapUtils.getPrefixByWidth(context.width);
    int sizeIndex = 0;
    for (NextGridItem child in widget.childrens) {
      sizeMap = BootstrapUtils.getAllColValues(child.sizes ?? widget.sizes);
      childrens[sizeIndex].add(child);
      sizeIndex = (sizeIndex + 1) % (12 ~/ (sizeMap[type]!));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    arrangeChildrens();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildHorizontalChildrens(List.generate(
          12 ~/ (sizeMap[type] ?? 12),
          (index) => Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildVerticalChildrens(childrens[index]),
              )))),
    );
  }

  List<Widget> _buildVerticalChildrens(List<NextGridItem> childrens) {
    List<Widget> result = [];
    for (Widget element in childrens) {
      result.add(element);
      if (childrens.last != element) {
        result.add(SizedBox(
          height: widget.verticalSpacing,
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
          width: widget.verticalSpacing,
        ));
      }
    }
    return result;
  }
}
