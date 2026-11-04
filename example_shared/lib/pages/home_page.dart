import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../data/gallery_examples.dart';
import '../widgets/app/app_card.dart';
import '../widgets/app/app_space.dart';
import '../widgets/app/app_text.dart';
import '../widgets/app/device_frame.dart';

/// The gallery overview.
///
/// A full introduction, a live device frame whose width you drag, the theme
/// and shadow scale, then the apps. Every block is [NextContainer], [NextGrid],
/// [NextSurface], or [NextShadow], so it follows the parent width.
class HomePage extends StatelessWidget {
  /// Creates the overview.
  const HomePage({required this.examples, required this.onOpen, super.key});

  /// Apps opened from the grid.
  final List<GalleryExample> examples;

  /// Called with the index of the app to open.
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final gap = context.gap;
    return SingleChildScrollView(
      child: NextContainer(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        padding: context.pagePadding,
        children: <Widget>[
          _Intro(examples: examples, onOpen: onOpen),
          SizedBox(height: gap * 2.4),
          const _ReflowStage(),
          SizedBox(height: gap * 2.4),
          const _SystemSection(),
          SizedBox(height: gap * 2.4),
          _ExamplesSection(examples: examples, onOpen: onOpen),
        ],
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.examples, required this.onOpen});

  final List<GalleryExample> examples;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final metrics = NextMetrics.of(context);
    final pad = const NextValue<double>(
      xs: 22,
      md: 44,
      lg: 60,
    ).resolve(context);
    final titleSize = const NextValue<double>(
      xs: 42,
      sm: 54,
      md: 68,
      lg: 80,
    ).resolve(context);
    final devices = examples.indexWhere(
      (example) => example.label == 'Devices',
    );
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.radius + 12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF241F66),
            scheme.primary,
            scheme.tertiary,
          ],
        ),
        boxShadow: NextShadow.shadow700(context, color: scheme.primary),
      ),
      child: Stack(
        children: <Widget>[
          const Positioned(right: -12, bottom: -36, child: _Watermark()),
          Positioned(
            right: 48,
            top: -50,
            child: _Orb(color: Colors.white.withValues(alpha: 0.14), size: 180),
          ),
          Positioned(
            left: -40,
            bottom: 40,
            child: _Orb(
              color: scheme.tertiary.withValues(alpha: 0.45),
              size: 140,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(pad),
            child: NextStagger(
              motion: NextMotion.fadeIn(
                NextFadeIn.fadeInUp,
                duration: const Duration(milliseconds: 640),
                distance: 32,
              ),
              step: const Duration(milliseconds: 80),
              children: <Widget>[
                _GlassChip(
                  label:
                      'This page · ${metrics.breakpoint.name} · '
                      '${metrics.width.round()} px',
                ),
                SizedBox(height: context.gap),
                Text(
                  'The frame changes.',
                  style: context.h1.copyWith(
                    color: Colors.white,
                    fontSize: titleSize,
                    height: 0.96,
                    letterSpacing: -1.8,
                  ),
                ),
                Text(
                  'The tree does not.',
                  style: context.h1.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: titleSize,
                    height: 0.96,
                    letterSpacing: -1.8,
                  ),
                ),
                SizedBox(height: context.gap),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Text(
                    'A column reads the width it is given. Drop the same '
                    'widget tree in a phone, a side pane, or a desktop and '
                    'the spans, the type, and the pieces you show all follow. '
                    'Theme, shadow, and motion ride along.',
                    style: context.body.copyWith(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: const NextValue<double>(
                        xs: 16,
                        md: 18,
                      ).resolve(context),
                      height: 1.55,
                    ),
                  ),
                ),
                SizedBox(height: context.gap * 1.4),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    NextButton(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      elevation: 1,
                      hoverElevation: 8,
                      onPressed: () => onOpen(0),
                      child: const Text('Open storefront'),
                    ),
                    if (devices >= 0)
                      NextButton(
                        margin: EdgeInsets.zero,
                        variant: NextButtonVariant.outlined,
                        outlineColor: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(999),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        onPressed: () => onOpen(devices),
                        child: const Text('Three devices'),
                      ),
                  ],
                ),
                SizedBox(height: context.gap * 1.6),
                const _StatRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Watermark extends StatelessWidget {
  const _Watermark();

  @override
  Widget build(BuildContext context) {
    final size = const NextValue<double>(
      xs: 120,
      md: 180,
      lg: 220,
    ).resolve(context);
    return Text(
      'NEXT',
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w900,
        height: 0.8,
        letterSpacing: -4,
        color: Colors.white.withValues(alpha: 0.08),
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: const BorderRadius.all(Radius.circular(999)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
        ),
        child: Text(
          label,
          style: context.caption.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow();

  @override
  Widget build(BuildContext context) {
    const stats = <(String, String)>[
      ('12', 'Columns in the grid'),
      ('6', 'Breakpoints, mobile first'),
      ('1', 'Motion spec for an entrance'),
    ];
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        for (final stat in stats) _Stat(value: stat.$1, label: stat.$2),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 260),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: context.h1.copyWith(color: Colors.white, fontSize: 32),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppText(
                context,
              ).bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.8)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReflowStage extends StatefulWidget {
  const _ReflowStage();

  @override
  State<_ReflowStage> createState() => _ReflowStageState();
}

class _ReflowStageState extends State<_ReflowStage> {
  static const _classes = 'col-12 col-md-6 col-lg-4';

  double _width = 400;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final gap = context.gap;
    final active = breakpointForWidth(_width);
    final tracks = NextSpan.parse(_classes).resolve();
    final controls = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Drag the parent.', style: context.h2),
        const SizedBox(height: 10),
        Text(
          'The page around this frame follows the window. The notes app '
          'inside the frame follows the frame. Same NextGrid either way.',
          style: context.body.copyWith(color: scheme.onSurfaceVariant),
        ),
        SizedBox(height: gap),
        NextAlert(
          variant: NextVariant.info,
          dismissible: false,
          showIcon: true,
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(18),
          title: const Text('Span inspector'),
          child: const Text(
            'The cards use the classes below. The highlighted chip is the '
            'breakpoint of the frame, not the window.',
          ),
        ),
        SizedBox(height: gap),
        Text(_classes, style: context.code.copyWith(fontSize: 14)),
        const SizedBox(height: 8),
        Slider(
          min: 320,
          max: 1100,
          divisions: 39,
          value: _width,
          label: '${_width.round()} px',
          onChanged: (value) => setState(() => _width = value),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final entry in tracks.entries)
              AppChip(
                label: '${entry.key.name} · ${entry.value} of 12',
                selected: entry.key == active,
                icon: Icons.grid_on_rounded,
              ),
          ],
        ),
      ],
    );
    final frame = SizedBox(
      height: 700,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DeviceFrame(
          width: _width,
          height: 640,
          label: '${_width.round()} px · ${active.name}',
          child: const _NotesApp(),
        ),
      ),
    );
    return NextRow(
      gutter: gap,
      children: <NextCol>[
        NextCol(span: const NextSpan(xs: 12, lg: 5), child: controls),
        NextCol(span: const NextSpan(xs: 12, lg: 7), child: frame),
      ],
    );
  }
}

class _Note {
  const _Note(this.icon, this.title, this.body, this.variant);

  final IconData icon;
  final String title;
  final String body;
  final NextVariant variant;
}

const List<_Note> _notes = <_Note>[
  _Note(
    Icons.straighten_rounded,
    'Parent width',
    'The column measures the frame it sits in.',
    NextVariant.primary,
  ),
  _Note(
    Icons.grid_view_rounded,
    'Twelve tracks',
    'A set span carries up to every wider breakpoint.',
    NextVariant.info,
  ),
  _Note(
    Icons.visibility_outlined,
    'Show and hide',
    'NextShow keeps one tree and swaps the pieces.',
    NextVariant.success,
  ),
  _Note(
    Icons.palette_outlined,
    'Theme colors',
    'NextColors is taken from the ColorScheme.',
    NextVariant.warning,
  ),
  _Note(
    Icons.layers_outlined,
    'Shadows',
    'NextShadow follows the scheme, dark mode included.',
    NextVariant.secondary,
  ),
  _Note(
    Icons.animation_rounded,
    'One motion',
    'NextMotion plays the fade, the slide, and the delay.',
    NextVariant.danger,
  ),
];

class _NotesApp extends StatelessWidget {
  const _NotesApp();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        primary: false,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[scheme.primary, scheme.tertiary],
                  ),
                ),
                child: Icon(Icons.bolt_rounded, color: scheme.onPrimary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Field notes', style: context.h3),
                    Text(
                      'Six cards. One span.',
                      style: context.caption.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          NextGrid(
            span: NextSpan.parse(_ReflowStageState._classes),
            gutter: 16,
            children: <Widget>[
              for (final note in _notes) _NoteCard(note: note),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note});

  final _Note note;

  @override
  Widget build(BuildContext context) {
    final colors = NextColors.of(context).setFor(note.variant);
    return NextSurface(
      variant: note.variant,
      elevation: 200,
      liftOnHover: false,
      padding: const EdgeInsets.all(16),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(note.icon, color: colors.foreground),
          const SizedBox(height: 12),
          Text(note.title, style: context.h3),
          const SizedBox(height: 6),
          Text(note.body, style: AppText(context).bodySmall),
        ],
      ),
    );
  }
}

class _SystemSection extends StatelessWidget {
  const _SystemSection();

  static const _variants = <NextVariant>[
    NextVariant.primary,
    NextVariant.secondary,
    NextVariant.success,
    NextVariant.warning,
    NextVariant.danger,
    NextVariant.info,
  ];

  static const _levels = <int>[200, 400, 600, 800];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final gap = context.gap;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Theme and shadow, from one scheme.', style: context.h2),
        const SizedBox(height: 10),
        Text(
          'Switch the theme in the bar. Surfaces, buttons, and shadows '
          'read NextColors and NextShadow, so light and dark stay in step.',
          style: context.body.copyWith(color: scheme.onSurfaceVariant),
        ),
        SizedBox(height: gap * 1.4),
        NextGrid(
          span: const NextSpan(xs: 12, md: 6, xl: 4),
          gutter: gap,
          children: <Widget>[
            for (final variant in _variants)
              NextSurface(
                variant: variant,
                elevation: 300,
                padding: EdgeInsets.all(context.cardPadding),
                borderRadius: context.cardRadius,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(variant.name.capitalize(), style: context.h3),
                    const SizedBox(height: 8),
                    Text(
                      'NextSurface · ${variant.name}',
                      style: AppText(context).bodySmall,
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: gap * 1.8),
        NextGrid(
          span: const NextSpan(xs: 12, md: 6, xl: 3),
          gutter: gap,
          children: <Widget>[
            for (final level in _levels) _ShadowCard(level: level),
          ],
        ),
        SizedBox(height: gap * 1.8),
        AppCard(
          elevation: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('A screen is a row of columns.', style: context.h3),
              const SizedBox(height: 8),
              Text(
                'Checkout is this tree, plus the fields. On a phone the '
                'summary moves above the form because both spans are 12 '
                'until lg.',
                style: context.body.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 18),
              Text(
                'NextRow(\n'
                '  children: [\n'
                '    NextCol(span: NextSpan(xs: 12, lg: 7), child: form),\n'
                '    NextCol(span: NextSpan(xs: 12, lg: 5), child: summary),\n'
                '  ],\n'
                ')',
                style: context.code.copyWith(height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShadowCard extends StatelessWidget {
  const _ShadowCard({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.cardPadding),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: context.cardRadius,
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: NextShadow.level(context, level),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 88,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[scheme.primary, scheme.tertiary],
              ),
              boxShadow: NextShadow.level(
                context,
                level,
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text('Level $level', style: context.h3),
          const SizedBox(height: 6),
          Text(
            'NextShadow.level(context, $level)',
            style: context.caption.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _ExamplesSection extends StatelessWidget {
  const _ExamplesSection({required this.examples, required this.onOpen});

  final List<GalleryExample> examples;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Five apps. Same kit.', style: context.h2),
        const SizedBox(height: 10),
        Text(
          'Open any tile. The screen you get is a normal widget tree: a top '
          'bar, a grid, and the pieces that appear when the parent is wide '
          'enough.',
          style: context.body.copyWith(color: scheme.onSurfaceVariant),
        ),
        SizedBox(height: context.gap * 1.4),
        NextGrid(
          span: const NextSpan(xs: 12, md: 6, xl: 4),
          gutter: context.gap,
          children: <Widget>[
            for (var i = 0; i < examples.length; i++)
              NextMotionView(
                motion: NextMotion.fadeIn(
                  NextFadeIn.fadeInUp,
                  duration: const Duration(milliseconds: 480),
                  delay: Duration(milliseconds: 60 * i),
                ),
                child: _ExampleTile(
                  example: examples[i],
                  onTap: () => onOpen(i),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _ExampleTile extends StatelessWidget {
  const _ExampleTile({required this.example, required this.onTap});

  final GalleryExample example;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = NextColors.of(context).setFor(example.variant);
    return NextSurface(
      onTap: onTap,
      variant: example.variant,
      elevation: 300,
      borderRadius: context.cardRadius,
      padding: EdgeInsets.all(context.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.45),
                  ),
                ),
                child: Icon(example.icon, size: 24, color: colors.border),
              ),
              const Spacer(),
              _TagPill(label: example.tag, color: colors.border),
            ],
          ),
          SizedBox(height: context.gap),
          Text(example.label, style: context.h3),
          const SizedBox(height: 8),
          Text(
            example.blurb,
            style: AppText(
              context,
            ).bodySmall.copyWith(color: scheme.onSurfaceVariant),
          ),
          SizedBox(height: context.gap),
          Row(
            children: <Widget>[
              Text(
                'Open example',
                style: context.label.copyWith(color: colors.border),
              ),
              const SizedBox(width: 6),
              Icon(Icons.arrow_forward_rounded, size: 16, color: colors.border),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: Text(
        label,
        style: context.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
