import 'package:flutter/material.dart';

// Step 1: Abstract class for NextAvatarChild
abstract class NextAvatarChild {}

class IconAvatar implements NextAvatarChild {
  IconAvatar(this.icon);
  final IconData icon;
}

class ImageAvatar implements NextAvatarChild {
  ImageAvatar(this.imageUrl);
  final String imageUrl;
}

class TextAvatar implements NextAvatarChild {
  TextAvatar(this.text);
  final String text;
}

// Step 2: Enum for Avatar Size, Shape, Border, and Badge Position
enum AvatarSize { small, medium, large }

enum AvatarShape { circle, square }

enum AvatarBorder { none, thin, thick }

enum BadgePosition { topLeft, topRight, bottomLeft, bottomRight }

// Step 3: NextIndicatorBadge for the badge
class NextIndicatorBadge extends StatelessWidget {
  const NextIndicatorBadge({
    super.key,
    required this.badgeColor, // Custom color for the badge
  });
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

// Step 4: NextAvatar widget with customizable badge
class NextAvatar extends StatelessWidget {
  const NextAvatar({
    super.key,
    required this.child,
    this.size = AvatarSize.medium,
    this.shape = AvatarShape.circle,
    this.border = AvatarBorder.none,
    this.borderColor = Colors.black,
    this.badgeColor = Colors.green, // Customizable badge color
    this.badgePosition =
        BadgePosition.bottomRight, // Customizable badge position
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
    final double screenWidth = MediaQuery.of(context).size.width;

    double avatarSize;
    switch (size) {
      case AvatarSize.small:
        avatarSize = 40.0;
      case AvatarSize.medium:
        avatarSize = 60.0;
      case AvatarSize.large:
        avatarSize = 80.0;
    }

    final double scaledAvatarSize = avatarSize * (screenWidth / 375.0);

    // Step 5: Base CircleAvatar or SquareAvatar depending on shape
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

    // Step 6: Apply border if selected
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

    // Step 7: Add custom badge if selected
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

  // Helper function to determine badge position
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
