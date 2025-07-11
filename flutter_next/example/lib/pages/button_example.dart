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
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey.shade700),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
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
            _buildSectionTitle(context, 'Button Variants (Solid)'),
            _buildExplanation(context,
              'Showcases various button styles based on predefined variants (primary, secondary, success, etc.) using the `variant` property.'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: NextButtonVariant.values.map((variant) {
                return NextButton(
                  variant: variant,
                  onPressed: () => _showSnackbar(context, '${variant.name.capitalize()} Button Clicked'),
                  child: Text(variant.name.capitalize()),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Outline Buttons'),
            _buildExplanation(context,
              'Demonstrates outline button styles using `isOutlined: true` combined with different variants.'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: NextButtonVariant.values.map((variant) {
                return NextButton(
                  variant: variant,
                  isOutlined: true,
                  onPressed: () => _showSnackbar(context, 'Outline ${variant.name.capitalize()} Clicked'),
                  child: Text('Outline ${variant.name.capitalize()}'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Buttons with Icons'),
            _buildExplanation(context,
              'Illustrates adding icons to buttons, either before (leading) or after (trailing) the text, or icon-only buttons.'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.start,
              children: [
                NextButton(
                  variant: NextButtonVariant.primary,
                  leadingIcon: const Icon(Icons.send),
                  onPressed: () => _showSnackbar(context, 'Send Button Clicked'),
                  child: const Text('Send'),
                ),
                NextButton(
                  variant: NextButtonVariant.success,
                  trailingIcon: const Icon(Icons.check_circle_outline),
                   onPressed: () => _showSnackbar(context, 'Confirm Button Clicked'),
                  child: const Text('Confirm'),
                ),
                NextButton(
                  variant: NextButtonVariant.info,
                  isOutlined: true,
                  leadingIcon: const Icon(Icons.info_outline),
                  onPressed: () => _showSnackbar(context, 'Info Button Clicked'),
                  child: const Text('More Info'),
                ),
                 NextButton.icon(
                  variant: NextButtonVariant.danger,
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () => _showSnackbar(context, 'Delete Icon Button Clicked'),
                ),
                NextButton.icon(
                  variant: NextButtonVariant.secondary,
                  isOutlined: true,
                  icon: const Icon(Icons.settings),
                  onPressed: () => _showSnackbar(context, 'Settings Icon Button Clicked'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Button Sizes'),
            _buildExplanation(context,
              'Shows buttons of different sizes (small, medium (default), large) using the `buttonSize` property.'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                NextButton(
                  variant: NextButtonVariant.primary,
                  buttonSize: NextButtonSize.small,
                  onPressed: () => _showSnackbar(context, 'Small Button Clicked'),
                  child: const Text('Small Button'),
                ),
                NextButton(
                  variant: NextButtonVariant.secondary,
                  // buttonSize: NextButtonSize.medium, (default)
                  onPressed: () => _showSnackbar(context, 'Medium Button Clicked'),
                  child: const Text('Medium (Default)'),
                ),
                NextButton(
                  variant: NextButtonVariant.success,
                  buttonSize: NextButtonSize.large,
                  onPressed: () => _showSnackbar(context, 'Large Button Clicked'),
                  child: const Text('Large Button'),
                ),
                 NextButton.icon(
                  variant: NextButtonVariant.warning,
                  buttonSize: NextButtonSize.small,
                  icon: const Icon(Icons.warning_amber),
                  onPressed: () => _showSnackbar(context, 'Small Icon Button Clicked'),
                ),
                NextButton.icon(
                  variant: NextButtonVariant.info,
                  buttonSize: NextButtonSize.large,
                  icon: const Icon(Icons.info),
                  onPressed: () => _showSnackbar(context, 'Large Icon Button Clicked'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Full Width Button (Expanded)'),
            _buildExplanation(context,
              'A button can take the full available width by setting `expanded: true`. This is useful for forms or call-to-action buttons at the bottom of a section.'),
            NextButton(
              variant: NextButtonVariant.primary,
              expanded: true,
              onPressed: () => _showSnackbar(context, 'Full Width Button Clicked'),
              child: const Text('Submit Form (Full Width)'),
            ),
            const SizedBox(height: 8),
             NextButton(
              variant: NextButtonVariant.dark,
              isOutlined: true,
              expanded: true,
              leadingIcon: const Icon(Icons.add_shopping_cart),
              onPressed: () => _showSnackbar(context, 'Add to Cart Full Width Clicked'),
              child: const Text('Add to Cart (Full Width Outline)'),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Disabled Buttons'),
            _buildExplanation(context,
              'Demonstrates disabled buttons that are not interactive. This is achieved by setting `onPressed: null`.'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                const NextButton(
                  variant: NextButtonVariant.primary,
                  onPressed: null, // Disabled
                  child: Text('Disabled Primary'),
                ),
                const NextButton(
                  variant: NextButtonVariant.secondary,
                  isOutlined: true,
                  onPressed: null, // Disabled
                  child: Text('Disabled Outline'),
                ),
                NextButton.icon(
                  variant: NextButtonVariant.success,
                  icon: const Icon(Icons.check),
                  onPressed: null, // Disabled
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
}
