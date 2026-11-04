import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import 'data/gallery_examples.dart';
import 'pages/home_page.dart';

void main() {
  DevicePreview.enable();
  runApp(const ShowcaseApp());
}

/// The gallery app.
class ShowcaseApp extends StatefulWidget {
  /// Creates the example app.
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ThemeMode _mode = ThemeMode.system;

  void _toggleTheme() {
    final platform =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final brightness = switch (_mode) {
      ThemeMode.dark => Brightness.dark,
      ThemeMode.light => Brightness.light,
      ThemeMode.system => platform,
    };
    setState(() {
      _mode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Next',
      debugShowCheckedModeBanner: false,
      themeMode: _mode,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: ShowcaseHome(onToggleTheme: _toggleTheme),
    );
  }
}

ThemeData _buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF5B5BD6),
    brightness: brightness,
  );
  final isLight = brightness == Brightness.light;
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    extensions: <ThemeExtension<dynamic>>[NextColors.fromScheme(scheme)],
    scaffoldBackgroundColor: isLight
        ? const Color(0xFFF3F4FA)
        : const Color(0xFF101018),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
    sliderTheme: SliderThemeData(
      activeTrackColor: scheme.primary,
      inactiveTrackColor: scheme.primary.withValues(alpha: 0.2),
      thumbColor: scheme.primary,
      overlayColor: scheme.primary.withValues(alpha: 0.12),
      trackHeight: 4,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
  );
}

/// The gallery shell.
///
/// A top bar holds the destinations. The page under it is full width, so the
/// examples are not squeezed beside a side panel.
class ShowcaseHome extends StatefulWidget {
  /// Creates the gallery shell.
  const ShowcaseHome({required this.onToggleTheme, super.key});

  /// Switches the app between light and dark.
  final VoidCallback onToggleTheme;

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome> {
  int _index = 0;
  NextScrollConfig _scroll = const NextScrollConfig.lenis();

  void _select(int index) {
    if (index != _index) {
      setState(() => _index = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = <String>[
      'Overview',
      for (final example in kGalleryExamples) example.label,
    ];
    final icons = <IconData>[
      Icons.auto_awesome_rounded,
      for (final example in kGalleryExamples) example.icon,
    ];
    final page = _index == 0
        ? HomePage(
            examples: kGalleryExamples,
            onOpen: (example) => _select(example + 1),
          )
        : kGalleryExamples[_index - 1].page;

    return NextScope(
      child: Scaffold(
        body: Column(
          children: [
            _GalleryBar(
              labels: labels,
              icons: icons,
              index: _index,
              onSelected: _select,
              onToggleTheme: widget.onToggleTheme,
              onOpenScrollSettings: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => _ScrollSettingsDialog(
                    initial: _scroll,
                    onChanged: (config) => setState(() => _scroll = config),
                  ),
                );
              },
            ),
            Expanded(
              child: NextSmoothScroll(
                key: ValueKey<int>(_index),
                config: _scroll,
                child: page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryBar extends StatelessWidget {
  const _GalleryBar({
    required this.labels,
    required this.icons,
    required this.index,
    required this.onSelected,
    required this.onToggleTheme,
    required this.onOpenScrollSettings,
  });

  final List<String> labels;
  final List<IconData> icons;
  final int index;
  final ValueChanged<int> onSelected;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenScrollSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final dark = theme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        boxShadow: NextShadow.shadow200(context),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 76,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const _BrandMark(),
                const SizedBox(width: 12),
                NextShow(
                  from: Breakpoint.sm,
                  child: Text(
                    'Flutter Next',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i = 0; i < labels.length; i++)
                          _NavChip(
                            icon: icons[i],
                            label: labels[i],
                            selected: i == index,
                            onTap: () => onSelected(i),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                if (DevicePreview.maybeController != null)
                  PopupMenuButton<_PreviewDevice>(
                    tooltip: 'Preview device',
                    icon: const Icon(Icons.phone_iphone_rounded),
                    onSelected: (device) {
                      final controller = DevicePreview.maybeController;
                      if (controller == null) {
                        return;
                      }
                      if (device.preset == null) {
                        unawaited(controller.reset());
                      } else {
                        unawaited(controller.applyPreset(device.preset!));
                      }
                    },
                    itemBuilder: (context) => [
                      for (final device in _previewDevices)
                        PopupMenuItem<_PreviewDevice>(
                          value: device,
                          child: Text(device.label),
                        ),
                    ],
                  ),
                IconButton(
                  tooltip: 'Scroll settings',
                  onPressed: onOpenScrollSettings,
                  icon: const Icon(Icons.tune_rounded),
                ),
                IconButton(
                  tooltip: 'Switch theme',
                  onPressed: onToggleTheme,
                  icon: Icon(
                    dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewDevice {
  const _PreviewDevice(this.label, this.preset);

  final String label;
  final DevicePreset? preset;
}

const List<_PreviewDevice> _previewDevices = <_PreviewDevice>[
  _PreviewDevice('iPhone 16', DevicePresets.iPhone16),
  _PreviewDevice('iPad Air 11"', DevicePresets.iPadAir11M2),
  _PreviewDevice('Desktop window', DevicePresets.largeDesktopWindow),
  _PreviewDevice('This window', null),
];

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[scheme.primary, scheme.tertiary],
        ),
        boxShadow: NextShadow.shadow300(context, color: scheme.primary),
      ),
      child: Icon(Icons.bolt_rounded, size: 22, color: scheme.onPrimary),
    );
  }
}

class _NavChip extends StatelessWidget {
  const _NavChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = selected ? scheme.onPrimary : scheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Semantics(
        button: true,
        selected: selected,
        child: Material(
          color: selected
              ? scheme.primary
              : scheme.surfaceContainerHighest.withValues(alpha: 0.7),
          borderRadius: const BorderRadius.all(Radius.circular(999)),
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18, color: foreground),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foreground,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Live wheel tuning for the gallery. Changes apply to the open page.
class _ScrollSettingsDialog extends StatefulWidget {
  const _ScrollSettingsDialog({required this.initial, required this.onChanged});

  final NextScrollConfig initial;
  final ValueChanged<NextScrollConfig> onChanged;

  @override
  State<_ScrollSettingsDialog> createState() => _ScrollSettingsDialogState();
}

class _ScrollSettingsDialogState extends State<_ScrollSettingsDialog> {
  late NextScrollKind _kind = widget.initial.kind;
  late double _speed = widget.initial.scrollSpeed;
  late double _damping = widget.initial.damping;
  late double _durationMs = widget.initial.duration.inMilliseconds.toDouble();
  late double _stiffness = widget.initial.stiffness;
  late double _springDamping = widget.initial.springDamping;

  void _emit() {
    final config = switch (_kind) {
      NextScrollKind.lenis => NextScrollConfig.lenis(
        scrollSpeed: _speed,
        damping: _damping,
      ),
      NextScrollKind.linear => NextScrollConfig.linear(
        scrollSpeed: _speed,
        duration: Duration(milliseconds: _durationMs.round()),
      ),
      NextScrollKind.elastic => NextScrollConfig.elastic(
        scrollSpeed: _speed,
        stiffness: _stiffness,
        springDamping: _springDamping,
      ),
      NextScrollKind.direct => NextScrollConfig.direct(scrollSpeed: _speed),
    };
    widget.onChanged(config);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Scroll',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              Text(
                'How a mouse-wheel notch catches up. Touch drags stay direct. '
                'Close this and scroll the page.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final kind in NextScrollKind.values)
                    ChoiceChip(
                      label: Text(_kindName(kind)),
                      selected: kind == _kind,
                      onSelected: (_) {
                        setState(() => _kind = kind);
                        _emit();
                      },
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _kindHelp(_kind),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              _SliderRow(
                label: 'Speed',
                valueLabel: _speed.toStringAsFixed(1),
                min: 0.5,
                max: 2.5,
                divisions: 20,
                value: _speed,
                onChanged: (value) {
                  setState(() => _speed = value);
                  _emit();
                },
              ),
              if (_kind == NextScrollKind.lenis)
                _SliderRow(
                  label: 'Damping',
                  valueLabel: _damping.toStringAsFixed(2),
                  min: 0.02,
                  max: 1,
                  divisions: 49,
                  value: _damping,
                  onChanged: (value) {
                    setState(() => _damping = value);
                    _emit();
                  },
                ),
              if (_kind == NextScrollKind.linear)
                _SliderRow(
                  label: 'Duration',
                  valueLabel: '${_durationMs.round()} ms',
                  min: 80,
                  max: 800,
                  divisions: 36,
                  value: _durationMs.clamp(80, 800),
                  onChanged: (value) {
                    setState(() => _durationMs = value);
                    _emit();
                  },
                ),
              if (_kind == NextScrollKind.elastic) ...[
                _SliderRow(
                  label: 'Stiffness',
                  valueLabel: _stiffness.round().toString(),
                  min: 40,
                  max: 240,
                  divisions: 20,
                  value: _stiffness.clamp(40, 240),
                  onChanged: (value) {
                    setState(() => _stiffness = value);
                    _emit();
                  },
                ),
                _SliderRow(
                  label: 'Spring damping',
                  valueLabel: _springDamping.toStringAsFixed(0),
                  min: 4,
                  max: 30,
                  divisions: 26,
                  value: _springDamping.clamp(4, 30),
                  onChanged: (value) {
                    setState(() => _springDamping = value);
                    _emit();
                  },
                ),
              ],
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _kind = NextScrollKind.lenis;
                      _speed = 1.2;
                      _damping = 0.08;
                      _durationMs = 300;
                      _stiffness = 100;
                      _springDamping = 10;
                    });
                    _emit();
                  },
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.valueLabel,
    required this.min,
    required this.max,
    required this.divisions,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String valueLabel;
  final double min;
  final double max;
  final int divisions;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: theme.textTheme.labelLarge)),
            Text(valueLabel, style: theme.textTheme.labelLarge),
          ],
        ),
        Slider(
          min: min,
          max: max,
          divisions: divisions,
          value: value,
          label: valueLabel,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

String _kindName(NextScrollKind kind) {
  return switch (kind) {
    NextScrollKind.lenis => 'Lenis',
    NextScrollKind.linear => 'Linear',
    NextScrollKind.elastic => 'Elastic',
    NextScrollKind.direct => 'Direct',
  };
}

String _kindHelp(NextScrollKind kind) {
  return switch (kind) {
    NextScrollKind.lenis => 'Eases with decay. Lower damping feels heavier.',
    NextScrollKind.linear => 'Closes the gap over the duration.',
    NextScrollKind.elastic => 'Springs toward the target.',
    NextScrollKind.direct => 'Applies the notch on the same frame.',
  };
}
