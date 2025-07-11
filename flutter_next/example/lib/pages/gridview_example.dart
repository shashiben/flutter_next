import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';
import 'dart:math';

class GridViewExamplePage extends StatelessWidget {
  const GridViewExamplePage({super.key});

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

  Widget _exampleGridItem(int index, {Color? color}) {
    final itemColor = color ?? Colors.primaries[Random().nextInt(Colors.primaries.length)].shade200;
    return Container(
      color: itemColor,
      child: Center(
        child: Text(
          'Item $index',
          style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NextGridView Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'Basic Responsive GridView'),
            _buildExplanation(context,
              'A responsive grid view where the number of items per row adapts to screen breakpoints. '
              'The `widthPercentages` map defines the percentage of width each item takes at different `GridPrefix` breakpoints (xs, sm, md, lg, xl, xxl). '
              'Items will wrap automatically. `mainAxisExtent` defines the height of each item.'),
            NextGridView(
              mainAxisExtent: 100, // Height of items
              widthPercentages: const {
                GridPrefix.xs: 100, // 1 item per row on extra-small
                GridPrefix.sm: 50,  // 2 items per row on small
                GridPrefix.md: 33.33, // 3 items per row on medium
                GridPrefix.lg: 25,  // 4 items per row on large
                GridPrefix.xl: 20,  // 5 items per row on extra-large
              },
              children: List.generate(10, (index) => _exampleGridItem(index + 1)),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'GridView with Custom Spacing'),
            _buildExplanation(context,
              'Illustrates customizing the horizontal (`crossAxisSpacing`) and vertical (`mainAxisSpacing`) spacing between grid items.'),
            NextGridView(
              mainAxisExtent: 80,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              widthPercentages: const {
                GridPrefix.xs: 100,
                GridPrefix.sm: 50,
                GridPrefix.md: 25,
              },
              children: List.generate(8, (index) => _exampleGridItem(index + 1, color: Colors.teal.shade100)),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'GridView with Fixed Item Count per Row (Non-Responsive)'),
            _buildExplanation(context,
              'If you only provide a width percentage for `GridPrefix.xs` (or any single breakpoint), '
              'the grid will effectively have a fixed number of items per row across all screen sizes, '
              'unless overridden by a more specific breakpoint.'),
            _buildExplanation(context, 'Example: Always 2 items per row (using 50% for xs)'),
            NextGridView(
              mainAxisExtent: 70,
              widthPercentages: const {
                GridPrefix.xs: 50, // 2 items per row
              },
              children: List.generate(6, (index) => _exampleGridItem(index + 1, color: Colors.orange.shade100)),
            ),
            const SizedBox(height: 10),
             _buildExplanation(context, 'Example: Always 3 items per row (using 33.33% for xs)'),
            NextGridView(
              mainAxisExtent: 70,
               mainAxisSpacing: 5,
               crossAxisSpacing: 5,
              widthPercentages: const {
                GridPrefix.xs: 33.33, // 3 items per row
              },
              children: List.generate(7, (index) => _exampleGridItem(index + 1, color: Colors.purple.shade100)),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'GridView with Many Items (Scroll Performance)'),
            _buildExplanation(context,
              'Shows a grid view handling a larger number of items (50+) demonstrating its inherent scrollability if it overflows its parent constraints. '
              'Note: If `NextGridView` is inside a `SingleChildScrollView` (like this page), it will expand to its full height. '
              'For internal scrolling in `NextGridView` itself, it would need to be constrained by a parent with a fixed height (e.g., a SizedBox or Expanded).'),
            SizedBox( // Constrain height to demonstrate internal scrollability if needed, though here it will just make the page longer.
              // height: 300, // Example if you wanted NextGridView to scroll internally
              child: NextGridView(
                mainAxisExtent: 60,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                widthPercentages: const {
                  GridPrefix.xs: 50,
                  GridPrefix.sm: 33.33,
                  GridPrefix.md: 25,
                  GridPrefix.lg: 20,
                },
                children: List.generate(50, (index) => _exampleGridItem(index + 1, color: Colors.cyan.shade50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
