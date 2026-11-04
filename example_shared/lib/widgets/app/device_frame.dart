import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

/// A device-shaped frame that previews an app at a fixed width.
class DeviceFrame extends StatelessWidget {
  /// Creates a frame around [child].
  const DeviceFrame({
    required this.child,
    this.width = 390,
    this.height = 720,
    this.label,
    this.radius = 28,
    super.key,
  });

  /// App rendered inside the frame.
  final Widget child;

  /// Width of the frame. The app reads this as its parent width.
  final double width;

  /// Height of the frame.
  final double height;

  /// Caption under the frame.
  final String? label;

  /// Corner radius of the frame.
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: scheme.outlineVariant),
            boxShadow: NextShadow.level(context, 400),
          ),
          child: PrimaryScrollController.none(child: NextScope(child: child)),
        ),
        if (label != null) ...[
          const SizedBox(height: 10),
          Text(
            label!,
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}

/// A real device from [device_preview], scaled to [height], with [child]
/// laid out at that device's screen size.
class PresetFrame extends StatelessWidget {
  /// Creates a frame for [preset].
  const PresetFrame({
    required this.preset,
    required this.child,
    this.height = 640,
    this.label,
    super.key,
  });

  /// Device artwork and screen size.
  final DevicePreset preset;

  /// App rendered on the device screen.
  final Widget child;

  /// Height of the scaled device, bezel included.
  final double height;

  /// Caption under the device.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final simulation = preset.resolve();
    final screen = simulation.screenSize!;
    final bounds = simulation.contentBounds;
    final padding = simulation.padding ?? EdgeInsets.zero;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: bounds.width * height / bounds.height,
          height: height,
          child: FittedBox(
            child: SizedBox(
              width: bounds.width,
              height: bounds.height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: -bounds.left,
                    top: -bounds.top,
                    width: screen.width,
                    height: screen.height,
                    child: DevicePreviewFrame(
                      simulation: AlwaysStoppedAnimation<DeviceSimulation?>(
                        simulation,
                      ),
                      child: PrimaryScrollController.none(
                        child: MediaQuery(
                          data: MediaQueryData(
                            size: screen,
                            padding: padding,
                            viewPadding: simulation.viewPadding ?? padding,
                            devicePixelRatio: simulation.devicePixelRatio ?? 1,
                          ),
                          child: SafeArea(child: NextScope(child: child)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 10),
          Text(
            label!,
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
