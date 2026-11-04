import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../pages/apps/checkout_page.dart';
import '../pages/apps/dashboard_page.dart';
import '../pages/apps/devices_page.dart';
import '../pages/apps/landing_page.dart';
import '../pages/apps/storefront_page.dart';

/// One live screen in the gallery.
class GalleryExample {
  /// Creates an example.
  const GalleryExample({
    required this.icon,
    required this.label,
    required this.caption,
    required this.blurb,
    required this.tag,
    required this.variant,
    required this.page,
  });

  /// Icon used in navigation and on the tile.
  final IconData icon;

  /// Short name.
  final String label;

  /// One line shown under the label in navigation.
  final String caption;

  /// Longer description shown on the tile.
  final String blurb;

  /// Category shown on the tile.
  final String tag;

  /// Colour set used by the tile accent.
  final NextVariant variant;

  /// Screen opened from the tile.
  final Widget page;
}

/// The screens shown on the overview and in the side navigation.
const List<GalleryExample> kGalleryExamples = <GalleryExample>[
  GalleryExample(
    icon: Icons.storefront_outlined,
    label: 'Storefront',
    caption: 'Catalogue and filters',
    blurb:
        'Category filters, a sort bar, and a product grid that reflows from '
        'one column to three.',
    tag: 'Commerce',
    variant: NextVariant.primary,
    page: StorefrontPage(),
  ),
  GalleryExample(
    icon: Icons.dashboard_outlined,
    label: 'Dashboard',
    caption: 'Metrics and activity',
    blurb:
        'Live KPI tiles, a revenue chart, and a compact rail when the parent '
        'is a tablet.',
    tag: 'Analytics',
    variant: NextVariant.success,
    page: DashboardPage(),
  ),
  GalleryExample(
    icon: Icons.shopping_cart_checkout_outlined,
    label: 'Checkout',
    caption: 'Form and order summary',
    blurb:
        'A two-step form and an order summary that moves above the form on '
        'phones.',
    tag: 'Checkout',
    variant: NextVariant.warning,
    page: CheckoutPage(),
  ),
  GalleryExample(
    icon: Icons.campaign_outlined,
    label: 'Landing',
    caption: 'Marketing page with motion',
    blurb:
        'A hero, pricing tiers, an FAQ, and staggered motion that follows the '
        'theme.',
    tag: 'Marketing',
    variant: NextVariant.secondary,
    page: LandingPage(),
  ),
  GalleryExample(
    icon: Icons.devices_outlined,
    label: 'Devices',
    caption: 'One app, three widths',
    blurb:
        'The same screen on an iPhone, an iPad, and a desktop window, next '
        'to a live span inspector.',
    tag: 'Layout',
    variant: NextVariant.info,
    page: DevicesPage(),
  ),
];
