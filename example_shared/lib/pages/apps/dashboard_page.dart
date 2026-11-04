import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../../data/demo_data.dart';
import '../../widgets/app/app_card.dart';
import '../../widgets/app/app_nav_rail.dart';
import '../../widgets/app/app_space.dart';
import '../../widgets/app/app_top_bar.dart';
import '../../widgets/app/demo_avatars.dart';

/// An analytics dashboard built with the layout kit.
///
/// The rail collapses to icons on tablets, the KPI grid reflows, and the
/// chart and feed share the row once the parent is wide enough.
class DashboardView extends StatefulWidget {
  /// Creates the dashboard.
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  static const _navItems = <AppNavItem>[
    AppNavItem(icon: Icons.space_dashboard_outlined, label: 'Overview'),
    AppNavItem(icon: Icons.show_chart, label: 'Analytics'),
    AppNavItem(icon: Icons.receipt_long_outlined, label: 'Orders'),
    AppNavItem(icon: Icons.people_outline, label: 'Customers'),
    AppNavItem(icon: Icons.local_shipping_outlined, label: 'Shipping'),
  ];

  static const _ranges = <String>['7 days', '30 days', '90 days'];

  int _selected = 0;
  int _range = 1;
  bool _loading = false;

  void _refresh() {
    setState(() => _loading = true);
    unawaited(
      Future<void>.delayed(const Duration(milliseconds: 900), () {
        if (mounted) {
          setState(() => _loading = false);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = context.gap;
    return Column(
      children: [
        AppTopBar(
          brand: 'Pulse Analytics',
          subtitle: 'Revenue and retention',
          actions: [
            IconButton(
              onPressed: _refresh,
              tooltip: 'Refresh',
              icon: const Icon(Icons.refresh_rounded),
            ),
            const SizedBox(width: 4),
            NextShow(
              from: Breakpoint.sm,
              fallback: const SizedBox.shrink(),
              child: NextAvatarGroup(
                avatarImages: kDemoAvatars,
                displayLimit: 3,
                outerRadius: 16,
                innerRadius: 13,
              ),
            ),
            const SizedBox(width: 12),
            const AppAvatar(initials: 'AR'),
          ],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NextShow(
                from: Breakpoint.md,
                fallback: const SizedBox.shrink(),
                child: AppNavRail(
                  items: _navItems,
                  selectedIndex: _selected,
                  onSelected: (index) => setState(() => _selected = index),
                  compact: context.isTablet,
                  header: NextShow(
                    from: Breakpoint.lg,
                    fallback: const SizedBox.shrink(),
                    child: Text(
                      'Workspace',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  footer: context.isTablet ? null : const _TeamCard(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: NextContainer(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    padding: context.pagePadding,
                    children: [
                      PageHeading(
                        title: 'Overview',
                        subtitle: 'Last $_rangeLabel · updated a minute ago',
                        trailing: context.isPhone ? null : _rangeControl,
                        below: context.isPhone ? _rangeControl : null,
                      ),
                      SizedBox(height: gap),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        child: _loading
                            ? const _MetricSkeleton(
                                key: ValueKey<String>('skeleton'),
                              )
                            : NextGrid(
                                key: const ValueKey<String>('metrics'),
                                span: const NextSpan(xs: 12, sm: 6, lg: 3),
                                children: [
                                  for (final metric in kDemoMetrics)
                                    _MetricTile(metric: metric),
                                ],
                              ),
                      ),
                      SizedBox(height: gap),
                      NextRow(
                        gutter: gap,
                        children: [
                          NextCol(
                            span: const NextSpan(sm: 12, md: 8),
                            child: _RevenueChart(
                              loading: _loading,
                              range: _range,
                            ),
                          ),
                          const NextCol(
                            span: NextSpan(sm: 12, md: 4),
                            child: _ActivityFeed(),
                          ),
                        ],
                      ),
                      SizedBox(height: gap),
                      NextRow(
                        gutter: gap,
                        children: [
                          const NextCol(
                            span: NextSpan(sm: 12, lg: 7),
                            child: _TopProducts(),
                          ),
                          const NextCol(
                            span: NextSpan(sm: 12, lg: 5),
                            child: _GoalsCard(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String get _rangeLabel => _ranges[_range];

  Widget get _rangeControl => SegmentedButton<int>(
    segments: [
      for (var i = 0; i < _ranges.length; i++)
        ButtonSegment<int>(value: i, label: Text(_ranges[i])),
    ],
    selected: <int>{_range},
    showSelectedIcon: false,
    onSelectionChanged: (value) => setState(() => _range = value.first),
  );
}

class _TeamCard extends StatelessWidget {
  const _TeamCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(12),
      elevation: 100,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 170;
          return Row(
            children: [
              const AppAvatar(initials: 'AR', radius: 16),
              if (!compact) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ana Ruiz',
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Store admin',
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.metric});

  final DemoMetric metric;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tone = metric.trend ? const Color(0xFF2D8F6F) : scheme.error;
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            metric.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            metric.value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                metric.trend
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
                size: 16,
                color: tone,
              ),
              const SizedBox(width: 4),
              Text(
                metric.delta,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: tone,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'vs last week',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _Sparkline(values: metric.spark, color: tone),
        ],
      ),
    );
  }
}

class _Sparkline extends StatelessWidget {
  const _Sparkline({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final peak = values.reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final value in values)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.5),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: peak == 0 ? 0 : value / peak,
                  ),
                  duration: const Duration(milliseconds: 420),
                  curve: Curves.easeOutCubic,
                  builder: (context, factor, _) => FractionallySizedBox(
                    heightFactor: factor,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.35),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricSkeleton extends StatelessWidget {
  const _MetricSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return NextGrid(
      span: const NextSpan(xs: 12, sm: 6, lg: 3),
      children: [
        for (var i = 0; i < 4; i++)
          AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _RevenueChart extends StatelessWidget {
  const _RevenueChart({required this.loading, required this.range});

  final bool loading;
  final int range;

  static const _series = <List<double>>[
    <double>[0.34, 0.46, 0.38, 0.55, 0.48, 0.62, 0.58],
    <double>[
      0.34,
      0.46,
      0.38,
      0.55,
      0.48,
      0.62,
      0.58,
      0.71,
      0.66,
      0.8,
      0.74,
      0.92,
    ],
    <double>[0.2, 0.3, 0.26, 0.38, 0.44, 0.52, 0.61, 0.72, 0.84, 0.95],
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bars = _series[range];
    final warm = range == 2;
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(
            title: 'Revenue',
            subtitle: 'Weekly, in thousands of dollars',
            trailing: AppTag(
              label: warm ? '+21.8%' : '+12.4%',
              color: const Color(0xFF2D8F6F),
              icon: Icons.trending_up_rounded,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 170,
            child: NextLoadingHelper(
              isLoading: loading,
              loadingWidget: const _ChartSkeleton(),
              child: NextColorTween(
                begin: scheme.primary,
                end: warm ? scheme.tertiary : scheme.primary,
                duration: const Duration(milliseconds: 500),
                builder: (context, animated) {
                  final color = animated ?? scheme.primary;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var i = 0; i < bars.length; i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0, end: bars[i]),
                                duration: Duration(milliseconds: 420 + i * 40),
                                curve: Curves.easeOutCubic,
                                builder: (context, factor, _) =>
                                    FractionallySizedBox(
                                      heightFactor: factor,
                                      widthFactor: 0.62,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(8),
                                              ),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: <Color>[
                                              color.withValues(alpha: 0.35),
                                              color,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final week in const <String>['W1', 'W3', 'W5', 'W7', 'W9'])
                Text(
                  week,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartSkeleton extends StatelessWidget {
  const _ChartSkeleton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < 12; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: FractionallySizedBox(
                heightFactor: 0.3 + (i % 4) * 0.15,
                widthFactor: 0.62,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActivityFeed extends StatelessWidget {
  const _ActivityFeed();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Activity',
            subtitle: 'What the team did today',
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < kDemoActivity.length; i++) ...[
            _ActivityRow(activity: kDemoActivity[i]),
            if (i != kDemoActivity.length - 1)
              Divider(color: scheme.outlineVariant, height: 20),
          ],
          const SizedBox(height: 4),
          Text(
            'View all activity',
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.activity});

  final DemoActivity activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAvatar(initials: activity.initials, radius: 16),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.name,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                activity.action,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          activity.time,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _TopProducts extends StatelessWidget {
  const _TopProducts();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Top products',
            subtitle: 'By revenue, last 30 days',
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < kDemoProducts.length && i < 4; i++) ...[
            _ProductRow(product: kDemoProducts[i], revenue: 4800 - (i * 830)),
            if (i < 3) Divider(color: scheme.outlineVariant, height: 24),
          ],
          const SizedBox(height: 8),
          Text(
            'Revenue is weighted to the top three products.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({required this.product, required this.revenue});

  final DemoProduct product;
  final double revenue;

  @override
  Widget build(BuildContext context) {
    return SampleProductTile(
      name: product.name,
      price: '\$${revenue.toStringAsFixed(0)}',
      icon: product.icon,
      accent: product.accent,
    );
  }
}

class _GoalsCard extends StatelessWidget {
  const _GoalsCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NextSurface(
      variant: NextVariant.primary,
      elevation: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Monthly goals',
            subtitle: 'On track for 3 of 4',
          ),
          const SizedBox(height: 18),
          for (final goal
              in const <({String label, double value, double total})>[
                (label: 'Revenue', value: 48920, total: 60000),
                (label: 'New customers', value: 318, total: 400),
                (label: 'Repeat orders', value: 142, total: 220),
                (label: 'Support score', value: 94, total: 100),
              ]) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal.label,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  '${(goal.value / goal.total * 100).round()}%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppProgress(
              value: goal.value,
              total: goal.total,
              color: theme.colorScheme.primary,
              height: 6,
            ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

/// The dashboard demo page.
class DashboardPage extends StatelessWidget {
  /// Creates the dashboard page.
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NextScope(
      containerMaxWidths: <Breakpoint, double?>{
        Breakpoint.sm: 640,
        Breakpoint.md: 1040,
        Breakpoint.lg: 1400,
        Breakpoint.xl: 1600,
        Breakpoint.xxl: 1800,
      },
      child: DashboardView(),
    );
  }
}
