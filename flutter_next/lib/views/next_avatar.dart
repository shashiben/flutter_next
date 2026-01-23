import 'package:flutter/material.dart';

/// Abstract base class for avatar content types.
///
/// Use [IconAvatar], [ImageAvatar], or [TextAvatar] to provide
/// different types of avatar content.
abstract class NextAvatarChild {}

/// Avatar content that displays an icon.
class IconAvatar implements NextAvatarChild {
  /// Creates an [IconAvatar] with the given [icon].
  const IconAvatar(this.icon);

  /// The icon to display in the avatar.
  final IconData icon;
}

/// Avatar content that displays an image from a URL.
class ImageAvatar implements NextAvatarChild {
  /// Creates an [ImageAvatar] with the given [imageUrl].
  const ImageAvatar(this.imageUrl);

  /// The URL of the image to display in the avatar.
  final String imageUrl;
}

/// Avatar content that displays text (typically initials).
class TextAvatar implements NextAvatarChild {
  /// Creates a [TextAvatar] with the given [text].
  const TextAvatar(this.text);

  /// The text to display in the avatar (typically initials).
  final String text;
}

/// Enum representing the size of an avatar.
enum AvatarSize {
  /// Small avatar (40px base size).
  small,

  /// Medium avatar (60px base size).
  medium,

  /// Large avatar (80px base size).
  large,
}

/// Enum representing the shape of an avatar.
enum AvatarShape {
  /// Circular avatar.
  circle,

  /// Square avatar.
  square,
}

/// Enum representing the border style of an avatar.
enum AvatarBorder {
  /// No border.
  none,

  /// Thin border (2px).
  thin,

  /// Thick border (4px).
  thick,
}

/// Enum representing the position of a badge on an avatar.
enum BadgePosition {
  /// Badge positioned at the top-left corner.
  topLeft,

  /// Badge positioned at the top-right corner.
  topRight,

  /// Badge positioned at the bottom-left corner.
  bottomLeft,

  /// Badge positioned at the bottom-right corner.
  bottomRight,
}

/// A small circular badge indicator, typically used to show status
/// on avatars.
class NextIndicatorBadge extends StatelessWidget {
  /// Creates a [NextIndicatorBadge] with the given [badgeColor].
  const NextIndicatorBadge({
    super.key,
    required this.badgeColor,
  });

  /// The color of the badge.
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: badgeColor, // Use the passed color for the badge
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

/// A customizable avatar widget that can display icons, images, or text.
///
/// This widget supports:
/// - Different sizes (small, medium, large)
/// - Different shapes (circle, square)
/// - Optional borders
/// - Optional status badges
///
/// **Example:**
/// ```dart
/// NextAvatar(
///   child: IconAvatar(Icons.person),
///   size: AvatarSize.large,
///   shape: AvatarShape.circle,
///   badgeColor: Colors.green,
///   badgePosition: BadgePosition.bottomRight,
/// )
/// ```
class NextAvatar extends StatelessWidget {
  /// Creates a [NextAvatar] widget.
  ///
  /// The [child] argument must not be null and should be an [IconAvatar],
  /// [ImageAvatar], or [TextAvatar].
  const NextAvatar({
    super.key,
    required this.child,
    this.size = AvatarSize.medium,
    this.shape = AvatarShape.circle,
    this.border = AvatarBorder.none,
    this.borderColor = Colors.black,
    this.badgeColor = Colors.green,
    this.badgePosition = BadgePosition.bottomRight,
  });

  final NextAvatarChild child;
  final AvatarSize size;
  final AvatarShape shape;
  final AvatarBorder border;
  final Color borderColor;
  final Color badgeColor; // Color for the badge
  final BadgePosition badgePosition; // Position of the badge

  @override
  Widget build(BuildContext context) {
    final double avatarSize = _getAvatarSize(size);
    final double scaledAvatarSize = _getScaledSize(context, avatarSize);

    // Build base avatar widget
    Widget avatar = (shape == AvatarShape.circle)
        ? CircleAvatar(
            radius: scaledAvatarSize / 2,
            backgroundImage: (child is ImageAvatar)
                ? NetworkImage((child as ImageAvatar).imageUrl)
                : null,
            child: (child is IconAvatar)
                ? Icon((child as IconAvatar).icon, size: scaledAvatarSize / 2)
                : (child is TextAvatar)
                    ? Text(
                        (child as TextAvatar).text,
                        style: TextStyle(fontSize: scaledAvatarSize / 3),
                      )
                    : null,
          )
        : Container(
            width: scaledAvatarSize,
            height: scaledAvatarSize,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              // No borderRadius needed here for square avatars
              image: (child is ImageAvatar)
                  ? DecorationImage(
                      image: NetworkImage((child as ImageAvatar).imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: (child is IconAvatar)
                ? Icon((child as IconAvatar).icon, size: scaledAvatarSize / 2)
                : (child is TextAvatar)
                    ? Center(
                        child: Text(
                          (child as TextAvatar).text,
                          style: TextStyle(fontSize: scaledAvatarSize / 3),
                        ),
                      )
                    : null,
          );

    // Apply border if selected
    if (border != AvatarBorder.none) {
      avatar = Container(
        width: scaledAvatarSize + 4,
        height: scaledAvatarSize + 4,
        decoration: BoxDecoration(
          borderRadius: (shape == AvatarShape.circle)
              ? null // No borderRadius for circle avatars
              : BorderRadius.circular(8), // Add borderRadius for square avatars
          border: Border.all(
            color: borderColor,
            width: (border == AvatarBorder.thin) ? 2 : 4,
          ),
        ),
        child: avatar,
      );
    }

    // Add badge if selected
    avatar = Stack(
      alignment: _getBadgePosition(badgePosition),
      children: [
        avatar,
        NextIndicatorBadge(
          badgeColor: badgeColor, // Pass the custom badge color
        ),
      ],
    );

    return avatar;
  }

  /// Gets the base avatar size for the given [AvatarSize].
  double _getAvatarSize(AvatarSize size) {
    switch (size) {
      case AvatarSize.small:
        return 40.0;
      case AvatarSize.medium:
        return 60.0;
      case AvatarSize.large:
        return 80.0;
    }
  }

  /// Gets the scaled avatar size based on screen width.
  ///
  /// The scaling is based on a reference width of 375px (iPhone width).
  double _getScaledSize(BuildContext context, double baseSize) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return baseSize * (screenWidth / 375.0);
  }

  /// Gets the [Alignment] for the given [BadgePosition].
  Alignment _getBadgePosition(BadgePosition position) {
    switch (position) {
      case BadgePosition.topLeft:
        return Alignment.topLeft;
      case BadgePosition.topRight:
        return Alignment.topRight;
      case BadgePosition.bottomLeft:
        return Alignment.bottomLeft;
      case BadgePosition.bottomRight:
        return Alignment.bottomRight;
    }
  }
}
