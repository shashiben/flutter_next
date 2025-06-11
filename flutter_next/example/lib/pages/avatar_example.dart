import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';
import 'package:flutter_next/views/next_avatar.dart';

class NextAvatarShowcasePage extends StatelessWidget {
  const NextAvatarShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NextAvatar Showcase'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Heading
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'NextAvatar Component Showcase',
                style: context.textTheme.labelLarge,
              ),
            ),

            // Avatar Variants List
            _buildAvatarCard(
              title: 'Small Avatar with Icon and No Border',
              description:
                  'A small avatar displaying an icon with no border and a top-right badge.',
              avatar: NextAvatar(
                child: IconAvatar(Icons.person),
                size: AvatarSize.small,
                border: AvatarBorder.none,
                badgeColor: Colors.blue,
                badgePosition: BadgePosition.topRight,
              ),
            ),
            _buildAvatarCard(
              title: 'Medium Avatar with Image and Thin Border',
              description:
                  'A medium-sized avatar with an image and a thin border, bottom-left badge.',
              avatar: NextAvatar(
                child: ImageAvatar('https://picsum.photos/200/300'),
                size: AvatarSize.medium,
                border: AvatarBorder.thin,
                badgeColor: Colors.green,
                badgePosition: BadgePosition.bottomLeft,
              ),
            ),
            _buildAvatarCard(
              title: 'Large Avatar with Text and Thick Border',
              description:
                  'A large avatar with text initials and a thick border, top-left badge.',
              avatar: NextAvatar(
                child: TextAvatar('JD'),
                size: AvatarSize.large,
                border: AvatarBorder.thick,
                badgeColor: Colors.orange,
                badgePosition: BadgePosition.topLeft,
              ),
            ),
            _buildAvatarCard(
              title: 'Square Avatar with Custom Badge Color',
              description:
                  'A square avatar with a custom badge color at the bottom-right.',
              avatar: NextAvatar(
                child: IconAvatar(Icons.star),
                size: AvatarSize.medium,
                shape: AvatarShape.square,
                border: AvatarBorder.thin,
                badgeColor: Colors.red,
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
            _buildAvatarCard(
              title: 'Avatar with No Badge',
              description: 'A large avatar with an image and no badge.',
              avatar: NextAvatar(
                child: ImageAvatar('https://picsum.photos/200/300'),
                size: AvatarSize.large,
                border: AvatarBorder.none,
                badgeColor: Colors.transparent,
                badgePosition: BadgePosition.bottomRight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarCard({
    required String title,
    required String description,
    required Widget avatar,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Section Title
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Description
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),

              // Avatar Display
              Center(child: avatar),
            ],
          ),
        ),
      ),
    );
  }
}
