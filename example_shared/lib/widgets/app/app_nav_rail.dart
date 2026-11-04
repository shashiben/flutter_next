import 'package:flutter/material.dart';

/// One entry in the [AppNavRail].
class AppNavItem {
  /// Creates a navigation entry.
  const AppNavItem({required this.icon, required this.label});

  /// Icon of the entry.
  final IconData icon;

  /// Label of the entry.
  final String label;
}

/// A vertical navigation panel used by the dashboard demo.
///
/// In [compact] mode only the icons are shown.
class AppNavRail extends StatelessWidget {
  /// Creates a rail.
  const AppNavRail({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.header,
    this.footer,
    this.compact = false,
    super.key,
  });

  /// Entries in the rail.
  final List<AppNavItem> items;

  /// Index of the active entry.
  final int selectedIndex;

  /// Called with the index of the tapped entry.
  final ValueChanged<int> onSelected;

  /// Widget placed above the entries.
  final Widget? header;

  /// Widget placed below the entries.
  final Widget? footer;

  /// True when only icons are shown.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      width: compact ? 76 : 236,
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(right: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(16, compact ? 16 : 20, 16, 12),
              child: header,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: scheme.outlineVariant, height: 1),
            ),
          ],
          Expanded(
            child: ListView(
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              children: [
                for (var i = 0; i < items.length; i++)
                  _RailEntry(
                    item: items[i],
                    selected: i == selectedIndex,
                    compact: compact,
                    onTap: () => onSelected(i),
                  ),
              ],
            ),
          ),
          if (footer != null)
            Padding(padding: const EdgeInsets.all(16), child: footer!),
        ],
      ),
    );
  }
}

class _RailEntry extends StatelessWidget {
  const _RailEntry({
    required this.item,
    required this.selected,
    required this.compact,
    required this.onTap,
  });

  final AppNavItem item;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final foreground = selected ? scheme.primary : scheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Tooltip(
        message: compact ? item.label : '',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 0 : 12,
                vertical: compact ? 12 : 10,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? scheme.primary.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: compact
                  ? Icon(item.icon, size: 20, color: foreground)
                  : Row(
                      children: [
                        Icon(item.icon, size: 18, color: foreground),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.label,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: foreground,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
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
