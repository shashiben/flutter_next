import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextAvatarGroup extends StatelessWidget {
  final List<ImageProvider> imagesList;
  final double widthFactor;
  final double radius;
  final double outerRadius;
  final int? limitTo;
  final int? itemCount;
  final Widget Function(BuildContext context, int hiddenitemCount)?
      limitBuilder;
  final Color? backgroundColor;
  final Widget Function(BuildContext context, int index, ImageProvider image)?
      itemBuilder;
  const NextAvatarGroup(
      {Key? key,
      this.limitBuilder,
      required this.imagesList,
      this.itemCount,
      this.outerRadius = 24.0,
      this.limitTo,
      this.itemBuilder,
      this.backgroundColor,
      this.widthFactor = 0.6,
      this.radius = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth:
            itemBuilder != null ? 0.0 : (imagesList.length) * (2 * outerRadius),
        maxHeight: outerRadius * 2,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (limitTo != null && imagesList.length > (limitTo ?? 0))
            ? limitTo! + 1
            : imagesList.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if ((limitTo != null && imagesList.length > (limitTo ?? 0)) &&
              index > (limitTo! - 1)) {
            return Align(
              widthFactor: widthFactor,
              child: CircleAvatar(
                radius: outerRadius,
                backgroundColor: backgroundColor ?? context.accentColor,
                child: limitBuilder != null
                    ? limitBuilder!(context, imagesList.length - limitTo!)
                    : Text("+${imagesList.length - limitTo!}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          } else {
            return Align(
              widthFactor: widthFactor,
              child: itemBuilder != null
                  ? itemBuilder!(context, index, imagesList[index])
                  : CircleAvatar(
                      radius: outerRadius,
                      backgroundColor: backgroundColor ?? context.accentColor,
                      child: CircleAvatar(
                        radius: radius,
                        backgroundImage: imagesList[index],
                      )),
            );
          }
        },
      ),
    );
  }
}
