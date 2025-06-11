import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextBreadCumb extends StatelessWidget {
  const NextBreadCumb({
    super.key,
    required this.childrens,
    this.primary = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.variant = NextBreadcrumbVariant.wrap,
    this.spacing = 8.0,
    this.seperator = const Icon(
      Icons.chevron_right,
      size: 18.0,
    ),
  });

  ///
  /// Childrens
  ///
  final List<NextBreadcrumbItem> childrens;

  /// Separator between items
  final Widget seperator;

  /// Space between items, default value is 8.0
  final double spacing;

  ///
  /// Bread cumb variant
  ///
  final NextBreadcrumbVariant variant;

  ///
  /// Physics for [NextBreadCumbVariant.scroll]
  ///
  final ScrollPhysics physics;

  /// Whther primary for [NextBreadCumbVariant.scroll] should be true or not
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return variant == NextBreadcrumbVariant.wrap
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
    final List<Widget> joinedItems = <Widget>[];

    for (final NextBreadcrumbItem item in childrens) {
      joinedItems
        ..add(item)
        ..add(seperator);
    }
    joinedItems.removeLast();
    return joinedItems;
  }
}
