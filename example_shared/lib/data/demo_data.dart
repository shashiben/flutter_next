import 'package:flutter/material.dart';

/// A product shown in the storefront demo.
class DemoProduct {
  /// Creates a product.
  const DemoProduct({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.icon,
    required this.accent,
    this.badge,
    this.previousPrice,
  });

  /// Product name.
  final String name;

  /// Shelf the product sits on.
  final String category;

  /// Current price in dollars.
  final double price;

  /// Average rating out of five.
  final double rating;

  /// Number of ratings.
  final int reviews;

  /// Icon drawn in the artwork placeholder.
  final IconData icon;

  /// Accent color of the artwork.
  final Color accent;

  /// Optional badge, such as `New`.
  final String? badge;

  /// Optional price the product is discounted from.
  final double? previousPrice;
}

/// A metric tile in the dashboard demo.
class DemoMetric {
  /// Creates a metric.
  const DemoMetric({
    required this.label,
    required this.value,
    required this.delta,
    required this.trend,
    required this.spark,
  });

  /// Metric name.
  final String label;

  /// Formatted value.
  final String value;

  /// Change against the previous period.
  final String delta;

  /// True when the metric grew.
  final bool trend;

  /// Twelve values used for the sparkline.
  final List<double> spark;
}

/// An entry in the dashboard activity feed.
class DemoActivity {
  /// Creates an activity entry.
  const DemoActivity({
    required this.name,
    required this.action,
    required this.time,
    required this.initials,
  });

  /// Who did it.
  final String name;

  /// What they did.
  final String action;

  /// When they did it.
  final String time;

  /// Initials shown in the avatar.
  final String initials;
}

/// A line in the checkout summary.
class DemoCartLine {
  /// Creates a cart line.
  const DemoCartLine({
    required this.name,
    required this.detail,
    required this.price,
    required this.quantity,
    required this.icon,
    required this.accent,
  });

  /// Product name.
  final String name;

  /// Variant or size.
  final String detail;

  /// Unit price in dollars.
  final double price;

  /// Units ordered.
  final int quantity;

  /// Icon drawn in the artwork placeholder.
  final IconData icon;

  /// Accent color of the artwork.
  final Color accent;
}

/// A pricing plan in the landing demo.
class DemoPlan {
  /// Creates a plan.
  const DemoPlan({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    this.highlighted = false,
  });

  /// Plan name.
  final String name;

  /// Monthly price in dollars.
  final double price;

  /// Billing period.
  final String period;

  /// What the plan includes.
  final List<String> features;

  /// True for the plan the page pushes.
  final bool highlighted;
}

/// A customer quote in the landing demo.
class DemoQuote {
  /// Creates a quote.
  const DemoQuote({
    required this.quote,
    required this.name,
    required this.role,
  });

  /// What the customer said.
  final String quote;

  /// Customer name.
  final String name;

  /// Customer role and company.
  final String role;
}

/// A feature in the landing demo.
class DemoFeature {
  /// Creates a feature.
  const DemoFeature({
    required this.title,
    required this.body,
    required this.icon,
  });

  /// Feature name.
  final String title;

  /// One line about the feature.
  final String body;

  /// Icon drawn in the tile.
  final IconData icon;
}

/// Shelves in the storefront demo.
const List<String> kDemoCategories = <String>[
  'All',
  'Outerwear',
  'Packs',
  'Shelter',
  'Camp',
  'Essentials',
];

/// Products in the storefront demo.
const List<DemoProduct> kDemoProducts = <DemoProduct>[
  DemoProduct(
    name: 'Alpine Shell',
    category: 'Outerwear',
    price: 289,
    rating: 4.8,
    reviews: 214,
    icon: Icons.cloud_outlined,
    accent: Color(0xFF5B5BD6),
    badge: 'Best seller',
    previousPrice: 340,
  ),
  DemoProduct(
    name: 'Trailhead Pack',
    category: 'Packs',
    price: 149,
    rating: 4.6,
    reviews: 98,
    icon: Icons.shopping_bag_outlined,
    accent: Color(0xFF2D8F6F),
  ),
  DemoProduct(
    name: 'Basecamp Tent',
    category: 'Shelter',
    price: 399,
    rating: 4.9,
    reviews: 61,
    icon: Icons.holiday_village_outlined,
    accent: Color(0xFF3E7BD6),
    badge: 'New',
  ),
  DemoProduct(
    name: 'Meridian Boots',
    category: 'Outerwear',
    price: 179,
    rating: 4.4,
    reviews: 312,
    icon: Icons.directions_walk_outlined,
    accent: Color(0xFF8A6BD6),
  ),
  DemoProduct(
    name: 'Drift Lantern',
    category: 'Camp',
    price: 59,
    rating: 4.7,
    reviews: 143,
    icon: Icons.light_mode_outlined,
    accent: Color(0xFFE8A13B),
  ),
  DemoProduct(
    name: 'Cascade Bottle',
    category: 'Essentials',
    price: 34,
    rating: 4.5,
    reviews: 502,
    icon: Icons.water_drop_outlined,
    accent: Color(0xFF3FA9D6),
  ),
  DemoProduct(
    name: 'Ridge Socks',
    category: 'Essentials',
    price: 18,
    rating: 4.3,
    reviews: 88,
    icon: Icons.checkroom_outlined,
    accent: Color(0xFFD96A8B),
  ),
  DemoProduct(
    name: 'Summit Poles',
    category: 'Packs',
    price: 129,
    rating: 4.8,
    reviews: 77,
    icon: Icons.trending_up_outlined,
    accent: Color(0xFF4C9A4C),
  ),
  DemoProduct(
    name: 'Ember Heater',
    category: 'Camp',
    price: 89,
    rating: 4.2,
    reviews: 41,
    icon: Icons.local_fire_department_outlined,
    accent: Color(0xFFD9552F),
  ),
];

/// Metrics in the dashboard demo.
const List<DemoMetric> kDemoMetrics = <DemoMetric>[
  DemoMetric(
    label: 'Revenue',
    value: r'$48,920',
    delta: '12.4%',
    trend: true,
    spark: <double>[12, 18, 15, 22, 19, 26, 24, 31, 28, 34, 30, 38],
  ),
  DemoMetric(
    label: 'Orders',
    value: '1,284',
    delta: '8.1%',
    trend: true,
    spark: <double>[8, 12, 11, 14, 13, 18, 16, 21, 19, 22, 24, 27],
  ),
  DemoMetric(
    label: 'Conversion',
    value: '3.6%',
    delta: '0.4%',
    trend: false,
    spark: <double>[22, 20, 24, 21, 19, 23, 18, 17, 19, 16, 15, 14],
  ),
  DemoMetric(
    label: 'Avg. order',
    value: r'$38.10',
    delta: '2.2%',
    trend: true,
    spark: <double>[10, 11, 13, 12, 15, 14, 16, 18, 17, 19, 20, 22],
  ),
];

/// Activity feed in the dashboard demo.
const List<DemoActivity> kDemoActivity = <DemoActivity>[
  DemoActivity(
    name: 'Maya Chen',
    action: 'Shipped order #4821',
    time: '4 min ago',
    initials: 'MC',
  ),
  DemoActivity(
    name: 'Owen Brooks',
    action: 'Updated the Alpine Shell price',
    time: '18 min ago',
    initials: 'OB',
  ),
  DemoActivity(
    name: 'Priya Raman',
    action: 'Restocked the Trailhead Pack',
    time: '42 min ago',
    initials: 'PR',
  ),
  DemoActivity(
    name: 'Jonas Weber',
    action: 'Refunded order #4790',
    time: '2 h ago',
    initials: 'JW',
  ),
  DemoActivity(
    name: 'Ada Nwosu',
    action: 'Opened the weekend promo',
    time: '3 h ago',
    initials: 'AN',
  ),
];

/// Cart lines in the checkout demo.
const List<DemoCartLine> kDemoCartLines = <DemoCartLine>[
  DemoCartLine(
    name: 'Alpine Shell',
    detail: 'Slate · Medium',
    price: 289,
    quantity: 1,
    icon: Icons.cloud_outlined,
    accent: Color(0xFF5B5BD6),
  ),
  DemoCartLine(
    name: 'Trailhead Pack',
    detail: 'Moss · 24 L',
    price: 149,
    quantity: 1,
    icon: Icons.shopping_bag_outlined,
    accent: Color(0xFF2D8F6F),
  ),
  DemoCartLine(
    name: 'Cascade Bottle',
    detail: 'Steel · 750 ml',
    price: 34,
    quantity: 2,
    icon: Icons.water_drop_outlined,
    accent: Color(0xFF3FA9D6),
  ),
];

/// Plans in the landing demo.
const List<DemoPlan> kDemoPlans = <DemoPlan>[
  DemoPlan(
    name: 'Solo',
    price: 0,
    period: 'forever',
    features: <String>['1 project', '5 GB of storage', 'Community support'],
  ),
  DemoPlan(
    name: 'Team',
    price: 24,
    period: 'per seat / month',
    highlighted: true,
    features: <String>[
      '10 projects',
      '100 GB of storage',
      'Priority support',
      'Custom domains',
    ],
  ),
  DemoPlan(
    name: 'Scale',
    price: 79,
    period: 'per seat / month',
    features: <String>[
      'Unlimited projects',
      '1 TB of storage',
      'SSO and audit log',
      'Dedicated manager',
    ],
  ),
];

/// Quotes in the landing demo.
const List<DemoQuote> kDemoQuotes = <DemoQuote>[
  DemoQuote(
    quote:
        'The grid finally matches the design file. We ship the same layout '
        'on every surface without a single media query.',
    name: 'Elena Duarte',
    role: 'Design lead, Kestrel',
  ),
  DemoQuote(
    quote:
        'Our checkout went from four hand-written breakpoints to one rule. '
        'The layout reads the parent, so panels collapse on their own.',
    name: 'Tomas Weber',
    role: 'Frontend, Nordwind',
  ),
];

/// Features in the landing demo.
const List<DemoFeature> kDemoFeatures = <DemoFeature>[
  DemoFeature(
    title: 'Parent width, not screen width',
    body:
        'A column measures the frame that holds it, so a card, a split view, '
        'or the whole window all resolve the same way.',
    icon: Icons.straighten_outlined,
  ),
  DemoFeature(
    title: 'One cascade for everything',
    body:
        'Spans, values, visibility, and surfaces all read the same '
        'breakpoint, so a screen never disagrees with itself.',
    icon: Icons.waterfall_chart_outlined,
  ),
  DemoFeature(
    title: 'Motion as one spec',
    body:
        'Fade, slide, zoom, bounce, and flip share a single motion type, '
        'with delays and curves handled for you.',
    icon: Icons.animation_outlined,
  ),
  DemoFeature(
    title: 'Theme colors that stay in sync',
    body:
        'Surfaces, buttons, alerts, and avatars pull from the same variant '
        'palette, so a new theme lands everywhere at once.',
    icon: Icons.palette_outlined,
  ),
  DemoFeature(
    title: 'Real components, not primitives',
    body:
        'Accordions, breadcrumbs, avatars, alerts, and buttons ship ready, '
        'with variants instead of one-off styles.',
    icon: Icons.widgets_outlined,
  ),
  DemoFeature(
    title: 'Reduced motion respected',
    body:
        'When the system asks for less motion, every animation jumps to its '
        'final frame instead of playing.',
    icon: Icons.accessibility_new_outlined,
  ),
];

/// A step in the how-it-works row.
class DemoStep {
  /// Creates a step.
  const DemoStep({required this.title, required this.body, required this.icon});

  /// Step title.
  final String title;

  /// One line about the step.
  final String body;

  /// Icon drawn in the step.
  final IconData icon;
}

/// A question and answer in the FAQ.
class DemoFaq {
  /// Creates an entry.
  const DemoFaq({required this.question, required this.answer});

  /// The question.
  final String question;

  /// The answer.
  final String answer;
}

/// Steps in the how-it-works row.
const List<DemoStep> kDemoSteps = <DemoStep>[
  DemoStep(
    title: 'Measure the parent',
    body: 'Wrap the screen in a scope and every child reads that width.',
    icon: Icons.straighten_outlined,
  ),
  DemoStep(
    title: 'Declare the tracks',
    body: 'Give each column a span per breakpoint and let the grid place it.',
    icon: Icons.grid_view_outlined,
  ),
  DemoStep(
    title: 'Ship one tree',
    body: 'The same widgets run on a phone, a split pane, and a browser.',
    icon: Icons.rocket_launch_outlined,
  ),
];

/// Questions in the FAQ.
const List<DemoFaq> kDemoFaqs = <DemoFaq>[
  DemoFaq(
    question: 'Does the breakpoint follow the window or the parent?',
    answer:
        'The parent. A card that is 400 pixels wide inside a 1600 pixel '
        'window still resolves the small breakpoint, so the layout inside '
        'the card is the layout you designed.',
  ),
  DemoFaq(
    question: 'How do I keep the container from stretching too wide?',
    answer:
        'NextContainer caps the content width per breakpoint. Set fluid to '
        'true when the screen should fill its parent instead.',
  ),
  DemoFaq(
    question: 'Can I mix the grid with normal Flutter widgets?',
    answer:
        'Yes. NextRow and NextGrid lay out their children, and everything '
        'else in the tree works exactly as it does in Flutter.',
  ),
  DemoFaq(
    question: 'What happens with reduced motion?',
    answer:
        'Every motion jumps to its final frame, so the screen still reads '
        'the same without the movement.',
  ),
];
