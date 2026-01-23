import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/code_block.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            'Add animation_next to your pubspec.yaml file:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          const CodeBlock(
            code: '''
dependencies:
  animation_next: ^0.1.0''',
          ),
          const SizedBox(height: 16),
          Text(
            'Then run:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          const CodeBlock(
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
          const CodeBlock(
            code: "import 'package:animation_next/animation_next.dart';",
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
          const CodeBlock(
            code: '''
NextBounceAnimation(
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
          Text(
            'Try all animation types in our interactive playground!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.play_circle),
              title: const Text('Animation Playground'),
              subtitle: const Text(
                  'Interactive playground to test all animation types, variants, and settings'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.go('/playground'),
            ),
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
                  _buildParamItem('duration', 'Duration of the animation',
                      'Duration(milliseconds: 800)'),
                  _buildParamItem('delay', 'Delay before animation starts',
                      'Duration.zero'),
                  _buildParamItem(
                      'controller', 'Custom animation controller', 'null'),
                  _buildParamItem(
                      'autoStart', 'Start automatically when built', 'true'),
                  _buildParamItem('curve', 'Animation curve', 'Curves.easeOut'),
                ],
              ),
            ),
          ),
        ],
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
