import 'package:flutter_next/flutter_next.dart';

import '../app/colors.dart';

class NavigationDrawer extends StatefulWidget {
  final Color? color;
  final BoxDecoration? decoration;
  final Widget leading;
  final EdgeInsets? padding;
  final ScrollController? scrollController;
  final Widget? menuIcon;
  final List<Widget> childrens;
  final double minWidth;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  const NavigationDrawer(
      {Key? key,
      this.color,
      this.scrollController,
      this.mainAxisAlignment = MainAxisAlignment.end,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.decoration,
      required this.childrens,
      this.menuIcon,
      this.minWidth = 992,
      this.leading = const SizedBox(),
      this.padding})
      : assert(
          color == null || decoration == null,
          'Cannot provide both a color and a decoration\n'
          'To provide both, use "decoration: BoxDecoration(color: color)".',
        ),
        super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: context.width,
      decoration: widget.decoration ??
          BoxDecoration(
            boxShadow: (widget.scrollController == null ||
                    (widget.scrollController?.offset ?? 0) < 250)
                ? null
                : [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      spreadRadius: 20,
                      blurRadius: 5,
                      offset: const Offset(10, 7),
                    ),
                  ],
            color: widget.color ?? context.themeData.scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                  width: (widget.scrollController == null ||
                          (widget.scrollController?.offset ?? 0) < 250)
                      ? 0.8
                      : 1,
                  color: Colors.grey[300]!),
            ),
          ),
      child: Row(children: [
        widget.leading,
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: context.width > widget.minWidth
              ? widget.childrens
              : [
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        showDialog<void>(
                            barrierColor: context.primaryColor.withOpacity(0.9),
                            context: context,
                            builder: (_) => Material(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: context.width,
                                        child: Card(
                                          elevation: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: widget.childrens,
                                          ).container(
                                              const EdgeInsets.symmetric(
                                                  vertical: 20)),
                                        ).container(const EdgeInsets.symmetric(
                                            vertical: 20)),
                                      ))
                                    ],
                                  ).container(const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 25)),
                                ));
                      },
                      icon: widget.menuIcon ??
                          const Icon(
                            Icons.menu,
                            color: textPrimaryColor,
                          )),
                ],
        )),
      ]),
    );
  }
}
