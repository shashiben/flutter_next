import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class AccordionExamplePage extends StatefulWidget {
  const AccordionExamplePage({super.key});

  @override
  State<AccordionExamplePage> createState() => _AccordionExamplePageState();
}

class _AccordionExamplePageState extends State<AccordionExamplePage> {
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
            _buildExplanation(context,
              'Demonstrates a single NextAccordionItem that can be expanded and collapsed. Click the header to toggle visibility of the content.'),
            NextAccordion(
              items: [
                NextAccordionItem(
                  title: const Text('Basic Accordion Item 1'),
                  content: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('This is the content for the first basic accordion item. It can be any widget you like. ' * 3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Multiple Accordion Items'),
            _buildExplanation(context,
              'Shows multiple accordion items within a single NextAccordion widget. '
              'By default, multiple items can be expanded simultaneously. Set `allowMultipleExpansion: false` to only allow one item to be open at a time (not shown here).'),
            NextAccordion(
              items: [
                NextAccordionItem(
                  title: const Text('Item A - Click Me'),
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Content for Item A. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  ),
                ),
                NextAccordionItem(
                  title: const Text('Item B - Also Clickable'),
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Content for Item B can be more complex:'),
                        SizedBox(height: 8),
                        FlutterLogo(size: 40),
                        SizedBox(height: 8),
                        Text('End of Item B content.'),
                      ],
                    ),
                  ),
                ),
                NextAccordionItem(
                  title: const Text('Item C - Expand to see more'),
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Final item\'s content. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Accordion with Custom Styling & Icons'),
            _buildExplanation(context,
              'Illustrates customizing the appearance of accordion items. You can change header background color, icon colors, and even provide completely custom expand/collapse icons.'),
            NextAccordion(
              items: [
                NextAccordionItem(
                  title: const Text('Custom Header Background', style: TextStyle(color: Colors.white)),
                  headerBackgroundColor: Colors.deepPurple,
                  iconColor: Colors.white,
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This item has a deep purple header background and white text/icon.'),
                  ),
                ),
                NextAccordionItem(
                  title: const Text('Custom Icons (Rotated Arrow)'),
                  customIconOpen: const Icon(Icons.keyboard_arrow_down, color: Colors.teal),
                  customIconClose: const Icon(Icons.keyboard_arrow_right, color: Colors.teal),
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This item uses custom arrow icons for open and close states, colored teal.'),
                  ),
                ),
                 NextAccordionItem(
                  title: const Text('Custom Icons (Plus/Minus)'),
                  customIconOpen: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                  customIconClose: const Icon(Icons.add_circle_outline, color: Colors.green),
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This item uses plus/minus icons with different colors for open (minus) and close (plus) states.'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Initially Expanded Item'),
            _buildExplanation(context,
              'Shows how to make an accordion item initially expanded when the widget is first built using the `isInitiallyExpanded: true` property on a NextAccordionItem.'),
            NextAccordion(
              items: [
                NextAccordionItem(
                  title: const Text('Item 1 - Starts Collapsed'),
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This item is collapsed by default.'),
                  ),
                ),
                NextAccordionItem(
                  title: const Text('Item 2 - Starts Expanded!'),
                  isInitiallyExpanded: true,
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This item was set to be initially expanded. You can still collapse and expand it normally.'),
                  ),
                ),
                NextAccordionItem(
                  title: const Text('Item 3 - Also Collapsed'),
                  content: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This item is also collapsed by default.'),
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
