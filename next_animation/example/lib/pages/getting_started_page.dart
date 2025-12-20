import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/docs_layout.dart';
import '../widgets/code_block.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsLayout(
      selectedRoute: '/getting-started',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Getting Started',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // Installation
            Text(
              '📦 Installation',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Add next_animation to your pubspec.yaml file:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            CodeBlock(
              code: '''dependencies:
  next_animation: ^0.1.0''',
            ),
            const SizedBox(height: 16),
            Text(
              'Then run:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            CodeBlock(
              code: 'flutter pub get',
            ),
            const SizedBox(height: 48),

            // Import
            Text(
              '📥 Import',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            CodeBlock(
              code: "import 'package:next_animation/next_animation.dart';",
            ),
            const SizedBox(height: 48),

            // Quick Example
            Text(
              '⚡ Quick Example',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            CodeBlock(
              code: '''NextBounceAnimation(
  variant: NextBounceVariant.bounceInLeft,
  duration: Duration(milliseconds: 1000),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.blue,
  ),
)''',
            ),
            const SizedBox(height: 48),

            // Animation Types
            Text(
              '🎬 Animation Types',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildAnimationTypeCard(
              context,
              'Bounce',
              'Elastic bounce effects from any direction',
              '/bounce',
            ),
            _buildAnimationTypeCard(
              context,
              'Fade',
              'Smooth fade in/out with directional movement',
              '/fade',
            ),
            _buildAnimationTypeCard(
              context,
              'Slide',
              'Slide elements into view from any direction',
              '/slide',
            ),
            _buildAnimationTypeCard(
              context,
              'Zoom',
              'Scale elements in or out smoothly',
              '/zoom',
            ),
            _buildAnimationTypeCard(
              context,
              'Flip',
              '3D flip effects along X or Y axis',
              '/flip',
            ),
            _buildAnimationTypeCard(
              context,
              'Color Tween',
              'Smooth color transitions between colors',
              '/color-tween',
            ),
            const SizedBox(height: 48),

            // Common Parameters
            Text(
              '⚙️ Common Parameters',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildParamItem('duration', 'Duration of the animation', 'Duration(milliseconds: 800)'),
                    _buildParamItem('delay', 'Delay before animation starts', 'Duration.zero'),
                    _buildParamItem('controller', 'Custom animation controller', 'null'),
                    _buildParamItem('autoStart', 'Start automatically when built', 'true'),
                    _buildParamItem('curve', 'Animation curve', 'Curves.easeOut'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationTypeCard(
    BuildContext context,
    String title,
    String description,
    String route,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }

  Widget _buildParamItem(String name, String description, String defaultValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(description),
          const SizedBox(height: 4),
          Text(
            'Default: $defaultValue',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

