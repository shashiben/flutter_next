import 'package:flutter_next/flutter_next.dart';

class CompanyLogoItem extends StatefulWidget {
  final String image;
  const CompanyLogoItem({Key? key, required this.image}) : super(key: key);

  @override
  State<CompanyLogoItem> createState() => _CompanyLogoItemState();
}

class _CompanyLogoItemState extends State<CompanyLogoItem>
    with SingleTickerProviderStateMixin {
  late AnimationController scaleController;
  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth * 0.45;
      return Center(
        child: SizedBox(
          width: width,
          child: HoverWidget(builder: (BuildContext context, bool isHovered) {
            if (isHovered) {
              scaleController.forward();
            } else {
              scaleController.reverse();
            }
            return ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.15).animate(scaleController),
                child: Image.asset(
                  widget.image,
                  width: width,
                  color: (isHovered || context.isMobile) ? null : Colors.grey,
                ));
          }),
        ),
      );
    });
  }
}
