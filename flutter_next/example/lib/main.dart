import 'package:example/pages/avatar_example.dart';
import 'package:example/pages/grid_layout_example.dart'; // Import the new page
import 'package:flutter/material.dart';
// Import other example pages if you have them, e.g.:
// import 'package:example/animations/all_animations_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Next Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Optional: enable Material 3 for modern look
      ),
      home: const ExampleHomePage(), // Set new home page
      routes: {
        '/avatar': (context) => NextAvatarShowcasePage(),
        '/grid_layout': (context) => const GridLayoutExamplePage(),
        // Add routes for other examples if needed
        // '/animations': (context) => const AllAnimationsExamplePage(),
      },
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Next Playground'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Avatar Examples'),
            subtitle: const Text('Showcases NextAvatar and NextAvatarGroup.'),
            leading: const Icon(Icons.person_outline),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/avatar');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Grid Layout Examples'),
            subtitle: const Text('Demonstrates NextContainer, NextRow, NextCol, and NextResponsiveVisibility.'),
            leading: const Icon(Icons.grid_on_outlined),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/grid_layout');
            },
          ),
          const Divider(),
          // Add ListTile for other examples here
          // ListTile(
          //   title: const Text('Animation Examples'),
          //   subtitle: const Text('Various animation widgets.'),
          //   leading: const Icon(Icons.animation),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/animations');
          //   },
          // ),
        ],
      ),
    );
  }
}

// The previously commented out large Column of examples could be
// moved into its own example page if desired.
// For example, create a file like `all_widgets_example.dart`
// and then navigate to it from the ExampleHomePage.

/*
class AllWidgetsExamplePage extends StatelessWidget {
  const AllWidgetsExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Widgets Showcase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (paste the original commented out Column content here) ...
            // Make sure to import NextGridView, NextRow, NextCol,
            // various animation examples, NextAvatarGroup, etc.
            // and also flutter_next.dart for context.titleLarge etc.
            // For example:
            // import 'package:flutter_next/flutter_next.dart';
            // import 'package:example/animations/zoom_animation_example.dart'; // and others

            Text(
              "Next Grid View",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // NextGridView(...),
            // ... and so on for all other examples
          ],
        ),
      ),
    );
  }
}
*/
