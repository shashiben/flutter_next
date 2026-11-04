import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../../data/demo_data.dart';
import '../../widgets/app/app_card.dart';
import '../../widgets/app/app_space.dart';
import '../../widgets/app/app_top_bar.dart';

/// A storefront built with the layout kit.
///
/// The filter rail, the sort bar, and the product grid all react to the
/// parent width, never to the window.
class StorefrontView extends StatefulWidget {
  /// Creates the storefront.
  const StorefrontView({super.key});

  @override
  State<StorefrontView> createState() => _StorefrontViewState();
}

class _StorefrontViewState extends State<StorefrontView> {
  static const double _freeShippingAt = 150;

  String _category = 'All';
  String _sort = 'Popular';
  bool _filtersOpen = false;
  bool _promoVisible = true;
  final Set<String> _cart = <String>{};

  List<DemoProduct> get _visibleProducts {
    final products = _category == 'All'
        ? List<DemoProduct>.of(kDemoProducts)
        : kDemoProducts
              .where((product) => product.category == _category)
              .toList();
    switch (_sort) {
      case 'Price':
        products.sort((a, b) => a.price.compareTo(b.price));
      case 'Rating':
        products.sort((a, b) => b.rating.compareTo(a.rating));
      default:
        break;
    }
    return products;
  }

  double get _cartTotal {
    var total = 0.0;
    for (final product in kDemoProducts) {
      if (_cart.contains(product.name)) {
        total += product.price;
      }
    }
    return total;
  }

  void _toggle(DemoProduct product) {
    setState(() {
      if (!_cart.remove(product.name)) {
        _cart.add(product.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gap = context.gap;
    return Column(
      children: [
        AppTopBar(
          brand: 'Northwind Supply',
          subtitle: 'Field gear for teams that move',
          searchPlaceholder: 'Search jackets, packs, tents',
          actions: [
            NextButton(
              variant: NextButtonVariant.outlined,
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              onPressed: () {},
              leading: const Icon(Icons.shopping_bag_outlined, size: 18),
              child: AppButtonLabel('${_cart.length}'),
            ),
            const SizedBox(width: 12),
            const AppAvatar(initials: 'AR'),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: NextContainer(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              padding: context.pagePadding,
              children: [
                if (_promoVisible)
                  _PromoBanner(
                    onClose: () => setState(() => _promoVisible = false),
                  ),
                SizedBox(height: gap),
                _ShippingProgress(
                  total: _cartTotal,
                  threshold: _freeShippingAt,
                ),
                SizedBox(height: gap),
                _CategoryBar(
                  selected: _category,
                  onSelected: (value) => setState(() => _category = value),
                  onToggleFilters: () =>
                      setState(() => _filtersOpen = !_filtersOpen),
                ),
                SizedBox(height: gap),
                NextRow(
                  gutter: gap,
                  children: [
                    const NextCol(
                      span: NextSpan(lg: 3),
                      hidden: {Breakpoint.xs, Breakpoint.sm, Breakpoint.md},
                      child: _FilterPanel(),
                    ),
                    NextCol(
                      span: const NextSpan(lg: 9),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          NextShow(
                            from: Breakpoint.lg,
                            fallback: const SizedBox.shrink(),
                            child: _SortBar(
                              sort: _sort,
                              onChanged: (value) =>
                                  setState(() => _sort = value),
                            ),
                          ),
                          if (_filtersOpen)
                            Padding(
                              padding: EdgeInsets.only(top: gap),
                              child: const _FilterPanel(),
                            ),
                          SizedBox(height: gap),
                          _ProductGrid(
                            products: _visibleProducts,
                            cart: _cart,
                            sort: _sort,
                            onToggle: _toggle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: gap * 1.5),
                const _RecentlyViewed(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return NextAlert(
      variant: NextVariant.info,
      dismissible: true,
      onClosePressed: onClose,
      title: const Text('Free two-day shipping over \$150'),
      child: const Text(
        'Order before 4 pm and the warehouse ships the same afternoon.',
      ),
    );
  }
}

class _ShippingProgress extends StatelessWidget {
  const _ShippingProgress({required this.total, required this.threshold});

  final double total;
  final double threshold;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final remaining = threshold - total;
    final done = remaining <= 0;
    return AppCard(
      padding: const EdgeInsets.all(16),
      elevation: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                done
                    ? Icons.local_shipping_outlined
                    : Icons.inventory_2_outlined,
                size: 18,
                color: done
                    ? const Color(0xFF2D8F6F)
                    : theme.colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  done
                      ? 'Free shipping unlocked'
                      : 'Add \$${remaining.toStringAsFixed(0)} more for free shipping',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(0)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppProgress(
            value: total,
            total: threshold,
            color: done ? const Color(0xFF2D8F6F) : theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.selected,
    required this.onSelected,
    required this.onToggleFilters,
  });

  final String selected;
  final ValueChanged<String> onSelected;
  final VoidCallback onToggleFilters;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final category in kDemoCategories) ...[
                  AppChip(
                    label: category,
                    selected: category == selected,
                    onTap: () => onSelected(category),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        NextShow(
          from: Breakpoint.lg,
          fallback: _FilterButton(onTap: onToggleFilters),
          child: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return NextButton(
      variant: NextButtonVariant.outlined,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      onPressed: onTap,
      leading: const Icon(Icons.tune_rounded, size: 18),
      child: const AppButtonLabel('Filters'),
    );
  }
}

class _SortBar extends StatelessWidget {
  const _SortBar({required this.sort, required this.onChanged});

  final String sort;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Sort by',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        for (final option in const <String>['Popular', 'Price', 'Rating'])
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: AppChip(
              label: option,
              selected: option == sort,
              onTap: () => onChanged(option),
            ),
          ),
      ],
    );
  }
}

class _FilterPanel extends StatefulWidget {
  const _FilterPanel();

  @override
  State<_FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<_FilterPanel> {
  bool _inStock = true;
  bool _onSale = false;
  double _price = 320;
  final Set<String> _sizes = <String>{'XL'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(title: 'Filters'),
          const SizedBox(height: 12),
          _SwitchRow(
            label: 'In stock only',
            value: _inStock,
            onChanged: (v) {
              setState(() => _inStock = v);
            },
          ),
          _SwitchRow(
            label: 'On sale',
            value: _onSale,
            onChanged: (v) {
              setState(() => _onSale = v);
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Price',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Slider(
            value: _price,
            max: 500,
            onChanged: (value) => setState(() => _price = value),
          ),
          Text(
            'Up to \$${_price.toStringAsFixed(0)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final size in const <String>['S', 'M', 'L', 'XL'])
                AppChip(
                  label: size,
                  selected: _sizes.contains(size),
                  onTap: () => setState(() {
                    if (!_sizes.remove(size)) {
                      _sizes.add(size);
                    }
                  }),
                ),
            ],
          ),
          const SizedBox(height: 16),
          NextButton(
            variant: NextButtonVariant.outlined,
            margin: EdgeInsets.zero,
            onPressed: () => setState(() {
              _inStock = true;
              _onSale = false;
              _price = 320;
              _sizes
                ..clear()
                ..add('XL');
            }),
            child: const AppButtonLabel('Reset filters'),
          ),
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.products,
    required this.cart,
    required this.sort,
    required this.onToggle,
  });

  final List<DemoProduct> products;
  final Set<String> cart;
  final String sort;
  final ValueChanged<DemoProduct> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeading(
          title: 'Featured gear',
          subtitle: '${products.length} products',
          trailing: NextShow(
            from: Breakpoint.md,
            fallback: const SizedBox.shrink(),
            child: Text(
              'Sorted by ${sort.toLowerCase()}',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        NextGrid(
          span: const NextSpan(xs: 12, sm: 6, lg: 3),
          children: [
            for (final product in products)
              _ProductCard(
                product: product,
                added: cart.contains(product.name),
                onToggle: () => onToggle(product),
              ),
          ],
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.added,
    required this.onToggle,
  });

  final DemoProduct product;
  final bool added;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      onTap: onToggle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                AppArtwork(
                  icon: product.icon,
                  accent: product.accent,
                  height: 118,
                ),
                if (product.badge != null)
                  Positioned(
                    left: 10,
                    top: 10,
                    child: AppTag(label: product.badge!, color: product.accent),
                  ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    onPressed: onToggle,
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Save for later',
                    icon: Icon(
                      added ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: added
                          ? theme.colorScheme.error
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Color(0xFFE8A13B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating} · ${product.reviews}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(0)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (product.previousPrice != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '\$${product.previousPrice!.toStringAsFixed(0)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                NextButton(
                  margin: EdgeInsets.zero,
                  variant: added
                      ? NextButtonVariant.outlined
                      : NextButtonVariant.filled,
                  onPressed: onToggle,
                  child: AppButtonLabel(added ? 'In cart' : 'Add to cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentlyViewed extends StatelessWidget {
  const _RecentlyViewed();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeading(
          title: 'Recently viewed',
          subtitle: 'Picks from your last visit',
          trailing: AppChip(label: 'Clear', icon: Icons.close_rounded),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 124,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = kDemoProducts[index + 3];
              return SizedBox(
                width: 240,
                child: AppCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: SampleProductTile(
                    name: product.name,
                    price: '\$${product.price.toStringAsFixed(0)}',
                    icon: product.icon,
                    accent: product.accent,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// The storefront demo page.
class StorefrontPage extends StatelessWidget {
  /// Creates the storefront page.
  const StorefrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NextScope(
      containerMaxWidths: <Breakpoint, double?>{
        Breakpoint.sm: 640,
        Breakpoint.md: 900,
        Breakpoint.lg: 1440,
        Breakpoint.xl: 1600,
        Breakpoint.xxl: 1800,
      },
      child: StorefrontView(),
    );
  }
}
