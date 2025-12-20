import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';
import '../widgets/docs_layout.dart';
import '../widgets/code_block.dart';

class ZoomPage extends StatefulWidget {
  const ZoomPage({super.key});

  @override
  State<ZoomPage> createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      NextZoomVariant.values.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      )..value = NextZoomVariant.values[index] == NextZoomVariant.zoomIn ? 0.0 : 1.0,
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DocsLayout(
      selectedRoute: '/zoom',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zoom Animations',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Scale elements in or out with smooth transitions. Great for highlighting content or creating focus effects.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            CodeBlock(
              code: '''NextZoomAnimation(
  variant: NextZoomVariant.zoomIn,
  duration: Duration(milliseconds: 800),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.purple,
  ),
)''',
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tap to animate',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: NextZoomVariant.values.asMap().entries.map((entry) {
                        final index = entry.key;
                        final variant = entry.value;
                        final controller = _controllers[index];
                        
                        return GestureDetector(
                          onTap: () {
                            if (controller.isCompleted) {
                              controller.reverse();
                            } else {
                              controller.forward();
                            }
                          },
                          child: NextZoomAnimation(
                            controller: controller,
                            autoStart: false,
                            variant: variant,
                            duration: const Duration(milliseconds: 800),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    variant == NextZoomVariant.zoomIn
                                        ? Icons.zoom_in
                                        : Icons.zoom_out,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    variant.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
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
                    leading: const Icon(Icons.zoom_in),
                    title: const Text('zoomIn'),
                    subtitle: const Text('Scales from 0 to 1 with fade in'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.zoom_out),
                    title: const Text('zoomOut'),
                    subtitle: const Text('Scales from 1 to 0 with fade out'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Advanced Example
            Text(
              'Advanced Example',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            CodeBlock(
              code: '''final controller = AnimationController(
  duration: Duration(milliseconds: 800),
  vsync: this,
);

NextZoomAnimation(
  controller: controller,
  autoStart: false,
  variant: NextZoomVariant.zoomIn,
  curve: Curves.easeOut,
  child: YourWidget(),
)

// Trigger animation
controller.forward();''',
            ),
          ],
        ),
      ),
    );
  }
}

