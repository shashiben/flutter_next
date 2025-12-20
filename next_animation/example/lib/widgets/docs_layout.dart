import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocsLayout extends StatelessWidget {
  final Widget child;
  final String selectedRoute;

  const DocsLayout({
    super.key,
    required this.child,
    required this.selectedRoute,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Next Animation'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        drawer: _buildDrawer(context),
        body: child,
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
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildSideNav(BuildContext context) {
    final routes = [
      _NavItem(icon: Icons.home, label: 'Home', route: '/'),
      _NavItem(icon: Icons.rocket_launch, label: 'Getting Started', route: '/getting-started'),
      _NavItem(icon: Icons.sports_esports, label: 'Bounce', route: '/bounce'),
      _NavItem(icon: Icons.visibility, label: 'Fade', route: '/fade'),
      _NavItem(icon: Icons.swipe, label: 'Slide', route: '/slide'),
      _NavItem(icon: Icons.zoom_in, label: 'Zoom', route: '/zoom'),
      _NavItem(icon: Icons.flip, label: 'Flip', route: '/flip'),
      _NavItem(icon: Icons.palette, label: 'Color Tween', route: '/color-tween'),
      _NavItem(icon: Icons.code, label: 'API Reference', route: '/api'),
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
                  'Documentation',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                ),
              ],
            ),
          ),
          ...routes.map((item) => ListTile(
                leading: Icon(item.icon),
                title: Text(item.label),
                selected: selectedRoute == item.route,
                selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
                onTap: () {
                  context.go(item.route);
                  if (Scaffold.of(context).hasDrawer) {
                    Navigator.of(context).pop();
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return _buildSideNav(context);
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

