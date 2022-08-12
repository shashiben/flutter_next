import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextBreadCumb extends StatelessWidget {
  ///
  /// Childrens
  ///
  final List<NextBreadCumbItem> childrens;

  /// Separator between items
  final Widget seperator;

  /// Space between items, default value is 8.0
  final double spacing;

  ///
  /// Bread cumb variant
  ///
  final NextBreadCumbVariant variant;

  ///
  /// Physics for [NextBreadCumbVariant.scroll]
  ///
  final ScrollPhysics physics;

  /// Whther primary for [NextBreadCumbVariant.scroll] should be true or not
  final bool primary;

  const NextBreadCumb({
    Key? key,
    required this.childrens,
    this.primary = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.variant = NextBreadCumbVariant.wrap,
    this.spacing = 8.0,
    this.seperator = const Icon(
      Icons.chevron_right,
      size: 18.0,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return variant == NextBreadCumbVariant.wrap
        ? Wrap(
            spacing: spacing,
            runSpacing: spacing,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: _joinItems(),
          )
        : SingleChildScrollView(
            physics: physics,
            primary: primary,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _joinItems(),
            ),
          );
  }

  List<Widget> _joinItems() {
    final List<Widget> joinedItems = [];

    for (final item in childrens) {
      joinedItems
        ..add(item)
        ..add(seperator);
    }
    joinedItems.removeLast();
    return joinedItems;
  }
}
