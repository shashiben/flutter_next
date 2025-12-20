import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';
import '../widgets/docs_layout.dart';
import '../widgets/code_block.dart';

class FadePage extends StatelessWidget {
  const FadePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsLayout(
      selectedRoute: '/fade',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fade Animations',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Smooth fade in/out animations with optional directional movement. Perfect for showing and hiding content with elegant transitions.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            // Fade In Example
            Text(
              'Fade In',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            CodeBlock(
              code: '''NextFadeInAnimation(
  variant: NextFadeInVariant.fadeInLeft,
  duration: Duration(milliseconds: 800),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.blue,
  ),
)''',
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: NextFadeInVariant.values.map((variant) {
                    return NextFadeInAnimation(
                      variant: variant,
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.blue,
                        child: const Icon(Icons.star, color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Fade Out Example
            Text(
              'Fade Out',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            CodeBlock(
              code: '''NextFadeOutAnimation(
  variant: NextFadeOutVariant.fadeOutRight,
  duration: Duration(milliseconds: 800),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.red,
  ),
)''',
            ),
            const SizedBox(height: 48),

            // Variants
            Text(
              'Variants',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Fade In Variants'),
                    subtitle: const Text('fadeInLeft, fadeInRight, fadeInTop, fadeInBottom'),
                  ),
                  ListTile(
                    title: const Text('Fade Out Variants'),
                    subtitle: const Text('fadeOutLeft, fadeOutRight, fadeOutTop, fadeOutBottom'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

