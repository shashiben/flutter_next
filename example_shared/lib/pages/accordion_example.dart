import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class AccordionExamplePage extends StatelessWidget {
  const AccordionExamplePage({super.key});

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
        title: const Text('NextAccordion Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'Basic Accordion'),
            _buildExplanation(
              context,
              'A simple accordion with a title and expandable content.',
            ),
            const NextAccordion(
              title: Text('What is Flutter Next?'),
              children: <Widget>[
                ListTile(
                  title: Text('Flutter Next'),
                  subtitle: Text(
                    'Flutter Next is a package for faster UI development '
                    'and provides responsiveness for Flutter web applications.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const NextAccordion(
              title: Text('How to use NextAccordion?'),
              children: <Widget>[
                ListTile(
                  title: Text('Usage'),
                  subtitle: Text(
                    'Simply wrap your content in a NextAccordion widget '
                    'and provide a title and children widgets.',
                  ),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Accordion with Icons'),
            _buildExplanation(
              context,
              'Accordions can include leading icons for better visual '
              'hierarchy.',
            ),
            const NextAccordion(
              leading: Icon(Icons.info_outline),
              title: Text('Information'),
              children: <Widget>[
                ListTile(
                  title: Text('Details'),
                  subtitle: Text('This accordion has a leading icon.'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const NextAccordion(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              children: <Widget>[
                ListTile(
                  title: Text('Configuration'),
                  subtitle: Text('Customize your preferences here.'),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Initially Expanded'),
            _buildExplanation(
              context,
              'Accordions can be set to be expanded by default using '
              'the `initiallyExpanded` property.',
            ),
            const NextAccordion(
              title: Text('This accordion starts expanded'),
              initiallyExpanded: true,
              children: <Widget>[
                ListTile(
                  title: Text('Expanded Content'),
                  subtitle: Text(
                    'This accordion was expanded when the page loaded.',
                  ),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Accordion with Subtitle'),
            _buildExplanation(
              context,
              'Add a subtitle to provide additional context.',
            ),
            const NextAccordion(
              title: Text('Advanced Features'),
              subtitle: Text('Click to learn more'),
              children: <Widget>[
                ListTile(
                  title: Text('Feature List'),
                  subtitle: Text(
                    'Here are some advanced features you can use with '
                    'NextAccordion.',
                  ),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Custom Colors'),
            _buildExplanation(
              context,
              'Customize the colors of the accordion using various color '
              'properties.',
            ),
            NextAccordion(
              title: const Text('Custom Styled Accordion'),
              backgroundColor: Colors.blue.shade50,
              collapsedBackgroundColor: Colors.grey.shade100,
              textColor: Colors.blue.shade900,
              collapsedTextColor: Colors.grey.shade800,
              iconColor: Colors.blue,
              collapsedIconColor: Colors.grey,
              borderColor: Colors.blue.shade200,
              children: const <Widget>[
                ListTile(
                  title: Text('Styled Content'),
                  subtitle: Text(
                    'This accordion uses custom colors for background, '
                    'text, and icons.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
