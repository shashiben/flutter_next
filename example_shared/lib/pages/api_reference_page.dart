import 'package:flutter/material.dart';

class ApiReferencePage extends StatelessWidget {
  const ApiReferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'API Reference',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),

          // Common Parameters
          Text(
            'Common Parameters',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildApiParam(
                    'duration',
                    'Duration',
                    'Duration of the animation',
                    'Duration(milliseconds: 800)',
                  ),
                  _buildApiParam(
                    'delay',
                    'Duration',
                    'Delay before animation starts',
                    'Duration.zero',
                  ),
                  _buildApiParam(
                    'controller',
                    'AnimationController?',
                    'Custom animation controller',
                    'null',
                  ),
                  _buildApiParam(
                    'autoStart',
                    'bool',
                    'Start automatically when built',
                    'true',
                  ),
                  _buildApiParam(
                    'curve',
                    'Curve',
                    'Animation curve',
                    'Curves.easeOut',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Animation Widgets
          Text(
            'Animation Widgets',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildWidgetCard(
            context,
            'NextBounceAnimation',
            'Bounce animation with fade-in effect',
          ),
          _buildWidgetCard(
            context,
            'NextFadeInAnimation',
            'Fade in animation with optional directional movement',
          ),
          _buildWidgetCard(
            context,
            'NextFadeOutAnimation',
            'Fade out animation with optional directional movement',
          ),
          _buildWidgetCard(
            context,
            'NextSlideAnimation',
            'Slide animation from any direction',
          ),
          _buildWidgetCard(
            context,
            'NextZoomAnimation',
            'Zoom in/out animation with scale and opacity',
          ),
          _buildWidgetCard(
            context,
            'NextFlipAnimation',
            '3D flip animation along X or Y axis',
          ),
          _buildWidgetCard(
            context,
            'NextColorTweenWidget',
            'Color transition between two colors',
          ),
        ],
      ),
    );
  }

  Widget _buildApiParam(
    String name,
    String type,
    String description,
    String defaultValue,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                type,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
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

  Widget _buildWidgetCard(
    BuildContext context,
    String name,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
