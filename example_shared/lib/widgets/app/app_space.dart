import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

/// Responsive spacing, radius, and size tokens.
///
/// Every value is a [NextValue], so it resolves against the parent width
/// instead of the window.
extension AppSpace on BuildContext {
  /// Space between cards, rows, and sections.
  double get gap => const NextValue<double>(
    xs: 20,
    sm: 24,
    md: 28,
    lg: 32,
    xl: 40,
  ).resolve(this);

  /// Space inside a card.
  double get cardPadding =>
      const NextValue<double>(xs: 20, md: 24, lg: 28).resolve(this);

  /// Space between the page edge and the content.
  EdgeInsets get pagePadding {
    final horizontal = const NextValue<double>(
      xs: 20,
      md: 32,
      lg: 40,
      xl: 48,
    ).resolve(this);
    final vertical = const NextValue<double>(
      xs: 28,
      md: 36,
      lg: 48,
    ).resolve(this);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  /// Corner radius of cards and surfaces.
  double get radius =>
      const NextValue<double>(xs: 18, md: 22, lg: 26).resolve(this);

  /// Title size of a screen.
  double get titleSize =>
      const NextValue<double>(xs: 28, md: 34, lg: 40).resolve(this);

  /// Body size of a screen.
  double get bodySize =>
      const NextValue<double>(xs: 15, md: 16, lg: 17).resolve(this);

  /// True when the parent is phone sized.
  bool get isPhone => isXs || isSm;

  /// True when the parent is tablet sized.
  bool get isTablet => isMd;

  /// True when the parent is desktop sized.
  bool get isDesktop => isLg || isXl || isXXL;

  /// Breakpoint of the parent, for messages and debugging.
  Breakpoint get size => breakpoint;

  /// Border radius for a card at the current size.
  BorderRadius get cardRadius => BorderRadius.circular(radius);
}
