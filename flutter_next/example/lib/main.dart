import 'package:example/pages/alerts_example.dart';
import 'package:example/pages/grid_layout_example.dart';
import 'package:example/pages/gridview_example.dart';
// import 'package:example/pages/avatar_showcase_legacy.dart'; // Renamed old avatar example

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
        // Example of setting a default text theme for explanations if needed globally
        // textTheme: Theme.of(context).textTheme.copyWith(
        //       bodySmall: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade700),
        //     ),
      ),
      home: const ExampleHomePage(), // Set new home page
      routes: {
        '/alerts': (context) => const AlertsExamplePage(),
        '/grid_layout': (context) => const GridLayoutExamplePage(),
        '/gridview': (context) => const GridViewExamplePage(),
        // Add routes for other examples if needed
        // '/animations': (context) => const AllAnimationsExamplePage(),
      },
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  Widget _buildNavigationItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required String routeName,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(icon, color: Theme.of(context).primaryColor),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
        const Divider(height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Next Playground'),
      ),
      body: ListView(
        children: <Widget>[
          _buildNavigationItem(
            context,
            title: 'Grid & Layout',
            subtitle:
                'NextContainer, NextRow, NextCol, NextResponsiveVisibility.',
            icon: Icons.grid_on_outlined,
            routeName: '/grid_layout',
          ),
          _buildNavigationItem(
            context,
            title: 'Alerts',
            subtitle: 'Examples for NextAlerts widget.',
            icon: Icons.warning_amber_rounded,
            routeName: '/alerts',
          ),
          _buildNavigationItem(
            context,
            title: 'Accordion',
            subtitle: 'Examples for NextAccordion widget.',
            icon: Icons.menu_open_outlined,
            routeName: '/accordion',
          ),
          _buildNavigationItem(
            context,
            title: 'Avatars',
            subtitle: 'Showcases NextAvatar and NextAvatarGroup.',
            icon: Icons.person_outline,
            routeName: '/avatar',
          ),
          _buildNavigationItem(
            context,
            title: 'Breadcrumbs',
            subtitle: 'Examples for NextBreadCrumb widget.',
            icon: Icons.arrow_forward_ios_sharp,
            routeName: '/breadcrumb',
          ),
          _buildNavigationItem(
            context,
            title: 'Buttons',
            subtitle: 'Examples for NextButton widget.',
            icon: Icons.smart_button_outlined,
            routeName: '/button',
          ),
          _buildNavigationItem(
            context,
            title: 'GridView',
            subtitle: 'Examples for NextGridView widget.',
            icon: Icons.view_module_outlined,
            routeName: '/gridview',
          ),
        ],
      ),
    );
  }
}
