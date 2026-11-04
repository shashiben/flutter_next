import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import 'app_space.dart';

/// A top bar for the example apps.
///
/// The brand text appears from the small breakpoint, the search field from
/// the medium breakpoint, and both follow the parent width.
class AppTopBar extends StatelessWidget {
  /// Creates a top bar.
  const AppTopBar({
    required this.brand,
    this.subtitle,
    this.searchPlaceholder,
    this.actions = const <Widget>[],
    this.leading,
    super.key,
  });

  /// Product or company name.
  final String brand;

  /// One line under the name.
  final String? subtitle;

  /// When set, a search field is shown on medium widths and wider.
  final String? searchPlaceholder;

  /// Widgets placed at the end of the bar.
  final List<Widget> actions;

  /// Widget placed before the brand name.
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final padding = context.gap;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 12)],
          Flexible(
            child: _Brand(brand: brand, subtitle: subtitle),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: NextShow(
                from: Breakpoint.md,
                fallback: const SizedBox.shrink(),
                child: searchPlaceholder == null
                    ? const SizedBox.shrink()
                    : ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: _SearchField(placeholder: searchPlaceholder!),
                      ),
              ),
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.brand, this.subtitle});

  final String brand;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                theme.colorScheme.primary,
                theme.colorScheme.tertiary,
              ],
            ),
          ),
          child: Icon(
            Icons.bolt_rounded,
            size: 20,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: NextShow(
            from: Breakpoint.sm,
            fallback: const SizedBox.shrink(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.placeholder});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TextField(
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: scheme.onSurfaceVariant,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        isDense: true,
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(999)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
