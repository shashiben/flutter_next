import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A modern, customizable alert widget inspired by Tailwind CSS and Bootstrap.
///
/// Provides beautiful, accessible alerts with multiple variants, icons, and
/// smooth animations. Perfect for displaying important messages, notifications,
/// and feedback to users.
///
/// **Example:**
/// ```dart
/// NextAlert(
///   variant: NextVariant.success,
///   child: Text('Operation completed successfully!'),
///   onClosePressed: () => print('Alert dismissed'),
/// )
/// ```
class NextAlert extends StatelessWidget {
  /// Creates a [NextAlert].
  ///
  /// The [child] argument is required and should contain the alert message.
  const NextAlert({
    super.key,
    required this.child,
    this.variant = NextVariant.primary,
    this.visible = true,
    this.onClosePressed,
    this.leading,
    this.title,
    this.dismissible = true,
    this.borderRadius,
    this.padding,
    this.margin,
    this.showIcon = true,
    this.customConfigs,
    this.duration,
  });

  /// The main content of the alert.
  final Widget child;

  /// The variant/style of the alert.
  ///
  /// Determines the color scheme and visual appearance.
  final NextVariant variant;

  /// Whether the alert is visible.
  ///
  /// When false, the alert will be hidden with animation.
  final bool visible;

  /// Callback called when the close button is pressed.
  ///
  /// If null, the close button will not be shown.
  final VoidCallback? onClosePressed;

  /// Optional leading widget (typically an icon).
  ///
  /// If null and [showIcon] is true, a default icon will be shown based on variant.
  final Widget? leading;

  /// Optional title/heading for the alert.
  ///
  /// Displayed above the [child] content.
  final Widget? title;

  /// Whether the alert can be dismissed.
  ///
  /// If true and [onClosePressed] is provided, a close button will be shown.
  final bool dismissible;

  /// Border radius for the alert container.
  ///
  /// Defaults to 8.0 for a modern, rounded appearance.
  final BorderRadius? borderRadius;

  /// Padding inside the alert.
  ///
  /// Defaults to EdgeInsets.all(16.0) for comfortable spacing.
  final EdgeInsetsGeometry? padding;

  /// Margin around the alert.
  ///
  /// Useful for spacing between multiple alerts.
  final EdgeInsetsGeometry? margin;

  /// Whether to show the default icon for the variant.
  ///
  /// Only applies if [leading] is null.
  final bool showIcon;

  /// Custom color configuration.
  ///
  /// Only used when [variant] is [NextVariant.custom].
  final NextAlertColorUtil? customConfigs;

  /// Duration for the show/hide animation.
  ///
  /// Defaults to 300ms for a snappy feel.
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    final config = variant == NextVariant.custom
        ? customConfigs ?? NextAlertColorUtil.danger
        : NextVariantUtil.getColorUtil(variant);

    return AnimatedContainer(
      duration: duration ?? const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: margin ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: config.backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          border: Border.all(
            color: config.borderColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left border accent (Bootstrap/Tailwind style)
            Container(
              width: 4.0,
              decoration: BoxDecoration(
                color: config.accentColor,
                borderRadius:
                    (borderRadius ?? BorderRadius.circular(8.0)).copyWith(
                  topRight: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
            ),
            // Content area
            Expanded(
              child: Padding(
                padding: padding ?? const EdgeInsets.all(16.0),
                child: _buildContent(config),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(NextAlertColorUtil config) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leading icon
        if (showIcon || leading != null) ...[
          _buildLeadingIcon(config),
          const SizedBox(width: 12),
        ],
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                DefaultTextStyle(
                  style: TextStyle(
                    color: config.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                  child: title!,
                ),
                const SizedBox(height: 4),
              ],
              DefaultTextStyle(
                style: TextStyle(
                  color: config.textColor,
                  fontSize: 14,
                  height: 1.5,
                ),
                child: child,
              ),
            ],
          ),
        ),
        // Close button
        if (dismissible && onClosePressed != null) ...[
          const SizedBox(width: 8),
          _buildCloseButton(config),
        ],
      ],
    );
  }

  Widget _buildLeadingIcon(NextAlertColorUtil config) {
    if (leading != null) {
      return leading!;
    }

    if (!showIcon) {
      return const SizedBox.shrink();
    }

    return Icon(
      _getIconForVariant(variant),
      color: config.accentColor,
      size: 20,
    );
  }

  Widget _buildCloseButton(NextAlertColorUtil config) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClosePressed,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.close,
            size: 18,
            color: config.textColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  IconData _getIconForVariant(NextVariant variant) {
    switch (variant) {
      case NextVariant.success:
        return Icons.check_circle_outline;
      case NextVariant.danger:
        return Icons.error_outline;
      case NextVariant.warning:
        return Icons.warning_amber_rounded;
      case NextVariant.info:
        return Icons.info_outline;
      case NextVariant.primary:
        return Icons.info_outline;
      case NextVariant.secondary:
        return Icons.circle_outlined;
      case NextVariant.light:
        return Icons.lightbulb_outline;
      case NextVariant.dark:
        return Icons.dark_mode_outlined;
      case NextVariant.custom:
        return Icons.circle_outlined;
    }
  }
}

/// Enhanced color utility for alerts with Tailwind/Bootstrap-inspired colors.
extension NextAlertColorUtilExtension on NextAlertColorUtil {
  /// Gets the accent color (left border color).
  Color get accentColor => borderColor;

  /// Gets the text color for content.
  Color get textColor => color;
}
