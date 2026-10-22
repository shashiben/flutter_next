import 'package:flutter/material.dart';

import 'pages/layout_page.dart';
import 'pages/motion_page.dart';
import 'pages/values_page.dart';

void main() {
  runApp(const ShowcaseApp());
}

/// Three screens: layout, values, and motion.
class ShowcaseApp extends StatelessWidget {
  /// Creates the example app.
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Next',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ShowcaseHome(),
    );
  }
}

class ShowcaseHome extends StatefulWidget {
  const ShowcaseHome({super.key});

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome> {
  int _index = 0;

  static const _pages = <Widget>[
    LayoutPage(),
    ValuesPage(),
    MotionPage(),
  ];

  static const _destinations = <(IconData, String)>[
    (Icons.view_column_outlined, 'Layout'),
    (Icons.straighten, 'Values'),
    (Icons.animation_outlined, 'Motion'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 800;
    final page = _pages[_index];
    if (!wide) {
      return Scaffold(
        appBar: AppBar(title: Text(_destinations[_index].$2)),
        drawer: Drawer(child: _navList()),
        body: page,
      );
    }
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (index) => setState(() => _index = index),
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final destination in _destinations)
                NavigationRailDestination(
                  icon: Icon(destination.$1),
                  label: Text(destination.$2),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: page),
        ],
      ),
    );
  }

  Widget _navList() {
    return ListView(
      children: [
        for (var i = 0; i < _destinations.length; i++)
          ListTile(
            leading: Icon(_destinations[i].$1),
            title: Text(_destinations[i].$2),
            selected: i == _index,
            onTap: () {
              setState(() => _index = i);
              Navigator.of(context).pop();
            },
          ),
      ],
    );
  }
}
