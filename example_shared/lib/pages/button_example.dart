import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class ButtonExamplePage extends StatelessWidget {
  const ButtonExamplePage({super.key});

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildExplanation(BuildContext context, String explanation) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Text(
        explanation,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade700,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NextButton Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'Filled Buttons'),
            _buildExplanation(
              context,
              'Filled buttons with different colors and styles.',
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                NextButton(
                  child: const Text('Primary Button'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Primary button pressed')),
                    );
                  },
                ),
                NextButton(
                  color: Colors.green,
                  child: const Text('Success Button'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Success button pressed')),
                    );
                  },
                ),
                NextButton(
                  color: Colors.red,
                  child: const Text('Danger Button'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Danger button pressed')),
                    );
                  },
                ),
              ],
            ),
            _buildSectionTitle(context, 'Outlined Buttons'),
            _buildExplanation(
              context,
              'Outlined buttons with hover effects.',
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                NextButton(
                  variant: NextButtonVariant.outlined,
                  outlineColor: Theme.of(context).primaryColor,
                  child: const Text('Outlined Primary'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Outlined button pressed')),
                    );
                  },
                ),
                NextButton(
                  variant: NextButtonVariant.outlined,
                  outlineColor: Colors.green,
                  child: const Text('Outlined Success'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Outlined success pressed')),
                    );
                  },
                ),
                NextButton(
                  variant: NextButtonVariant.outlined,
                  outlineColor: Colors.red,
                  child: const Text('Outlined Danger'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Outlined danger pressed')),
                    );
                  },
                ),
              ],
            ),
            _buildSectionTitle(context, 'Buttons with Icons'),
            _buildExplanation(
              context,
              'Buttons can include leading and trailing icons.',
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                NextButton(
                  leading: const Icon(Icons.download, size: 18),
                  child: const Text('Download'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Download clicked')),
                    );
                  },
                ),
                NextButton(
                  trailing: const Icon(Icons.arrow_forward, size: 18),
                  child: const Text('Continue'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Continue clicked')),
                    );
                  },
                ),
                NextButton(
                  leading: const Icon(Icons.save, size: 18),
                  trailing: const Icon(Icons.check, size: 18),
                  child: const Text('Save & Continue'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Save & Continue clicked')),
                    );
                  },
                ),
              ],
            ),
            _buildSectionTitle(context, 'Disabled Buttons'),
            _buildExplanation(
              context,
              'Buttons can be disabled by setting `enabled: false`.',
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                const NextButton(
                  enabled: false,
                  child: Text('Disabled Filled'),
                ),
                NextButton(
                  variant: NextButtonVariant.outlined,
                  enabled: false,
                  outlineColor: Theme.of(context).primaryColor,
                  child: const Text('Disabled Outlined'),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Custom Styled Buttons'),
            _buildExplanation(
              context,
              'Buttons can be customized with custom padding, margin, '
              'border radius, and elevation.',
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                NextButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  child: const Text('Large Padding'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Large button pressed')),
                    );
                  },
                ),
                NextButton(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 4.0,
                  hoverElevation: 8.0,
                  child: const Text('Rounded with Shadow'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rounded button pressed')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
