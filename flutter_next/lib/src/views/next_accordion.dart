import 'package:flutter/material.dart';

/// A styled [ExpansionTile].
class NextAccordion extends StatelessWidget {
  /// Creates an accordion section.
  const NextAccordion({
    required this.title,
    this.leading,
    this.subtitle,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding,
    this.borderColor,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.textColor,
    this.collapsedTextColor,
    this.iconColor,
    this.collapsedIconColor,
    this.controlAffinity,
    super.key,
  });

  /// Icon before the title.
  final Widget? leading;

  /// Header title.
  final Widget title;

  /// Header subtitle.
  final Widget? subtitle;

  /// Called with the next expanded state.
  final ValueChanged<bool>? onExpansionChanged;

  /// Body shown while expanded.
  final List<Widget> children;

  /// Widget that replaces the expand icon.
  final Widget? trailing;

  /// Whether the body starts open.
  final bool initiallyExpanded;

  /// Keeps the body in the tree while collapsed.
  final bool maintainState;

  /// Padding around the header.
  final EdgeInsetsGeometry? tilePadding;

  /// Border color of the tile.
  final Color? borderColor;

  /// Cross-axis alignment of [children].
  final CrossAxisAlignment? expandedCrossAxisAlignment;

  /// Alignment of [children].
  final Alignment? expandedAlignment;

  /// Padding around [children].
  final EdgeInsetsGeometry? childrenPadding;

  /// Header color while expanded.
  final Color? backgroundColor;

  /// Header color while collapsed.
  final Color? collapsedBackgroundColor;

  /// Title color while expanded.
  final Color? textColor;

  /// Title color while collapsed.
  final Color? collapsedTextColor;

  /// Icon color while expanded.
  final Color? iconColor;

  /// Icon color while collapsed.
  final Color? collapsedIconColor;

  /// Where the expand icon sits.
  final ListTileControlAffinity? controlAffinity;

  @override
  Widget build(BuildContext context) {
    final border = borderColor == null
        ? const Border()
        : Border.fromBorderSide(BorderSide(color: borderColor!));
    return ExpansionTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      onExpansionChanged: onExpansionChanged,
      trailing: trailing,
      initiallyExpanded: initiallyExpanded,
      maintainState: maintainState,
      tilePadding: tilePadding,
      expandedCrossAxisAlignment: expandedCrossAxisAlignment,
      expandedAlignment: expandedAlignment,
      childrenPadding: childrenPadding,
      backgroundColor: backgroundColor,
      collapsedBackgroundColor: collapsedBackgroundColor,
      textColor: textColor,
      collapsedTextColor: collapsedTextColor,
      iconColor: iconColor,
      collapsedIconColor: collapsedIconColor,
      controlAffinity: controlAffinity ?? ListTileControlAffinity.trailing,
      shape: border,
      collapsedShape: border,
      children: children,
    );
  }
}
