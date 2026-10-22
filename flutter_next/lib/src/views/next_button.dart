import 'package:flutter/material.dart';

import '../constants/enums.dart';

/// A filled or outlined button built on [ButtonStyleButton].
class NextButton extends StatelessWidget {
  /// Creates a button.
  const NextButton({
    this.child,
    this.leading,
    this.trailing,
    this.style,
    this.onPressed,
    this.color,
    this.outlineColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    this.margin = const EdgeInsets.all(4),
    this.variant = NextButtonVariant.filled,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.enabled = true,
    this.itemBuilder,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    super.key,
  });

  /// Label.
  final Widget? child;

  /// Widget before [child].
  final Widget? leading;

  /// Widget after [child].
  final Widget? trailing;

  /// Text style applied to [child].
  final TextStyle? style;

  /// Tap callback. Ignored when [enabled] is false.
  final VoidCallback? onPressed;

  /// Fill color for [NextButtonVariant.filled].
  final Color? color;

  /// Border and label color for [NextButtonVariant.outlined].
  final Color? outlineColor;

  /// Padding inside the button.
  final EdgeInsets padding;

  /// Outer margin.
  final EdgeInsets margin;

  /// Filled or outlined.
  final NextButtonVariant variant;

  /// Corner radius.
  final BorderRadius borderRadius;

  /// When false, the button is disabled.
  final bool enabled;

  /// Replaces the default label. [color] is the hovered color.
  final Widget Function(BuildContext context, bool isHovered, Color? color)?
  itemBuilder;

  /// Resting elevation.
  final double? elevation;

  /// Elevation while focused.
  final double? focusElevation;

  /// Elevation while hovered.
  final double? hoverElevation;

  /// Elevation while pressed.
  final double? highlightElevation;

  /// Elevation while disabled.
  final double? disabledElevation;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pressed = enabled ? onPressed : null;
    if (itemBuilder != null) {
      return Padding(
        padding: margin,
        child: _CustomNextButton(
          color: color ?? scheme.surface,
          outlineColor: outlineColor ?? scheme.primary,
          onPressed: pressed,
          itemBuilder: itemBuilder!,
        ),
      );
    }

    final label = IconTheme.merge(
      data: const IconThemeData(size: 18),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 8)],
          ?child,
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );

    final button = variant == NextButtonVariant.outlined
        ? OutlinedButton(
            style: _outlinedStyle(context),
            onPressed: pressed,
            child: label,
          )
        : FilledButton(
            style: _filledStyle(context),
            onPressed: pressed,
            child: label,
          );

    return Padding(
      padding: margin,
      child: style == null
          ? button
          : DefaultTextStyle.merge(style: style, child: button),
    );
  }

  ButtonStyle _filledStyle(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = color ?? scheme.primary;
    final foreground =
        ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black;
    return FilledButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      disabledBackgroundColor: background.withValues(alpha: 0.38),
      disabledForegroundColor: foreground.withValues(alpha: 0.6),
      padding: padding,
      elevation: elevation ?? 0,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
    ).copyWith(elevation: _elevations());
  }

  ButtonStyle _outlinedStyle(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final outline = outlineColor ?? scheme.primary;
    final onFill =
        ThemeData.estimateBrightnessForColor(outline) == Brightness.dark
        ? Colors.white
        : Colors.black;
    return OutlinedButton.styleFrom(
      foregroundColor: outline,
      padding: padding,
      elevation: elevation ?? 0,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      side: BorderSide(color: outline, width: 1.5),
    ).copyWith(
      elevation: _elevations(),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        final active =
            states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.pressed);
        return active ? outline : Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return outline.withValues(alpha: 0.38);
        }
        final active =
            states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.pressed);
        return active ? onFill : outline;
      }),
    );
  }

  WidgetStateProperty<double> _elevations() {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return disabledElevation ?? 0;
      }
      if (states.contains(WidgetState.hovered)) {
        return hoverElevation ?? elevation ?? 0;
      }
      if (states.contains(WidgetState.focused)) {
        return focusElevation ?? elevation ?? 0;
      }
      if (states.contains(WidgetState.pressed)) {
        return highlightElevation ?? elevation ?? 0;
      }
      return elevation ?? 0;
    });
  }
}

class _CustomNextButton extends StatelessWidget {
  const _CustomNextButton({
    required this.color,
    required this.outlineColor,
    required this.onPressed,
    required this.itemBuilder,
  });

  final Color color;
  final Color outlineColor;
  final VoidCallback? onPressed;
  final Widget Function(BuildContext context, bool isHovered, Color? color)
  itemBuilder;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(begin: color, end: outlineColor),
      duration: const Duration(milliseconds: 180),
      builder: (context, value, _) {
        return _HoverColor(
          color: value,
          outlineColor: outlineColor,
          onPressed: onPressed,
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}

class _HoverColor extends StatefulWidget {
  const _HoverColor({
    required this.color,
    required this.outlineColor,
    required this.onPressed,
    required this.itemBuilder,
  });

  final Color? color;
  final Color outlineColor;
  final VoidCallback? onPressed;
  final Widget Function(BuildContext context, bool isHovered, Color? color)
  itemBuilder;

  @override
  State<_HoverColor> createState() => _HoverColorState();
}

class _HoverColorState extends State<_HoverColor> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final shown = _hovered ? widget.outlineColor : widget.color;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: widget.itemBuilder(context, _hovered, shown),
      ),
    );
  }
}
