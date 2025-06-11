import 'package:flutter/material.dart';
import 'package:next_table/params.dart';

class ActionParamBuilder extends NextRowBuilderParams {
  final int rowIndex;
  ActionParamBuilder({required super.index, required super.defaultWidth, required this.rowIndex});
}

class AdvancedTableWidget extends StatelessWidget {
  final List? actions;
  final Widget Function(BuildContext, ActionParamBuilder)? actionBuilder;
  final List headerItems;
  final Widget Function(BuildContext, NextHeaderBuilder) headerBuilder;
  final List<Widget> Function(BuildContext, NextRowBuilderParams) rowElementsBuilder;
  final List items;
  final ValueNotifier<bool> isLoadingAll;
  final ValueNotifier<bool>? isLoadingMore;
  final Widget? onEmptyState;
  final BoxDecoration? headerDecoration;
  final EdgeInsets? innerHeaderPadding;
  final EdgeInsets? elementsPadding;
  final Widget fullLoadingPlaceHolder;
  final Widget? loadingMorePlaceHolder;
  final BoxDecoration? rowElementsDecoration;
  final EdgeInsets? innerRowElementsPadding;
  final TextStyle? headerTextStyle;
  final EdgeInsets? outerRowsPadding;
  final BoxDecoration Function(int, bool)? rowDecorationBuilder;
  final EdgeInsets? outerHeaderPadding;
  final bool addSpacerToActions;
  final void Function(int)? onRowTap;
  final Widget Function(BuildContext, int, Widget, bool)? rowBuilder;
  const AdvancedTableWidget({
    super.key,
    required this.headerBuilder,
    required this.rowElementsBuilder,
    required this.items,
    required this.isLoadingAll,
    this.isLoadingMore,
    this.onEmptyState,
    this.headerDecoration,
    this.innerHeaderPadding,
    required this.fullLoadingPlaceHolder,
    this.loadingMorePlaceHolder,
    this.elementsPadding,
    this.rowElementsDecoration,
    this.innerRowElementsPadding,
    this.headerTextStyle,
    this.outerRowsPadding,
    this.rowDecorationBuilder,
    this.outerHeaderPadding,
    required this.headerItems,
    this.actions,
    this.actionBuilder,
    this.addSpacerToActions = true,
    this.onRowTap,
    this.rowBuilder,
  });
  @override
  Widget build(BuildContext context) {
    final paddingObjects = elementsPadding ?? const EdgeInsets.symmetric(vertical: 5);
    return ValueListenableBuilder(
        valueListenable: isLoadingAll,
        builder: (context, isLoading, _) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isLoading
                  ? fullLoadingPlaceHolder
                  : LayoutBuilder(builder: (
                      context,
                      c,
                    ) {
                      final actionsLength = (actions?.length ?? 0);
                      final maxWidth = c.biggest.width;
                      final columnWidth = maxWidth / ((headerItems.length + 1) + actionsLength);
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.labelMedium!,
                              child: Padding(
                                padding: paddingObjects.add(outerHeaderPadding ?? const EdgeInsets.only(bottom: 10)),
                                child: Container(
                                  decoration: headerDecoration,
                                  padding: innerHeaderPadding,
                                  child: Row(
                                    children: [
                                      for (int i = 0; i < headerItems.length; i++) ...[
                                        headerBuilder(
                                            context,
                                            NextHeaderBuilder(
                                              value: headerItems[i],
                                              index: i,
                                              defaultWidth: columnWidth,
                                            )),
                                      ],
                                      if (addSpacerToActions) ...[
                                        const Spacer(),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (isLoadingMore != null)
                              ValueListenableBuilder(
                                  valueListenable: isLoadingMore!,
                                  builder: (context, loadingMore, _) {
                                    return AnimatedSize(
                                      duration: const Duration(milliseconds: 300),
                                      child: Visibility(
                                        visible: loadingMore,
                                        child: Padding(
                                          padding: paddingObjects,
                                          child: loadingMorePlaceHolder ?? LinearProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  }),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: items.isEmpty
                                  ? onEmptyState
                                  : ListView.builder(
                                      padding: outerRowsPadding,
                                      itemBuilder: (context, index) {
                                        final hoverState = ValueNotifier(false);
                                        final rowElements = rowElementsBuilder(
                                            context,
                                            NextRowBuilderParams(
                                                index: index,
                                                defaultWidth: columnWidth));
                                        return ValueListenableBuilder(
                                            valueListenable: hoverState,
                                            builder: (context, isHover, _) {
                                              final widget =
                                                  ValueListenableBuilder(
                                                      valueListenable:
                                                          hoverState,
                                                      builder: (context,
                                                          isHover, _) {
                                                        return Padding(
                                                          padding:
                                                              paddingObjects,
                                                          child: InkWell(
                                                            onTap: () =>
                                                                onRowTap?.call(
                                                                    index),
                                                            onHover: (value) {
                                                              hoverState.value =
                                                                  value;
                                                            },
                                                            borderRadius: BorderRadius.all((rowElementsDecoration ??
                                                                    rowDecorationBuilder
                                                                        ?.call(
                                                                            index,
                                                                            isHover) ??
                                                                    const BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10))))
                                                                .borderRadius!
                                                                .resolve(null)
                                                                .bottomLeft),
                                                            child:
                                                                AnimatedContainer(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              decoration: rowElementsDecoration ??
                                                                  rowDecorationBuilder
                                                                      ?.call(
                                                                          index,
                                                                          isHover),
                                                              padding:
                                                                  innerRowElementsPadding,
                                                              child: Builder(
                                                                  builder:
                                                                      (context) {
                                                                final list = [
                                                                  for (int i = 0; i < rowElements.length; i++) ...[
                                                                    rowElements[i],
                                                                  ],
                                                                  if (addSpacerToActions) ...[
                                                                    const Spacer(),
                                                                  ],
                                                                  if (actions != null)
                                                                    for (int i = 0; i < actions!.length; i++) ...[
                                                                      actionBuilder!.call(
                                                                          context,
                                                                          ActionParamBuilder(
                                                                              rowIndex: index,
                                                                              index: i,
                                                                              defaultWidth: columnWidth * .5))
                                                                    ]
                                                                ];
                                                                return Row(
                                                                  children:
                                                                      list,
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        );
                                                     });
                                              return rowBuilder?.call(context,
                                                      index, widget, isHover) ??
                                                  widget;
                                            });
                                      },
                                      itemCount: items.length,
                                    ),
                            )),
                          ],
                        ),
                      );
                    }));
        });
  }
}