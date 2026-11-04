import 'package:device_preview/presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../../widgets/app/app_card.dart';
import '../../widgets/app/app_space.dart';
import '../../widgets/app/device_frame.dart';
import 'checkout_page.dart';
import 'dashboard_page.dart';
import 'storefront_page.dart';

/// Shows one app rendered at three parent widths, and resolves the spans of
/// a Bootstrap class string.
class DevicesPage extends StatefulWidget {
  /// Creates the devices page.
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  int _app = 0;
  double _width = 390;
  String _classes = 'col-12 col-md-6 col-lg-4';
  String _tracks = 'offset-lg-2';

  Widget _preview() {
    switch (_app) {
      case 1:
        return const DashboardView();
      case 2:
        return const CheckoutView();
      default:
        return const StorefrontView();
    }
  }

  Widget get _appPicker => SegmentedButton<int>(
    segments: const <ButtonSegment<int>>[
      ButtonSegment<int>(value: 0, label: Text('Storefront')),
      ButtonSegment<int>(value: 1, label: Text('Dashboard')),
      ButtonSegment<int>(value: 2, label: Text('Checkout')),
    ],
    selected: <int>{_app},
    showSelectedIcon: false,
    onSelectionChanged: (value) => setState(() => _app = value.first),
  );

  String _label(double width) {
    return '${width.toStringAsFixed(0)}px · ${breakpointForWidth(width).name}';
  }

  String _presetLabel(DevicePreset preset) {
    final width = preset.portraitSize.width;
    return '${preset.name} · ${_label(width)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gap = context.gap;
    return ListView(
      padding: context.pagePadding,
      children: [
        PageHeading(
          title: 'One widget tree, three widths',
          subtitle:
              'Each frame holds the same app. Every frame measures its own '
              'width, so the layout follows the parent instead of the window.',
          trailing: context.isPhone ? null : _appPicker,
          below: context.isPhone ? _appPicker : null,
        ),
        SizedBox(height: gap),
        SizedBox(
          height: 748,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final preset in const <DevicePreset>[
                  DevicePresets.iPhone16,
                  DevicePresets.iPadAir11M2,
                  DevicePresets.largeDesktopWindow,
                ]) ...[
                  PresetFrame(
                    preset: preset,
                    height: 640,
                    label: _presetLabel(preset),
                    child: _preview(),
                  ),
                  if (preset != DevicePresets.largeDesktopWindow)
                    SizedBox(width: gap),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: gap),
        AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeading(
                title: 'Drag the width',
                subtitle:
                    'The frame below reads this width, so the layout follows '
                    'the parent instead of the window.',
                trailing: AppChip(
                  label: _label(_width),
                  selected: true,
                  icon: Icons.straighten_rounded,
                ),
              ),
              const SizedBox(height: 12),
              Slider(
                min: 320,
                max: 1200,
                divisions: 44,
                value: _width.clamp(320, 1200),
                label: _label(_width),
                onChanged: (value) => setState(() => _width = value),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 648,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DeviceFrame(
                    width: _width,
                    height: 600,
                    label: _label(_width),
                    child: _preview(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: gap),
        AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionHeading(
                title: 'Breakpoint map',
                subtitle: 'The minimum width of each breakpoint',
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final breakpoint in kBreakpoints)
                    AppChip(
                      label:
                          '${breakpoint.name} · ${defaultBreakpointWidths[breakpoint]!.toStringAsFixed(0)}+',
                      selected: breakpoint == breakpointForWidth(_width),
                      icon: Icons.crop_portrait_rounded,
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: gap),
        AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionHeading(
                title: 'Span inspector',
                subtitle:
                    'Paste Bootstrap classes and see the tracks each '
                    'breakpoint resolves to.',
              ),
              const SizedBox(height: 14),
              _InspectorField(
                label: 'Columns',
                value: _classes,
                hint: 'col-12 col-md-6 col-lg-4',
                onChanged: (value) => setState(() => _classes = value),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final entry in NextSpan.parse(
                    _classes,
                  ).resolve().entries)
                    AppChip(
                      label: '${entry.key.name} · ${entry.value} of 12',
                      selected: entry.key == breakpointForWidth(_width),
                      icon: Icons.grid_on_rounded,
                    ),
                ],
              ),
              const SizedBox(height: 18),
              _InspectorField(
                label: 'Offset and order',
                value: _tracks,
                hint: 'offset-lg-2',
                onChanged: (value) => setState(() => _tracks = value),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final entry in NextTrack.parse(
                    _tracks,
                  ).resolve().entries)
                    AppChip(
                      label:
                          '${entry.key.name} · offset ${entry.value} · '
                          'order ${NextTrack.parse(_tracks).resolve()[entry.key]}',
                      icon: Icons.swap_horiz_rounded,
                    ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Classes below the first value fall back to twelve columns, '
                'and values above it carry down to the widest breakpoint.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InspectorField extends StatelessWidget {
  const _InspectorField({
    required this.label,
    required this.value,
    required this.hint,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: TextEditingController(text: value),
      onChanged: onChanged,
      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.45,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
    );
  }
}
