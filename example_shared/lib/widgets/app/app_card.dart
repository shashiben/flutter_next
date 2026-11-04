import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import 'app_space.dart';

/// A soft card used by the example apps.
///
/// Padding and radius follow the parent breakpoint unless they are given.
class AppCard extends StatelessWidget {
  /// Creates a card around [child].
  const AppCard({
    required this.child,
    this.padding,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.onTap,
    this.elevation = 200,
    super.key,
  });

  /// Contents of the card.
  final Widget child;

  /// Inner padding. Defaults to the responsive card padding.
  final EdgeInsetsGeometry? padding;

  /// Fill color. Defaults to the theme surface.
  final Color? color;

  /// Border color. Defaults to the theme outline variant.
  final Color? borderColor;

  /// Corner radius. Defaults to the responsive radius.
  final BorderRadius? borderRadius;

  /// Tap callback. The card does not look tappable when this is null.
  final VoidCallback? onTap;

  /// Shadow preset from [NextShadow].
  final int elevation;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = borderRadius ?? context.cardRadius;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? scheme.surface,
        borderRadius: radius,
        border: Border.all(color: borderColor ?? scheme.outlineVariant),
        boxShadow: NextShadow.level(context, elevation),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: padding ?? EdgeInsets.all(context.cardPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A small rounded label that can act as a filter.
class AppChip extends StatelessWidget {
  /// Creates a chip showing [label].
  const AppChip({
    required this.label,
    this.icon,
    this.selected = false,
    this.onTap,
    this.accent,
    super.key,
  });

  /// Text in the chip.
  final String label;

  /// Optional icon before the label.
  final IconData? icon;

  /// True when the chip is the active choice.
  final bool selected;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Accent color of the selected state.
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = accent ?? scheme.primary;
    final background = selected
        ? tone.withValues(alpha: 0.14)
        : scheme.surfaceContainerHighest.withValues(alpha: 0.5);
    final foreground = selected ? tone : scheme.onSurfaceVariant;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(999)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            border: Border.all(color: selected ? tone : scheme.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A tiny badge used for product and status labels.
class AppTag extends StatelessWidget {
  /// Creates a tag showing [label].
  const AppTag({required this.label, this.color, this.icon, super.key});

  /// Text in the tag.
  final String label;

  /// Fill color of the tag.
  final Color? color;

  /// Optional icon before the label.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = color ?? scheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: tone),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: tone,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A title with an optional subtitle and trailing widget.
class SectionHeading extends StatelessWidget {
  /// Creates a heading.
  const SectionHeading({
    required this.title,
    this.subtitle,
    this.trailing,
    super.key,
  });

  /// Section title.
  final String title;

  /// One line under the title.
  final String? subtitle;

  /// Widget placed at the end of the row.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 12), trailing!],
      ],
    );
  }
}

/// A screen heading that scales with the parent width.
///
/// [trailing] sits at the end of the row and [below] sits under the title,
/// so a control that is too wide for a phone can move down instead of
/// overflowing.
class PageHeading extends StatelessWidget {
  /// Creates a page heading.
  const PageHeading({
    required this.title,
    this.subtitle,
    this.trailing,
    this.below,
    super.key,
  });

  /// Screen title.
  final String title;

  /// One line under the title.
  final String? subtitle;

  /// Widget placed at the end of the row.
  final Widget? trailing;

  /// Widget placed under the title on narrow parents.
  final Widget? below;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: context.titleSize,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: context.bodySize,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 16), trailing!],
          ],
        ),
        if (below != null) ...[const SizedBox(height: 14), below!],
      ],
    );
  }
}

/// Compact product row: a vertical pill, the name, and the price.
class SampleProductTile extends StatelessWidget {
  /// Creates a row for [name] at [price].
  const SampleProductTile({
    required this.name,
    required this.price,
    required this.icon,
    required this.accent,
    this.detail,
    super.key,
  });

  /// Product name.
  final String name;

  /// Price line, already formatted.
  final String price;

  /// Icon drawn in the pill.
  final IconData icon;

  /// Accent of the pill.
  final Color accent;

  /// Optional line under the price.
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Row(
      children: [
        Container(
          width: 52,
          height: 84,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color.lerp(accent, Colors.white, 0.62)!,
                accent.withValues(alpha: 0.9),
              ],
            ),
          ),
          child: Icon(icon, size: 22, color: accent),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                price,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (detail != null) ...[
                const SizedBox(height: 2),
                Text(
                  detail!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A square artwork placeholder with an icon.
class AppArtwork extends StatelessWidget {
  /// Creates artwork using [icon] and [accent].
  const AppArtwork({
    required this.icon,
    required this.accent,
    this.height,
    this.iconSize,
    this.radius,
    super.key,
  });

  /// Icon drawn in the middle.
  final IconData icon;

  /// Accent color of the gradient.
  final Color accent;

  /// Height of the artwork.
  final double? height;

  /// Size of the icon.
  final double? iconSize;

  /// Corner radius.
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final box = height ?? 132;
    return Container(
      height: box,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? context.radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.16),
            accent.withValues(alpha: 0.42),
          ],
        ),
      ),
      child: Center(
        child: Icon(icon, size: iconSize ?? 40, color: accent),
      ),
    );
  }
}

/// A circular avatar with initials.
class AppAvatar extends StatelessWidget {
  /// Creates an avatar showing [initials].
  const AppAvatar({required this.initials, this.radius = 18, super.key});

  /// Initials drawn in the avatar.
  final String initials;

  /// Radius of the avatar.
  final double radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: scheme.primaryContainer,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: radius * 0.7,
          fontWeight: FontWeight.w700,
          color: scheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

/// A button label that shrinks instead of overflowing its button.
class AppButtonLabel extends StatelessWidget {
  /// Creates a label showing [text].
  const AppButtonLabel(this.text, {super.key});

  /// The label text.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(child: Text(text, overflow: TextOverflow.ellipsis));
  }
}

/// A thin progress bar used for goals and thresholds.
class AppProgress extends StatelessWidget {
  /// Creates a progress bar for [value] out of [total].
  const AppProgress({
    required this.value,
    required this.total,
    this.color,
    this.height = 8,
    super.key,
  });

  /// Current value.
  final double value;

  /// Value that fills the bar.
  final double total;

  /// Fill color.
  final Color? color;

  /// Height of the bar.
  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = color ?? scheme.primary;
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: total == 0 ? 0 : (value / total).clamp(0, 1),
          backgroundColor: tone.withValues(alpha: 0.15),
          valueColor: AlwaysStoppedAnimation<Color>(tone),
        ),
      ),
    );
  }
}
