import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class GridLayoutExamplePage extends StatelessWidget {
  const GridLayoutExamplePage({super.key});

  Widget _buildSectionTitle(BuildContext context, String title,
      {bool sub = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: sub ? 8.0 : 12.0, horizontal: sub ? 16.0 : 0.0),
      child: Text(title,
          style: sub
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.headlineSmall),
    );
  }

  Widget _buildExplanation(BuildContext context, String explanation) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 4.0, bottom: 8.0, left: 8.0, right: 8.0),
      child: Text(
        explanation,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontStyle: FontStyle.italic, color: Colors.grey.shade700),
      ),
    );
  }

  Widget _exampleBox(String text, Color color, {double height = 100}) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: color,
      height: height,
      child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black87))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid & Layout Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // _buildSectionTitle(context, 'NextContainer Examples'),
            // _buildSectionTitle(context, 'Fluid Container', sub: true),
            // _buildExplanation(
            //     context,
            //     'A fluid container (`fluid: true`) takes up the entire available width of its parent. '
            //     'It is useful for full-width sections or banners.'),
            // NextContainer(
            //   fluid: true,
            //   decoration: BoxDecoration(
            //     color: Colors.blue.shade50,
            //     border: Border.all(color: Colors.blue.shade200),
            //   ),
            //   padding: const EdgeInsets.all(8.0),
            //   children: [
            //     _exampleBox(
            //         'This container is fluid. Resize your window to see it adapt.',
            //         Colors.blue.shade100,
            //         height: 60),
            //   ],
            // ),
            // const SizedBox(height: 15),
            // _buildSectionTitle(context, 'Fixed-Width Container', sub: true),
            // _buildExplanation(
            //     context,
            //     'A fixed-width container (`fluid: false`, default) centers itself and has a maximum width that changes based on screen breakpoints (e.g., 540px on SM, 720px on MD, etc.). '
            //     'This is standard for main content areas.'),
            // NextContainer(
            //   fluid: false,
            //   decoration: BoxDecoration(
            //     color: Colors.green.shade50,
            //     border: Border.all(color: Colors.green.shade200),
            //   ),
            //   padding: const EdgeInsets.all(8.0),
            //   children: [
            //     _exampleBox(
            //         'This container is fixed-width. Its max width changes at breakpoints.',
            //         Colors.green.shade100,
            //         height: 60),
            //   ],
            // ),
            // const SizedBox(height: 15),
            // _buildSectionTitle(
            //     context, 'Container with Custom Styling & Alignment',
            //     sub: true),
            // _buildExplanation(context,
            //     'NextContainer supports `padding`, `decoration` (for background colors, borders, shadows), and `alignment` (for its content if the container itself is wider than its content due to fixed-width behavior).'),
            // NextContainer(
            //   alignment: Alignment
            //       .center, // Aligns the Column child if screen is wider than max-width
            //   decoration: BoxDecoration(
            //     color: Colors.purple.shade50,
            //     borderRadius: BorderRadius.circular(12.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.4),
            //         spreadRadius: 1,
            //         blurRadius: 6,
            //         offset: const Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            //   children: [
            //     _exampleBox(
            //         'This container has custom padding, border radius, and a shadow. Content is centered if fixed-width.',
            //         Colors.purple.shade100,
            //         height: 60),
            //   ],
            // ),
            // const Divider(height: 40, thickness: 1),
            // _buildSectionTitle(context, 'NextRow & NextCol: Sizing'),
            // _buildExplanation(
            //     context,
            //     'Columns (`NextCol`) are placed inside Rows (`NextRow`). The `sizes` property of `NextCol` uses a 12-column grid system. '
            //     'You specify column widths for different breakpoints (xs, sm, md, lg, xl, xxl). E.g., `col-xs-12` is full-width on extra-small screens, `col-sm-6` is half-width on small screens.'),
            // _buildSectionTitle(context, 'Example 1: Basic Responsive Sizing',
            //     sub: true),
            NextRow(
              children: [
                NextCol(
                  sizes:
                      'col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2 col-xxl-2',
                  child: _exampleBox(
                      'Col 1\nXS:12 SM:6 MD:4 LG:3', Colors.red.shade100),
                ),
                NextCol(
                  sizes:
                      'col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2 col-xxl-2',
                  child: _exampleBox(
                      'Col 2\nXS:12 SM:6 MD:4 LG:3', Colors.orange.shade100),
                ),
                NextCol(
                  sizes:
                      'col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2 col-xxl-2',
                  child: _exampleBox(
                      'Col 3\nXS:12 SM:6 MD:4 LG:3', Colors.yellow.shade100),
                ),
                NextCol(
                  sizes:
                      'col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2 col-xxl-2',
                  child: _exampleBox(
                      'Col 4\nXS:12 SM:6 MD:12 LG:3', Colors.teal.shade100),
                ),
              ],
            ),
            // const SizedBox(height: 15),
            // _buildSectionTitle(context, 'Example 2: Mixed Sizing', sub: true),
            // NextRow(
            //   children: [
            //     NextCol(
            //       sizes: 'col-md-8',
            //       child: _exampleBox('Takes 8 of 12 columns on MD and up',
            //           Colors.indigo.shade100),
            //     ),
            //     NextCol(
            //       sizes: 'col-md-4',
            //       child: _exampleBox('Takes 4 of 12 columns on MD and up',
            //           Colors.pink.shade100),
            //     ),
            //   ],
            // ),
            // const Divider(height: 40, thickness: 1),
            // _buildSectionTitle(context, 'NextRow & NextCol: Offsetting'),
            // _buildExplanation(
            //     context,
            //     'The `offsets` property of `NextCol` pushes columns to the right. '
            //     'E.g., `offset-md-3` pushes a column by 3 column units on medium screens and larger.'),
            // _buildSectionTitle(context, 'Example 1: Centering a Column',
            //     sub: true),
            // NextRow(
            //   children: [
            //     NextCol(
            //       sizes: 'col-md-6',
            //       offsets: 'offset-md-3',
            //       child: _exampleBox(
            //           'Col MD-6, Offset MD-3 (Effectively Centered)',
            //           Colors.cyan.shade100,
            //           height: 80),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 15),
            // _buildSectionTitle(context, 'Example 2: Responsive Offsetting',
            //     sub: true),
            // NextRow(
            //   children: [
            //     NextCol(
            //       sizes: 'col-sm-5 col-lg-4',
            //       offsets: 'offset-sm-1 offset-lg-2',
            //       child: _exampleBox(
            //           'Col SM-5 LG-4\nOffset SM-1 LG-2', Colors.lime.shade100,
            //           height: 80),
            //     ),
            //     NextCol(
            //       sizes: 'col-sm-4 col-lg-3',
            //       offsets: 'offset-sm-1 offset-lg-2',
            //       child: _exampleBox(
            //           'Col SM-4 LG-3\nOffset SM-1 LG-2', Colors.brown.shade100,
            //           height: 80),
            //     ),
            //   ],
            // ),
            // const Divider(height: 40, thickness: 1),
            // _buildSectionTitle(context, 'NextRow & NextCol: Ordering'),
            // _buildExplanation(
            //     context,
            //     'The `order` property of `NextCol` changes the visual order of columns independently of their source order. '
            //     'E.g., `order-sm-2` makes a column appear second on small screens. `order-md-1` makes it first on medium screens.'),
            // _buildSectionTitle(context, 'Example 1: Simple Reordering',
            //     sub: true),
            // NextRow(
            //   children: [
            //     NextCol(
            //       sizes: 'col-sm-8 col-md-6',
            //       order: 'order-sm-2 order-md-1',
            //       child: _exampleBox('Content A\nOrder: SM-2, MD-1',
            //           Colors.lightBlue.shade100),
            //     ),
            //     NextCol(
            //       sizes: 'col-sm-4 col-md-6',
            //       order: 'order-sm-1 order-md-2',
            //       child: _exampleBox('Content B\nOrder: SM-1, MD-2',
            //           Colors.lightGreen.shade100),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 15),
            // _buildSectionTitle(
            //     context, 'Example 2: Complex Reordering (3+ items)',
            //     sub: true),
            // NextRow(
            //   children: [
            //     NextCol(
            //       sizes: 'col-xs-12 col-md-4',
            //       order: 'order-xs-3 order-md-1',
            //       child: _exampleBox('Item X (Third on XS, First on MD)',
            //           Colors.purple.shade100),
            //     ),
            //     NextCol(
            //       sizes: 'col-xs-12 col-md-4',
            //       order: 'order-xs-1 order-md-2',
            //       child: _exampleBox('Item Y (First on XS, Second on MD)',
            //           Colors.deepOrange.shade100),
            //     ),
            //     NextCol(
            //       sizes: 'col-xs-12 col-md-4',
            //       order: 'order-xs-2 order-md-3',
            //       child: _exampleBox('Item Z (Second on XS, Third on MD)',
            //           Colors.teal.shade200),
            //     ),
            //   ],
            // ),
            // const Divider(height: 40, thickness: 1),
            // _buildSectionTitle(context, 'NextRow & NextCol: Visibility'),
            // _buildExplanation(
            //     context,
            //     'The `invisibleForSizes` property of `NextCol` hides the column on specified breakpoints. '
            //     'Provide a space-separated string of breakpoint names (e.g., "xs sm" to hide on extra-small and small).'),
            // _buildSectionTitle(
            //     context, 'Example 1: Hide on Specific Breakpoints',
            //     sub: true),
            // NextRow(
            //   children: [
            //     NextCol(
            //       sizes: 'col-6 col-md-4',
            //       child: _exampleBox('Always Visible Col', Colors.pink.shade100,
            //           height: 80),
            //     ),
            //     NextCol(
            //       sizes: 'col-6 col-md-4',
            //       invisibleForSizes: 'xs sm',
            //       child: _exampleBox('Hidden on XS & SM', Colors.amber.shade100,
            //           height: 80),
            //     ),
            //     NextCol(
            //       sizes: 'col-md-4', // Only specify sizes for when it's visible
            //       invisibleForSizes: 'md',
            //       child: _exampleBox('Hidden on MD only', Colors.grey.shade300,
            //           height: 80),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 15),
            // _buildSectionTitle(
            //     context, 'Example 2: Show only on specific breakpoints',
            //     sub: true),
            // _buildExplanation(context,
            //     'To show a column *only* on specific breakpoints, you make it invisible on all *other* breakpoints.'),
            // NextRow(
            //   children: [
            //     NextCol(
            //       sizes: 'col-12', // Full width when visible
            //       invisibleForSizes:
            //           'xs sm lg xl xxl', // Hidden on all except MD
            //       child: _exampleBox('VISIBLE ONLY ON MD', Colors.red.shade200,
            //           height: 60),
            //     ),
            //     NextCol(
            //       sizes: 'col-12', // Full width when visible
            //       invisibleForSizes:
            //           'md lg xl xxl', // Hidden on all except XS and SM
            //       child: _exampleBox(
            //           'VISIBLE ONLY ON XS & SM', Colors.blue.shade200,
            //           height: 60),
            //     ),
            //   ],
            // ),
            // const Divider(height: 40, thickness: 1),
            // _buildSectionTitle(context, 'NextResponsiveVisibility Examples'),
            // _buildExplanation(
            //     context,
            //     '`NextResponsiveVisibility` conditionally renders its child widget based on the active breakpoint. '
            //     'The `breakpoints` property takes a space-separated string of breakpoint names (e.g., "lg xl").'),
            // _buildSectionTitle(
            //     context, 'Example 1: Show on specific breakpoints',
            //     sub: true),
            // NextResponsiveVisibility(
            //   breakpoints: 'lg xl xxl',
            //   child: _exampleBox(
            //       'Visible on LG, XL, XXL screens', Colors.deepPurple.shade100,
            //       height: 60),
            // ),
            // NextResponsiveVisibility(
            //   breakpoints: 'xs sm md',
            //   child: _exampleBox(
            //       'Visible on XS, SM, MD screens', Colors.teal.shade100,
            //       height: 60),
            // ),
            // const SizedBox(height: 8),
            // _buildSectionTitle(
            //     context, 'Example 2: Show only on one breakpoint',
            //     sub: true),
            // NextResponsiveVisibility(
            //   breakpoints: 'md',
            //   child: _exampleBox('VISIBLE ONLY ON MD', Colors.orange.shade200,
            //       height: 60),
            // ),
            // const SizedBox(height: 8),
            // _buildSectionTitle(context, 'Example 3: Swapping UI sections',
            //     sub: true),
            // _buildExplanation(context,
            //     'Use multiple `NextResponsiveVisibility` widgets to show different content for different screen sizes.'),
            // NextResponsiveVisibility(
            //   breakpoints: 'xs sm',
            //   child: _exampleBox(
            //       'Mobile View Content (XS, SM)', Colors.lightBlue.shade100,
            //       height: 80),
            // ),
            // NextResponsiveVisibility(
            //   breakpoints: 'md lg',
            //   child: _exampleBox('Tablet/Desktop View Content (MD, LG)',
            //       Colors.lightGreen.shade100,
            //       height: 80),
            // ),
            // NextResponsiveVisibility(
            //   breakpoints: 'xl xxl',
            //   child: _exampleBox(
            //       'Large Desktop View Content (XL, XXL)', Colors.pink.shade200,
            //       height: 80),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(top: 16),
            //   padding: const EdgeInsets.all(8.0),
            //   color: Colors.grey.shade300,
            //   width: double.infinity,
            //   child: const Text(
            //       'This text is always visible (standard Container for comparison)',
            //       textAlign: TextAlign.center),
            // ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
