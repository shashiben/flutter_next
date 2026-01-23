import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocsLayout extends StatelessWidget {
  const DocsLayout({
    super.key,
    required this.selectedRoute,
    required this.navigationShell,
  });
  final String selectedRoute;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Next Animation & Flutter Next'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: _buildDrawer(context),
        body: navigationShell,
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // Side Navigation
          Container(
            width: 280,
            color: Theme.of(context).colorScheme.surface,
            child: _buildSideNav(context),
          ),
          // Main Content
          Expanded(
            child: navigationShell,
          ),
        ],
      ),
    );
  }

  Widget _buildSideNav(BuildContext context) {
    final routes = [
      _NavItem(icon: Icons.play_circle, label: 'Playground', route: '/'),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Next Animation',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '& Flutter Next',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                ),
              ],
            ),
          ),
          ...routes.map((item) {
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              selected: selectedRoute == item.route,
              selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
              onTap: () {
                context.go(item.route);
                final scaffold = Scaffold.maybeOf(context);
                if (scaffold?.hasDrawer ?? false) {
                  Navigator.of(context).pop();
                }
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return _buildSideNav(context);
  }
}

class _NavItem {
  _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
  final IconData icon;
  final String label;
  final String route;
}
