import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class GridLayoutExamplePage extends StatelessWidget {
  const GridLayoutExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Layout Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'NextContainer Examples',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text('Fluid Container (takes full width):', style: Theme.of(context).textTheme.titleMedium),
            NextContainer(
              fluid: true,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                border: Border.all(color: Colors.blue.shade300),
              ),
              padding: const EdgeInsets.all(8.0),
              children: [
                Container(
                  color: Colors.blue.shade200,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('This container is fluid.'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Fixed-width Container (centered with max width based on breakpoint):', style: Theme.of(context).textTheme.titleMedium),
            NextContainer(
              fluid: false, // Default
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                border: Border.all(color: Colors.green.shade300),
              ),
              padding: const EdgeInsets.all(8.0),
              children: [
                Container(
                  color: Colors.green.shade200,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('This container is fixed-width.'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Container with custom padding and decoration:', style: Theme.of(context).textTheme.titleMedium),
            NextContainer(
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              children: [
                Container(
                  color: Colors.purple.shade200,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('This container has custom styling.'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'NextRow and NextCol Examples',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text('Basic Responsive Grid:', style: Theme.of(context).textTheme.titleMedium),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-xs-12 col-sm-6 col-md-4 col-lg-3',
                  child: Container(
                    color: Colors.red.shade200,
                    height: 100,
                    child: const Center(child: Text('Col 1\nXS:12, SM:6, MD:4, LG:3')),
                  ),
                ),
                NextCol(
                  sizes: 'col-xs-12 col-sm-6 col-md-4 col-lg-3',
                  child: Container(
                    color: Colors.orange.shade200,
                    height: 100,
                    child: const Center(child: Text('Col 2\nXS:12, SM:6, MD:4, LG:3')),
                  ),
                ),
                NextCol(
                  sizes: 'col-xs-12 col-sm-6 col-md-4 col-lg-3',
                  child: Container(
                    color: Colors.yellow.shade200,
                    height: 100,
                    child: const Center(child: Text('Col 3\nXS:12, SM:6, MD:4, LG:3')),
                  ),
                ),
                NextCol(
                  sizes: 'col-xs-12 col-sm-6 col-md-12 col-lg-3', // Full width on MD
                  child: Container(
                    color: Colors.teal.shade200,
                    height: 100,
                    child: const Center(child: Text('Col 4\nXS:12, SM:6, MD:12, LG:3')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text('Column Offsetting:', style: Theme.of(context).textTheme.titleMedium),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-md-6',
                  offsets: 'offset-md-3', // Centered on MD and up
                  child: Container(
                    color: Colors.cyan.shade200,
                    height: 80,
                    child: const Center(child: Text('Col MD-6, Offset MD-3')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text('Column Reordering:', style: Theme.of(context).textTheme.titleMedium),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-sm-8 col-md-6',
                  order: 'order-sm-2 order-md-1', // Second on SM, First on MD
                  child: Container(
                    color: Colors.lightBlue.shade200,
                    height: 100,
                    child: const Center(child: Text('Content A\nOrder: SM-2, MD-1')),
                  ),
                ),
                NextCol(
                  sizes: 'col-sm-4 col-md-6',
                  order: 'order-sm-1 order-md-2', // First on SM, Second on MD
                  child: Container(
                    color: Colors.lightGreen.shade200,
                    height: 100,
                    child: const Center(child: Text('Content B\nOrder: SM-1, MD-2')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text('Hiding Columns:', style: Theme.of(context).textTheme.titleMedium),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-6',
                  child: Container(
                    color: Colors.pink.shade100,
                    height: 80,
                    child: const Center(child: Text('Always Visible Col')),
                  ),
                ),
                NextCol(
                  sizes: 'col-6',
                  invisibleForSizes: 'xs sm', // Hidden on XS and SM
                  child: Container(
                    color: Colors.amber.shade200,
                    height: 80,
                    child: const Center(child: Text('Hidden on XS & SM')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'NextResponsiveVisibility Examples',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text('Conditionally displaying widgets:', style: Theme.of(context).textTheme.titleMedium),
            NextResponsiveVisibility(
              breakpoints: 'lg xl xxl', // Only visible on large, extra-large, and extra-extra-large screens
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.deepPurple.shade100,
                child: const Text('Visible on LG, XL, XXL screens'),
              ),
            ),
            NextResponsiveVisibility(
              breakpoints: 'xs sm md', // Only visible on small and medium screens
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.teal.shade100,
                child: const Text('Visible on XS, SM, MD screens'),
              ),
            ),
            Container( // This container is always visible for comparison
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8.0),
                color: Colors.grey.shade300,
                child: const Text('This text is always visible (standard Container)'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
