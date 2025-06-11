import 'package:flutter/material.dart';

class NextActionParamBuilder extends NextRowBuilderParams {
  final int rowIndex;
  NextActionParamBuilder({required super.index, required super.defaultWidth, required this.rowIndex});
}

class NextHeaderBuilder extends NextRowBuilderParams {
  final dynamic value;
  NextHeaderBuilder({required this.value, required super.index, required super.defaultWidth});
}

class NextRowBuilderParams {
  final int index;
  final double defaultWidth;
  NextRowBuilderParams({required this.index, required this.defaultWidth});
}

class NextTableHeaderConfig {
  final List headerItems;
  final Widget Function(BuildContext, NextHeaderBuilder) headerBuilder;
  final BoxDecoration? decoration;
  final EdgeInsets? innerPadding;
  final EdgeInsets outerPadding;
  final TextStyle? textStyle;
  const NextTableHeaderConfig({
    required this.headerItems,
    required this.headerBuilder,
    this.decoration,
    this.innerPadding,
    this.outerPadding =const EdgeInsets.only(bottom: 10),
    this.textStyle,
  });
}

class NextTableRowConfig {
  final List<Widget> Function(BuildContext, NextRowBuilderParams) rowElementsBuilder;
  final BoxDecoration? elementsDecoration;
  final EdgeInsets? innerElementsPadding;
  final EdgeInsets outerPadding;
  final BoxDecoration Function(int, bool)? decorationBuilder;
  final Widget Function(BuildContext, int, Widget, bool)? rowBuilder;
  const NextTableRowConfig({
    required this.rowElementsBuilder,
    this.elementsDecoration,
    this.innerElementsPadding,
    this.outerPadding= const EdgeInsets.symmetric(vertical: 5),
    this.decorationBuilder,
    this.rowBuilder,
  });
}

class NextTableLoadingConfig {
  final Widget fullLoadingPlaceHolder;
  final Widget? loadingMorePlaceHolder;
  final Widget? onEmptyState;
  const NextTableLoadingConfig({
    required this.fullLoadingPlaceHolder,
    this.loadingMorePlaceHolder,
    this.onEmptyState,
  });
}

class NextTableActionConfig {
  final List? actions;
  final Widget Function(BuildContext, NextActionParamBuilder)? actionBuilder;
  final bool addSpacerToActions;
  const NextTableActionConfig({
    this.actions,
    this.actionBuilder,
    this.addSpacerToActions = true,
  });
}
