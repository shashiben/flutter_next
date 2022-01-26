import '../flutter_next.dart';

class NextBreadCumb extends StatelessWidget {
  final List<NextBreadCumbItem> childrens;

  final Widget seperator;

  final double spacing;
  final int? limitTo;
  final Widget limitIndicator;

  const NextBreadCumb({
    Key? key,
    required this.childrens,
    this.limitIndicator = const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("...."),
    ),
    this.limitTo,
    this.spacing = 8.0,
    this.seperator = const Icon(
      Icons.chevron_right,
      size: 18.0,
    ),
  })  : assert((limitTo ?? 0) >= 0,
            "Limit to should be greater than zero or null."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _joinItems(),
      spacing: spacing,
      runSpacing: spacing,
      crossAxisAlignment: WrapCrossAlignment.center,
    );
  }

  List<Widget> _joinItems() {
    final List<Widget> _joinedItems = [];
    if (limitTo != null) {
      for (final item in childrens) {
        _joinedItems
          ..add(item)
          ..add(seperator);
      }
      _joinedItems.removeLast();
      if (_joinedItems.length > limitTo! + 2) {
        List<Widget> result = [];
        result
          ..add(_joinedItems.first)
          ..add(seperator);
        result
          ..add(limitIndicator)
          ..add(seperator);
        result.add(_joinedItems.last);
        return result;
      }

      return _joinedItems;
    } else {
      for (final item in childrens) {
        _joinedItems
          ..add(item)
          ..add(seperator);
      }
      _joinedItems.removeLast();
      return _joinedItems;
    }
  }
}
