import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'accordion_example.dart';
import 'alerts_example.dart';
import 'animations_example.dart';
import 'avatar_showcase_legacy.dart';
import 'breadcrumb_example.dart';
import 'button_example.dart';
import 'grid_layout_example.dart';
import 'gridview_example.dart';

class FlutterNextExamplesPage extends StatelessWidget {
  const FlutterNextExamplesPage({super.key});

  Widget _buildNavigationItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<Widget>(builder: (_) => page),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Next Examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildNavigationItem(
            context,
            title: 'Grid & Layout',
            subtitle:
                'NextContainer, NextRow, NextCol, NextResponsiveVisibility.',
            icon: Icons.grid_on_outlined,
            page: const GridLayoutExamplePage(),
          ),
          _buildNavigationItem(
            context,
            title: 'Alerts',
            subtitle: 'Examples for NextAlerts widget.',
            icon: Icons.warning_amber_rounded,
            page: const AlertsExamplePage(),
          ),
          _buildNavigationItem(
            context,
            title: 'Accordion',
            subtitle: 'Examples for NextAccordion widget.',
            icon: Icons.menu_open_outlined,
            page: const AccordionExamplePage(),
          ),
          _buildNavigationItem(
            context,
            title: 'Avatars',
            subtitle: 'Showcases NextAvatar and NextAvatarGroup.',
            icon: Icons.person_outline,
            page: const NextAvatarShowcasePage(),
          ),
          _buildNavigationItem(
            context,
            title: 'Breadcrumbs',
            subtitle: 'Examples for NextBreadCrumb widget.',
            icon: Icons.arrow_forward_ios_sharp,
            page: const BreadcrumbExamplePage(),
          ),
          _buildNavigationItem(
            context,
            title: 'Buttons',
            subtitle: 'Examples for NextButton widget.',
            icon: Icons.smart_button_outlined,
            page: const ButtonExamplePage(),
          ),
          _buildNavigationItem(
            context,
            title: 'GridView',
            subtitle: 'Examples for NextGridView widget.',
            icon: Icons.view_module_outlined,
            page: const GridViewExamplePage(),
          ),
          _buildNavigationItem(
            context,
            title: 'Animations',
            subtitle: 'Showcase of all animation widgets.',
            icon: Icons.animation,
            page: const AnimationsExamplePage(),
          ),
        ],
      ),
    );
  }
}
