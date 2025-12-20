import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';
import '../widgets/docs_layout.dart';
import '../widgets/code_block.dart';

class FlipPage extends StatelessWidget {
  const FlipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsLayout(
      selectedRoute: '/flip',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flip Animations',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              '3D flip effects along X or Y axis. Perfect for card games, reveal animations, and interactive elements.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            CodeBlock(
              code: '''NextFlipAnimation(
  variant: NextFlipVariant.flipX,
  duration: Duration(milliseconds: 800),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.teal,
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
                  children: NextFlipVariant.values.map((variant) {
                    return NextFlipAnimation(
                      variant: variant,
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.teal,
                        child: const Icon(Icons.flip, color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

