import 'package:flutter/material.dart';

/// A [NextAvatarGroup] is a widget that displays a horizontal list of avatars.
/// It takes a list of images and displays them as circular avatars.
/// If the number of images exceeds a certain limit, it shows the excess count on the last avatar.
class NextAvatarGroup extends StatelessWidget {
  const NextAvatarGroup({
    super.key,
    this.excessCountBuilder,
    required this.avatarImages,
    this.outerRadius = 24.0,
    this.displayLimit,
    this.avatarBuilder,
    this.avatarBackgroundColor,
    this.widthReductionFactor = 0.6,
    this.innerRadius = 20.0,
  });

  /// List of images to be displayed as avatars.
  final List<ImageProvider> avatarImages;

  /// Factor by which to reduce the width of the avatars.
  final double widthReductionFactor;

  /// Radius of the inner avatar.
  final double innerRadius;

  /// Radius of the outer avatar.
  final double outerRadius;

  /// Limit to the number of avatars to be displayed.
  final int? displayLimit;

  /// Function to build the widget that displays the excess count.
  final Widget Function(BuildContext context, int hiddenCount)?
      excessCountBuilder;

  /// Background color of the avatars.
  final Color? avatarBackgroundColor;

  /// Function to build the avatar widget.
  final Widget Function(BuildContext context, int index, ImageProvider image)?
      avatarBuilder;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: avatarBuilder != null
            ? 0.0
            : (avatarImages.length) * (2 * outerRadius),
        maxHeight: outerRadius * 2,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            (displayLimit != null && avatarImages.length > (displayLimit ?? 0))
                ? displayLimit! + 1
                : avatarImages.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if ((displayLimit != null &&
                  avatarImages.length > (displayLimit ?? 0)) &&
              index > (displayLimit! - 1)) {
            return Align(
              widthFactor: widthReductionFactor,
              child: CircleAvatar(
                radius: outerRadius,
                backgroundColor: avatarBackgroundColor,
                child: excessCountBuilder != null
                    ? excessCountBuilder!(
                        context, avatarImages.length - displayLimit!)
                    : Text('+${avatarImages.length - displayLimit!}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          } else {
            return Align(
              widthFactor: widthReductionFactor,
              child: avatarBuilder != null
                  ? avatarBuilder!(context, index, avatarImages[index])
                  : CircleAvatar(
                      radius: outerRadius,
                      backgroundColor: avatarBackgroundColor,
                      child: CircleAvatar(
                        radius: innerRadius,
                        backgroundImage: avatarImages[index],
                      )),
            );
          }
        },
      ),
    );
  }
}
