import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';
import '../widgets/docs_layout.dart';
import '../widgets/code_block.dart';

class BouncePage extends StatelessWidget {
  const BouncePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsLayout(
      selectedRoute: '/bounce',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bounce Animations',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Create elastic bounce effects from any direction. Bounce animations combine position movement with opacity fade-in for a polished, professional look.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            // Live Example
            Text(
              'Live Example',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: NextBounceVariant.values.map((variant) {
                    return NextBounceAnimation(
                      variant: variant,
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Basic Usage
            Text(
              'Basic Usage',
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
    color: Colors.orange,
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
            ...NextBounceVariant.values.map((variant) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.arrow_forward),
                    title: Text(variant.name),
                    subtitle: Text(_getVariantDescription(variant)),
                  ),
                )),
            const SizedBox(height: 48),

            // Parameters
            Text(
              'Parameters',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildParameterTable(context),
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
  duration: Duration(milliseconds: 1000),
  vsync: this,
);

NextBounceAnimation(
  controller: controller,
  autoStart: false,
  variant: NextBounceVariant.bounceInTop,
  initialPosition: 100,
  curve: Curves.bounceOut,
  child: YourWidget(),
)

// Trigger animation manually
controller.forward();''',
            ),
          ],
        ),
      ),
    );
  }

  String _getVariantDescription(NextBounceVariant variant) {
    switch (variant) {
      case NextBounceVariant.bounceInTop:
        return 'Bounce in from the top';
      case NextBounceVariant.bounceInBottom:
        return 'Bounce in from the bottom';
      case NextBounceVariant.bounceInLeft:
        return 'Bounce in from the left';
      case NextBounceVariant.bounceInRight:
        return 'Bounce in from the right';
    }
  }

  Widget _buildParameterTable(BuildContext context) {
    return Card(
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(2),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text('Parameter', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text('Default', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          _buildTableRow('variant', 'Direction of bounce animation', 'bounceInLeft'),
          _buildTableRow('duration', 'Animation duration', '1000ms'),
          _buildTableRow('delay', 'Delay before animation starts', '0ms'),
          _buildTableRow('initialPosition', 'Initial offset distance', '75px'),
          _buildTableRow('curve', 'Animation curve', 'Curves.bounceOut'),
          _buildTableRow('autoStart', 'Start automatically', 'true'),
          _buildTableRow('controller', 'Custom animation controller', 'null'),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String param, String desc, String defaultValue) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(param, style: const TextStyle(fontFamily: 'monospace')),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(desc),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(defaultValue, style: const TextStyle(fontFamily: 'monospace')),
        ),
      ],
    );
  }
}

