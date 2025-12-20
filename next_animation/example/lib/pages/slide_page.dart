import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';
import '../widgets/docs_layout.dart';
import '../widgets/code_block.dart';

class SlidePage extends StatelessWidget {
  const SlidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsLayout(
      selectedRoute: '/slide',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slide Animations',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Slide elements into view from any direction. Perfect for creating smooth entrance animations.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            CodeBlock(
              code: '''NextSlideAnimation(
  variant: NextSlideVariant.slideInLeft,
  duration: Duration(milliseconds: 800),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.green,
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
                  children: NextSlideVariant.values.map((variant) {
                    return NextSlideAnimation(
                      variant: variant,
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.green,
                        child: const Icon(Icons.swipe, color: Colors.white),
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

