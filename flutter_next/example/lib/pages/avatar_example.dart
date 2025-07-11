import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class AvatarExamplePage extends StatelessWidget {
  const AvatarExamplePage({super.key});

  Widget _buildSectionTitle(BuildContext context, String title, {bool main = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: main ? 16.0 : 12.0),
      child: Text(title, style: main ? Theme.of(context).textTheme.headlineSmall : Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildExplanation(BuildContext context, String explanation) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Text(
        explanation,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey.shade700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String sampleImageUrl = 'https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp';

    return Scaffold(
      appBar: AppBar(
        title: const Text('NextAvatar & Group Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'NextAvatar Examples', main: true),

            _buildSectionTitle(context, 'Basic Image Avatars'),
            _buildExplanation(context,
              'Displays a NextAvatar with a network image. The `radius` property controls the size.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NextAvatar(
                  radius: 25,
                  backgroundImage: const NetworkImage(sampleImageUrl),
                ),
                NextAvatar(
                  radius: 35,
                  backgroundImage: const NetworkImage(sampleImageUrl),
                ),
                NextAvatar(
                  radius: 45,
                  backgroundImage: const NetworkImage(sampleImageUrl),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildExplanation(context, 'The above avatars use radii of 25, 35, and 45 respectively.'),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Avatar with Placeholder/Initials'),
            _buildExplanation(context,
              'When `backgroundImage` is not provided or fails to load, the `child` widget is displayed. This is typically used for initials or a placeholder icon.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NextAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey,
                  child: const Text('JD', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                NextAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal,
                  child: const Icon(Icons.person, color: Colors.white, size: 30),
                ),
                 NextAvatar( // Example of image failing (using a bad URL)
                  radius: 30,
                  backgroundImage: const NetworkImage('https://invalid-url-for-testing.com/image.png'),
                  backgroundColor: Colors.red.shade100,
                  child: const Icon(Icons.error_outline, color: Colors.red, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Avatar with Border & Custom Styling'),
            _buildExplanation(context,
              'Avatars can have borders and custom background colors (especially visible when no image is used).'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NextAvatar(
                  radius: 30,
                  backgroundImage: const NetworkImage(sampleImageUrl),
                  borderColor: Colors.green,
                  borderWidth: 3.0,
                ),
                NextAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple.shade100,
                  borderColor: Colors.purple,
                  borderWidth: 2.0,
                  child: const Text('S', style: TextStyle(color: Colors.purple, fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                NextAvatar(
                  radius: 30,
                  backgroundImage: const NetworkImage(sampleImageUrl),
                  shape: NextAvatarShape.square, // Different shape
                  borderColor: Colors.orange,
                  borderWidth: 2.5,
                ),
              ],
            ),
            const SizedBox(height: 30),

            _buildSectionTitle(context, 'NextAvatarGroup Examples', main: true),

            _buildSectionTitle(context, 'Basic Avatar Group'),
            _buildExplanation(context,
              'Shows a basic group of overlapping avatars. Avatars are provided via the `avatarImages` list (ImageProviders) or `children` (List<NextAvatar>).'),
            NextAvatarGroup(
              avatarImages: List.generate(4, (index) => const NetworkImage(sampleImageUrl)),
              radius: 25,
            ),
            const SizedBox(height: 20),
             _buildExplanation(context, 'Using `children` property with `NextAvatar` widgets directly:'),
             NextAvatarGroup(
              radius: 25,
              children: [
                NextAvatar(radius: 25, backgroundImage: const NetworkImage(sampleImageUrl)),
                NextAvatar(radius: 25, backgroundColor: Colors.blue, child: const Text('A', style: TextStyle(color: Colors.white))),
                NextAvatar(radius: 25, backgroundImage: const NetworkImage(sampleImageUrl)),
              ],
            ),
            const SizedBox(height: 20),


            _buildSectionTitle(context, 'Group with Display Limit & Excess Count'),
            _buildExplanation(context,
              'Limits the number of displayed avatars using `displayLimit` and shows an excess count for the hidden ones. `maxAvatarsToDisplay` is an alias for `displayLimit`.'),
            NextAvatarGroup(
              avatarImages: List.generate(8, (index) => NetworkImage('$sampleImageUrl?v=$index')), // Unique URLs
              radius: 25,
              displayLimit: 4, // or maxAvatarsToDisplay
              avatarBackgroundColor: Colors.grey.shade300, // For the excess count
              excessCountTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Custom Excess Count Builder'),
            _buildExplanation(context,
              'Allows complete customization of the excess count indicator using the `excessCountBuilder` function.'),
            NextAvatarGroup(
              avatarImages: List.generate(7, (index) => NetworkImage('$sampleImageUrl?id=$index')),
              radius: 28,
              displayLimit: 3,
              excessCountBuilder: (context, excessCount) {
                return Container(
                  width: 2 * 28.0, // Match avatar diameter
                  height: 2 * 28.0,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '+$excessCount',
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Custom Avatar Builder within Group'),
            _buildExplanation(context,
              'The `avatarBuilder` allows customization of each avatar within the group, e.g., to add status indicators or different shapes. This takes precedence over `avatarImages`.'),
            NextAvatarGroup(
              // avatarImages list is still needed to determine the count if using avatarBuilder for N items
              avatarImages: List.generate(5, (index) => const NetworkImage(sampleImageUrl)), // Length determines items
              radius: 30,
              displayLimit: 5, // Show all for this example
              avatarBuilder: (context, index) {
                // Example: Add a green dot for online status on some avatars
                bool isOnline = index % 2 == 0;
                return Stack(
                  children: [
                    NextAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('$sampleImageUrl?item=$index'),
                      borderColor: Colors.white, // Border for stacking effect
                      borderWidth: 1.5,
                    ),
                    if (isOnline)
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
             _buildSectionTitle(context, 'Adjusting Overlap with `widthReductionFactor`'),
            _buildExplanation(context,
              '`widthReductionFactor` controls how much each subsequent avatar overlaps the previous one. Default is 0.4 (40% of radius). Smaller value = more overlap.'),
            Row(
              children: [
                Expanded(child: Column(children: [
                  const Text('Factor: 0.2 (More overlap)'),
                  const SizedBox(height: 4),
                  NextAvatarGroup(
                    avatarImages: List.generate(4, (index) => NetworkImage('$sampleImageUrl?r=0.2&i=$index')),
                    radius: 20,
                    widthReductionFactor: 0.2,
                  )
                ])),
                const SizedBox(width: 10),
                Expanded(child: Column(children: [
                  const Text('Factor: 0.6 (Less overlap)'),
                  const SizedBox(height: 4),
                  NextAvatarGroup(
                    avatarImages: List.generate(4, (index) => NetworkImage('$sampleImageUrl?r=0.6&i=$index')),
                    radius: 20,
                    widthReductionFactor: 0.6,
                  )
                ])),
              ],
            )
          ],
        ),
      ),
    );
  }
}
