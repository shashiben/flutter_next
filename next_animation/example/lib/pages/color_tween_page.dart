import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';
import '../widgets/docs_layout.dart';
import '../widgets/code_block.dart';

class ColorTweenPage extends StatelessWidget {
  const ColorTweenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsLayout(
      selectedRoute: '/color-tween',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color Tween',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Smooth color transitions between two colors. Perfect for theme changes, mood indicators, and dynamic color effects.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            CodeBlock(
              code: '''NextColorTweenWidget(
  beginColor: Colors.blue,
  endColor: Colors.red,
  duration: Duration(milliseconds: 800),
  child: (controller, color) {
    return GestureDetector(
      onTap: () {
        if (controller.isCompleted) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
      child: Container(
        width: 100,
        height: 100,
        color: color,
      ),
    );
  },
)''',
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: NextColorTweenWidget(
                  beginColor: Colors.blue,
                  endColor: Colors.pink,
                  duration: const Duration(milliseconds: 2000),
                  child: (controller, color) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.isCompleted) {
                          controller.reverse();
                        } else {
                          controller.forward();
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(Icons.palette, size: 60, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

