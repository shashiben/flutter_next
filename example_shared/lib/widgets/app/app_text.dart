import 'package:flutter/material.dart';

/// Clear typographic scale for the gallery.
///
/// Every screen uses these styles instead of ad-hoc font sizes, so headings,
/// body text, labels, and captions stay in proportion at every width.
extension AppText on BuildContext {
  /// Primary screen heading.
  TextStyle get h1 => Theme.of(this).textTheme.headlineLarge!.copyWith(
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    height: 1.1,
  );

  /// Section heading inside a card.
  TextStyle get h2 => Theme.of(this).textTheme.headlineSmall!.copyWith(
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    height: 1.2,
  );

  /// Subheading under a heading.
  TextStyle get h3 => Theme.of(
    this,
  ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, height: 1.3);

  /// Primary body paragraph.
  TextStyle get body =>
      Theme.of(this).textTheme.bodyMedium!.copyWith(height: 1.55);

  /// Secondary body text.
  TextStyle get bodySmall =>
      Theme.of(this).textTheme.bodySmall!.copyWith(height: 1.5);

  /// Prominent label on a card or button.
  TextStyle get label => Theme.of(
    this,
  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600, height: 1.2);

  /// Small caption or helper text.
  TextStyle get caption =>
      Theme.of(this).textTheme.labelSmall!.copyWith(height: 1.3);

  /// Money values and counts.
  TextStyle get money => Theme.of(this).textTheme.titleMedium!.copyWith(
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );

  /// Monospace code snippet.
  TextStyle get code => Theme.of(
    this,
  ).textTheme.bodySmall!.copyWith(fontFamily: 'monospace', height: 1.4);
}
