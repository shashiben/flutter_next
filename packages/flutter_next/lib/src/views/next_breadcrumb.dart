import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../widgets/next_breadcrumb_item.dart';

/// A row or wrap of [NextBreadcrumbItem]s separated by [separator].
class NextBreadcrumb extends StatelessWidget {
  /// Creates a breadcrumb.
  const NextBreadcrumb({
    required this.children,
    this.primary = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.variant = NextBreadcrumbVariant.wrap,
    this.spacing = 8,
    this.separator = const Icon(Icons.chevron_right, size: 18),
    super.key,
  });

  /// Crumbs, in order.
  final List<NextBreadcrumbItem> children;

  /// Widget placed between crumbs.
  final Widget separator;

  /// Gap around each crumb and separator.
  final double spacing;

  /// Wrap onto new lines, or scroll horizontally.
  final NextBreadcrumbVariant variant;

  /// Scroll physics for [NextBreadcrumbVariant.scroll].
  final ScrollPhysics physics;

  /// Whether the horizontal scroller is the primary scroll view.
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final items = _joinItems();
    if (variant == NextBreadcrumbVariant.wrap) {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: items,
      );
    }
    return SingleChildScrollView(
      physics: physics,
      primary: primary,
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  List<Widget> _joinItems() {
    final joined = <Widget>[];
    for (final item in children) {
      joined
        ..add(item)
        ..add(separator);
    }
    if (joined.isNotEmpty) {
      joined.removeLast();
    }
    return joined;
  }
}
