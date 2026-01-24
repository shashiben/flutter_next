import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';
import 'package:go_router/go_router.dart';

/// Bootstrap-style grid examples page - full screen with all examples
class GridExamplesPage extends StatelessWidget {
  const GridExamplesPage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bootstrap grid examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/playground'),
        ),
      ),
      body: SingleChildScrollView(
        child: NextContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          children: [
            // Header
            Text(
              'Bootstrap grid examples',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Basic grid layouts to get you familiar with building within the Bootstrap grid system.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'In these examples the `.themed-grid-col` class is added to the columns to add some theming. This is not a class that is available in Bootstrap by default.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 48),

            // Five Grid Tiers
            _buildSectionTitle(context, 'Five Grid Tiers'),
            const SizedBox(height: 8),
            Text(
              'There are five tiers to the Bootstrap grid system, one for each range of devices we support. Each tier starts at a minimum viewport size and automatically applies to the larger devices unless overridden.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            _buildGridTier(context, 'col-4', 'Extra small devices'),
            const SizedBox(height: 16),
            _buildGridTier(context, 'col-sm-4', 'Small devices (≥576px)'),
            const SizedBox(height: 16),
            _buildGridTier(context, 'col-md-4', 'Medium devices (≥768px)'),
            const SizedBox(height: 16),
            _buildGridTier(context, 'col-lg-4', 'Large devices (≥992px)'),
            const SizedBox(height: 16),
            _buildGridTier(
                context, 'col-xl-4', 'Extra large devices (≥1200px)'),
            const SizedBox(height: 16),
            _buildGridTier(context, 'col-xxl-4', 'XXL devices (≥1400px)'),
            const SizedBox(height: 48),

            // Three Equal Columns
            _buildSectionTitle(context, 'Three Equal Columns'),
            const SizedBox(height: 8),
            Text(
              'Get three equal-width columns starting at desktops and scaling to large desktops. On mobile devices, tablets and below, the columns will automatically stack.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-md-4',
                  child: const _ThemedGridCol(text: '.col-md-4'),
                ),
                NextCol(
                  sizes: 'col-md-4',
                  child: const _ThemedGridCol(text: '.col-md-4'),
                ),
                NextCol(
                  sizes: 'col-md-4',
                  child: const _ThemedGridCol(text: '.col-md-4'),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Three Unequal Columns
            _buildSectionTitle(context, 'Three Unequal Columns'),
            const SizedBox(height: 8),
            Text(
              'Get three columns starting at desktops and scaling to large desktops of various widths. Remember, grid columns should add up to twelve for a single horizontal block. More than that, and columns start stacking no matter the viewport.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-md-3',
                  child: const _ThemedGridCol(text: '.col-md-3'),
                ),
                NextCol(
                  sizes: 'col-md-6',
                  child: const _ThemedGridCol(text: '.col-md-6'),
                ),
                NextCol(
                  sizes: 'col-md-3',
                  child: const _ThemedGridCol(text: '.col-md-3'),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Two Columns
            _buildSectionTitle(context, 'Two Columns'),
            const SizedBox(height: 8),
            Text(
              'Get two columns starting at desktops and scaling to large desktops.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-md-8',
                  child: const _ThemedGridCol(text: '.col-md-8'),
                ),
                NextCol(
                  sizes: 'col-md-4',
                  child: const _ThemedGridCol(text: '.col-md-4'),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Full Width
            _buildSectionTitle(context, 'Full Width, Single Column'),
            const SizedBox(height: 8),
            Text(
              'No grid classes are necessary for full-width elements.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            const _ThemedGridCol(text: 'Full width column'),
            const SizedBox(height: 48),

            // Nested Columns
            _buildSectionTitle(context, 'Two Columns with Two Nested Columns'),
            const SizedBox(height: 8),
            Text(
              'Per the documentation, nesting is easy—just put a row of columns within an existing column. This gives you two columns starting at desktops and scaling to large desktops, with another two (equal widths) within the larger column.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'At mobile device sizes, tablets and down, these columns and their nested columns will stack.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-md-8',
                  child: Column(
                    children: [
                      const _ThemedGridCol(text: '.col-md-8'),
                      const SizedBox(height: 16),
                      NextRow(
                        children: [
                          NextCol(
                            sizes: 'col-md-6',
                            child: const _ThemedGridCol(text: '.col-md-6'),
                          ),
                          NextCol(
                            sizes: 'col-md-6',
                            child: const _ThemedGridCol(text: '.col-md-6'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                NextCol(
                  sizes: 'col-md-4',
                  child: const _ThemedGridCol(text: '.col-md-4'),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Mixed Mobile & Desktop
            _buildSectionTitle(context, 'Mixed: Mobile and Desktop'),
            const SizedBox(height: 8),
            Text(
              'The Bootstrap v5 grid system has six tiers of classes: xs (extra small, this class infix is not used), sm (small), md (medium), lg (large), xl (x-large), and xxl (xx-large). You can use nearly any combination of these classes to create more dynamic and flexible layouts.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Each tier of classes scales up, meaning if you plan on setting the same widths for md, lg, xl and xxl, you only need to specify md.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-md-8',
                  child: const _ThemedGridCol(text: '.col-md-8'),
                ),
                NextCol(
                  sizes: 'col-6 col-md-4',
                  child: const _ThemedGridCol(text: '.col-6 .col-md-4'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-6 col-md-4',
                  child: const _ThemedGridCol(text: '.col-6 .col-md-4'),
                ),
                NextCol(
                  sizes: 'col-6 col-md-4',
                  child: const _ThemedGridCol(text: '.col-6 .col-md-4'),
                ),
                NextCol(
                  sizes: 'col-6 col-md-4',
                  child: const _ThemedGridCol(text: '.col-6 .col-md-4'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            NextRow(
              children: [
                NextCol(
                  sizes: 'col-6',
                  child: const _ThemedGridCol(text: '.col-6'),
                ),
                NextCol(
                  sizes: 'col-6',
                  child: const _ThemedGridCol(text: '.col-6'),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Gutters
            _buildSectionTitle(context, 'Gutters'),
            const SizedBox(height: 8),
            Text(
              'With `.gx-*` classes, the horizontal gutters can be adjusted.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            _buildGutterExample(
              context,
              '`.col` with `.gx-4` gutters',
              horizontalSpacing: 16,
            ),
            const SizedBox(height: 16),
            Text(
              'Use the `.gy-*` classes to control the vertical gutters.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            _buildGutterExample(
              context,
              '`.col` with `.gy-4` gutters',
              verticalSpacing: 16,
            ),
            const SizedBox(height: 16),
            Text(
              'With `.g-*` classes, the gutters in both directions can be adjusted.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            _buildGutterExample(
              context,
              '`.col` with `.g-3` gutters',
              horizontalSpacing: 12,
              verticalSpacing: 12,
            ),
            const SizedBox(height: 48),

            // Containers
            _buildSectionTitle(context, 'Containers'),
            const SizedBox(height: 8),
            Text(
              'Additional classes added in Bootstrap v4.4 allow containers that are 100% wide until a particular breakpoint. v5 adds a new `xxl` breakpoint.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            _buildContainerExample(context, '.container'),
            const SizedBox(height: 16),
            _buildContainerExample(context, '.container-sm',
                minBreakpoint: Breakpoint.sm),
            const SizedBox(height: 16),
            _buildContainerExample(context, '.container-md',
                minBreakpoint: Breakpoint.md),
            const SizedBox(height: 16),
            _buildContainerExample(context, '.container-lg',
                minBreakpoint: Breakpoint.lg),
            const SizedBox(height: 16),
            _buildContainerExample(context, '.container-xl',
                minBreakpoint: Breakpoint.xl),
            const SizedBox(height: 16),
            _buildContainerExample(context, '.container-xxl',
                minBreakpoint: Breakpoint.xxl),
            const SizedBox(height: 16),
            _buildContainerExample(context, '.container-fluid', fluid: true),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildGridTier(BuildContext context, String sizes, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        NextRow(
          children: [
            NextCol(
              sizes: sizes,
              child: const _ThemedGridCol(text: '.col-4'),
            ),
            NextCol(
              sizes: sizes,
              child: const _ThemedGridCol(text: '.col-4'),
            ),
            NextCol(
              sizes: sizes,
              child: const _ThemedGridCol(text: '.col-4'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGutterExample(
    BuildContext context,
    String title, {
    double? horizontalSpacing,
    double? verticalSpacing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (horizontalSpacing ?? 0) / 2,
          ),
          child: NextRow(
            children: List.generate(
              6,
              (index) => NextCol(
                sizes: 'col-md-4',
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (horizontalSpacing ?? 0) / 2,
                    vertical: (verticalSpacing ?? 0) / 2,
                  ),
                  child: const _ThemedGridCol(
                    text: '.col with gutters',
                    height: 80,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainerExample(
    BuildContext context,
    String label, {
    bool? fluid,
    Breakpoint? minBreakpoint,
  }) {
    return NextContainer(
      fluid: fluid ?? false,
      minBreakpoint: minBreakpoint,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Helper widget for themed grid columns
class _ThemedGridCol extends StatelessWidget {
  const _ThemedGridCol({
    required this.text,
    this.height = 60,
  });

  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
