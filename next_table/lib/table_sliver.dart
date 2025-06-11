import 'package:flutter/material.dart';
import 'package:next_table/params.dart';

class NextTableSliver extends StatelessWidget {
  final NextTableHeaderConfig headerConfig;
  final NextTableRowConfig rowConfig;
  final NextTableLoadingConfig loadingConfig;
  final NextTableActionConfig actionConfig;
  final List items;
  final ValueNotifier<bool> isLoadingAll;
  final ValueNotifier<bool>? isLoadingMore;
  final void Function(int)? onRowTap;

  const NextTableSliver({
    super.key,
    required this.headerConfig,
    required this.rowConfig,
    required this.loadingConfig,
    required this.actionConfig,
    required this.items,
    required this.isLoadingAll,
    this.isLoadingMore,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    final paddingObjects = rowConfig.outerPadding;
    return ValueListenableBuilder(
        valueListenable: isLoadingAll,
        builder: (context, isLoading, _) {
          return SliverMainAxisGroup(
            slivers: [
              if (isLoading)
                SliverFillRemaining(child: loadingConfig.fullLoadingPlaceHolder)
              else ...[
                SliverLayoutBuilder(builder: (context, constraints) {
                  final actionsLength = (actionConfig.actions?.length ?? 0);
                  final maxWidth = constraints.crossAxisExtent;
                  final columnWidth = maxWidth /
                      ((headerConfig.headerItems.length + 1) + actionsLength);
                  return SliverToBoxAdapter(
                    child: DefaultTextStyle(
                      style: headerConfig.textStyle ??
                          Theme.of(context).textTheme.labelMedium!,
                      child: Padding(
                        padding: paddingObjects.add(headerConfig.outerPadding),
                        child: Container(
                          decoration: headerConfig.decoration,
                          padding: headerConfig.innerPadding,
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < headerConfig.headerItems.length;
                                  i++) ...[
                                headerConfig.headerBuilder(
                                    context,
                                    NextHeaderBuilder(
                                      value: headerConfig.headerItems[i],
                                      index: i,
                                      defaultWidth: columnWidth,
                                    )),
                              ],
                              if (actionConfig.addSpacerToActions) ...[
                                const Spacer(),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                if (isLoadingMore != null)
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder(
                        valueListenable: isLoadingMore!,
                        builder: (context, loadingMore, _) {
                          return AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Visibility(
                              visible: loadingMore,
                              child: Padding(
                                padding: paddingObjects,
                                child: loadingConfig.loadingMorePlaceHolder ??
                                    const LinearProgressIndicator(),
                              ),
                            ),
                          );
                        }),
                  ),
                if (items.isEmpty)
                  SliverFillRemaining(child: loadingConfig.onEmptyState)
                else
                  SliverLayoutBuilder(builder: (context, constraints) {
                    final actionsLength = (actionConfig.actions?.length ?? 0);
                    final maxWidth = constraints.crossAxisExtent;
                    final columnWidth = maxWidth /
                        ((headerConfig.headerItems.length + 1) + actionsLength);
                    return SliverList.builder(
                      itemBuilder: (context, index) {
                        final hoverState = ValueNotifier(false);
                        final rowElements = rowConfig.rowElementsBuilder(
                            context,
                            NextRowBuilderParams(
                                index: index, defaultWidth: columnWidth));
                        return Padding(
                          padding: rowConfig.outerPadding,
                          child: ValueListenableBuilder(
                              valueListenable: hoverState,
                              builder: (context, isHover, _) {
                                final widget = ValueListenableBuilder(
                                    valueListenable: hoverState,
                                    builder: (context, isHover, _) {
                                      return Padding(
                                        padding: paddingObjects,
                                        child: InkWell(
                                          onTap: () => onRowTap?.call(index),
                                          onHover: (value) {
                                            hoverState.value = value;
                                          },
                                          borderRadius: BorderRadius.all(
                                              (rowConfig.elementsDecoration ??
                                                      rowConfig
                                                          .decorationBuilder
                                                          ?.call(
                                                              index, isHover) ??
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))))
                                                  .borderRadius!
                                                  .resolve(null)
                                                  .bottomLeft),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            decoration:
                                                rowConfig.elementsDecoration ??
                                                    rowConfig.decorationBuilder
                                                        ?.call(index, isHover),
                                            padding:
                                                rowConfig.innerElementsPadding,
                                            child: Builder(builder: (context) {
                                              final list = [
                                                for (int i = 0;
                                                    i < rowElements.length;
                                                    i++) ...[
                                                  rowElements[i],
                                                ],
                                                if (actionConfig
                                                    .addSpacerToActions) ...[
                                                  const Spacer(),
                                                ],
                                                if (actionConfig.actions !=
                                                    null)
                                                  for (int i = 0;
                                                      i <
                                                          actionConfig
                                                              .actions!.length;
                                                      i++) ...[
                                                    actionConfig.actionBuilder!
                                                        .call(
                                                            context,
                                                            NextActionParamBuilder(
                                                                rowIndex: index,
                                                                index: i,
                                                                defaultWidth:
                                                                    columnWidth *
                                                                        .5))
                                                  ]
                                              ];
                                              return Row(
                                                children: list,
                                              );
                                            }),
                                          ),
                                        ),
                                      );
                                    });
                                return rowConfig.rowBuilder?.call(
                                        context, index, widget, isHover) ??
                                    widget;
                              }),
                        );
                      },
                      itemCount: items.length,
                    );
                  }),
              ],
            ],
          );
        });
  }
}
