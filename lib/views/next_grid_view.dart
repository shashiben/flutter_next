import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextGridView extends StatelessWidget {

  const NextGridView({
    super.key,
    required this.children,
    required this.widthPercentages,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.semanticChildCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
  });
  final List<Widget> children;
  final Map<GridPrefix, double> widthPercentages;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Clip clipBehavior;
  final int? semanticChildCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final double? mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _calculateCrossAxisCount(
            constraints.maxWidth, widthPercentages);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
            mainAxisExtent: mainAxisExtent,
          ),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          clipBehavior: clipBehavior,
          semanticChildCount: semanticChildCount,
          itemCount: children.length,
          itemBuilder: (context, index) {
            return children[index];
          },
        );
      },
    );
  }

  static int _calculateCrossAxisCount(
      double maxWidth, Map<GridPrefix, double> widthPercentages) {
    final GridPrefix currentSystemGridPrefix =
        NextUtils.getPrefixByWidth(maxWidth);
    final int percentageWidthForChild =
        (100 / (widthPercentages[currentSystemGridPrefix] ?? 100)).round();
    return percentageWidthForChild;
  }
}