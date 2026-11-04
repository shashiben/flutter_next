import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../../data/demo_data.dart';
import '../../widgets/app/app_card.dart';
import '../../widgets/app/app_space.dart';
import '../../widgets/app/app_text.dart';

/// A marketing landing page built with the layout kit.
///
/// The hero, feature grid, pricing tiers, and FAQ all collapse to one
/// column on phones without a second layout.
class LandingView extends StatelessWidget {
  /// Creates the landing page.
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final gap = context.gap;
    return SingleChildScrollView(
      child: NextContainer(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        padding: context.pagePadding,
        children: [
          const _Hero(),
          SizedBox(height: gap * 1.6),
          const _LogoStrip(),
          SizedBox(height: gap * 2),
          const _Features(),
          SizedBox(height: gap * 2),
          const _HowItWorks(),
          SizedBox(height: gap * 2),
          const _Pricing(),
          SizedBox(height: gap * 2),
          const _Faq(),
          SizedBox(height: gap * 2),
          const _Quotes(),
          SizedBox(height: gap * 2),
          const _CallToAction(),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final headlineSize = const NextValue<double>(
      xs: 28,
      md: 38,
      xl: 52,
    ).resolve(context);
    final copyWidth = const NextValue<double>(
      xs: 320,
      md: 460,
    ).resolve(context);
    final padding = const NextValue<double>(xs: 20, md: 36).resolve(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding * 1.4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.radius * 1.4),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary.withValues(alpha: 0.16),
            scheme.tertiary.withValues(alpha: 0.22),
          ],
        ),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: NextRow(
        gutter: context.gap,
        children: [
          NextCol(
            span: const NextSpan(lg: 7),
            child: NextStagger(
              motion: NextMotion.fadeIn(
                NextFadeIn.fadeInUp,
                duration: const Duration(milliseconds: 600),
              ),
              children: <Widget>[
                const AppTag(
                  label: 'New · Parent width breakpoints',
                  icon: Icons.auto_awesome_outlined,
                ),
                const SizedBox(height: 16),
                Text(
                  'Ship one layout to every screen',
                  style: context.h1.copyWith(fontSize: headlineSize),
                ),
                const SizedBox(height: 14),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: copyWidth),
                  child: Text(
                    'A column reads the width of its parent, so the same widget '
                    'tree works in a phone, a split pane, or a browser. '
                    'No media queries, no duplicate screens.',
                    style: context.body.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    NextButton(
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      onPressed: () {},
                      child: const AppButtonLabel('Start free trial'),
                    ),
                    NextButton(
                      margin: EdgeInsets.zero,
                      variant: NextButtonVariant.outlined,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      onPressed: () {},
                      child: const AppButtonLabel('Read the docs'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const NextCol(span: NextSpan(lg: 5), child: _HeroArtwork()),
        ],
      ),
    );
  }
}

class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return AppCard(
      elevation: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              for (final dot in const <Color>[
                Color(0xFFE05B5B),
                Color(0xFFE8A13B),
                Color(0xFF2D8F6F),
              ]) ...[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
              ],
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'checkout.dart',
                  overflow: TextOverflow.ellipsis,
                  style: context.caption,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _CodeLine(color: scheme.primary, text: 'NextRow(children: ['),
          _CodeLine(
            color: scheme.tertiary,
            text: '  NextCol(span: NextSpan(lg: 7), child: form),',
          ),
          _CodeLine(
            color: scheme.tertiary,
            text: '  NextCol(span: NextSpan(lg: 5), child: summary),',
          ),
          _CodeLine(color: scheme.primary, text: '])'),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppChip(
                label: 'lg · two columns',
                icon: Icons.check_circle_outline_rounded,
                selected: true,
              ),
              AppChip(label: 'xs · stacked', icon: Icons.check_circle_outline),
            ],
          ),
        ],
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.code.copyWith(color: color),
      ),
    );
  }
}

class _LogoStrip extends StatelessWidget {
  const _LogoStrip();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Trusted by teams that ship every week',
          textAlign: TextAlign.center,
          style: context.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: scheme.onSurfaceVariant,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 32,
          runSpacing: 12,
          children: [
            for (final name in const <String>[
              'KESTREL',
              'NORTHWIND',
              'ANCHOR',
              'MERIDIAN',
              'LUMEN',
            ])
              Text(
                name,
                style: context.label.copyWith(
                  color: scheme.onSurfaceVariant,
                  letterSpacing: 2,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Everything a layout needs',
          textAlign: TextAlign.center,
          style: context.h2,
        ),
        const SizedBox(height: 8),
        Text(
          'One cascade drives spans, spacing, visibility, and motion.',
          textAlign: TextAlign.center,
          style: context.body.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 24),
        NextGrid(
          span: const NextSpan(xs: 12, md: 6, lg: 4),
          children: [
            for (var i = 0; i < kDemoFeatures.length; i++)
              NextMotionView(
                motion: NextMotion.fadeIn(
                  NextFadeIn.fadeInUp,
                  duration: const Duration(milliseconds: 450),
                  delay: Duration(milliseconds: 70 * i),
                ),
                child: _FeatureCard(feature: kDemoFeatures[i]),
              ),
          ],
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final DemoFeature feature;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(feature.icon, size: 20, color: scheme.primary),
          ),
          const SizedBox(height: 14),
          Text(
            feature.title,
            style: context.label.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            feature.body,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _HowItWorks extends StatelessWidget {
  const _HowItWorks();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Three steps to one layout',
          textAlign: TextAlign.center,
          style: context.h2,
        ),
        const SizedBox(height: 24),
        NextRow(
          gutter: context.gap,
          children: [
            for (var i = 0; i < kDemoSteps.length; i++)
              NextCol(
                span: const NextSpan(xs: 12, md: 4),
                child: _StepCard(step: kDemoSteps[i], index: i),
              ),
          ],
        ),
        const SizedBox(height: 20),
        NextShow(
          from: Breakpoint.md,
          fallback: const SizedBox.shrink(),
          child: Center(
            child: AppChip(
              label: 'Same tree, every breakpoint',
              icon: Icons.all_inclusive_rounded,
              selected: true,
              accent: scheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step, required this.index});

  final DemoStep step;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppCard(
      elevation: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${index + 1}',
                  style: context.label.copyWith(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(step.icon, size: 20, color: scheme.primary),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            step.title,
            style: context.label.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            step.body,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _Pricing extends StatelessWidget {
  const _Pricing();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pricing that scales down too',
          textAlign: TextAlign.center,
          style: context.h2,
        ),
        const SizedBox(height: 8),
        Text(
          'Three plans. The same cards stack on a phone.',
          textAlign: TextAlign.center,
          style: context.body.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 24),
        NextRow(
          gutter: context.gap,
          children: [
            for (final plan in kDemoPlans)
              NextCol(
                span: const NextSpan(xs: 12, md: 4),
                child: _PlanCard(plan: plan),
              ),
          ],
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});

  final DemoPlan plan;

  @override
  Widget build(BuildContext context) {
    if (plan.highlighted) {
      return NextSurface(
        variant: NextVariant.primary,
        elevation: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    plan.name,
                    style: context.label.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                const AppTag(label: 'Most popular'),
              ],
            ),
            const SizedBox(height: 12),
            _Price(plan: plan),
            const SizedBox(height: 18),
            for (final feature in plan.features) ...[
              _FeatureLine(text: feature),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 14),
            NextButton(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(vertical: 14),
              onPressed: () {},
              child: AppButtonLabel('Choose ${plan.name}'),
            ),
          ],
        ),
      );
    }
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.name,
            style: context.label.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          _Price(plan: plan),
          const SizedBox(height: 18),
          for (final feature in plan.features) ...[
            _FeatureLine(text: feature),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 14),
          NextButton(
            margin: EdgeInsets.zero,
            variant: NextButtonVariant.outlined,
            padding: const EdgeInsets.symmetric(vertical: 14),
            onPressed: () {},
            child: AppButtonLabel('Choose ${plan.name}'),
          ),
        ],
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({required this.plan});

  final DemoPlan plan;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '\$${plan.price.toStringAsFixed(0)}',
          style: context.money.copyWith(
            fontWeight: FontWeight.w800,
            color: scheme.primary,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            plan.period,
            style: context.caption.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _FeatureLine extends StatelessWidget {
  const _FeatureLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_rounded, size: 18, color: scheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _Faq extends StatelessWidget {
  const _Faq();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Questions, answered',
          textAlign: TextAlign.center,
          style: context.h2,
        ),
        const SizedBox(height: 20),
        AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < kDemoFaqs.length; i++) ...[
                NextAccordion(
                  title: Text(kDemoFaqs[i].question, style: context.label),
                  children: <Widget>[
                    Text(
                      kDemoFaqs[i].answer,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                if (i != kDemoFaqs.length - 1)
                  Divider(color: scheme.outlineVariant, height: 20),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Quotes extends StatelessWidget {
  const _Quotes();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return NextGrid(
      span: const NextSpan(xs: 12, md: 6),
      children: [
        for (final quote in kDemoQuotes)
          AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.format_quote_rounded, color: scheme.primary),
                const SizedBox(height: 10),
                Text(
                  quote.quote,
                  style: context.body.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const AppAvatar(initials: 'AR'),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quote.name,
                            overflow: TextOverflow.ellipsis,
                            style: context.label.copyWith(
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            quote.role,
                            overflow: TextOverflow.ellipsis,
                            style: context.caption.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CallToAction extends StatelessWidget {
  const _CallToAction();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.radius * 1.2),
        color: scheme.primary,
      ),
      child: NextRow(
        gutter: context.gap,
        children: [
          NextCol(
            span: const NextSpan(lg: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start shipping one layout today',
                  style: context.h2.copyWith(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Free for one project. No card, no call.',
                  style: context.body.copyWith(
                    color: scheme.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          NextCol(
            span: const NextSpan(lg: 4),
            child: Align(
              alignment: Alignment.centerRight,
              child: NextButton(
                margin: EdgeInsets.zero,
                color: scheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
                onPressed: () {},
                child: const AppButtonLabel('Get started'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The landing demo page.
class LandingPage extends StatelessWidget {
  /// Creates the landing page.
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NextScope(
      containerMaxWidths: <Breakpoint, double?>{
        Breakpoint.sm: 640,
        Breakpoint.md: 900,
        Breakpoint.lg: 1200,
        Breakpoint.xl: 1400,
        Breakpoint.xxl: 1600,
      },
      child: LandingView(),
    );
  }
}
