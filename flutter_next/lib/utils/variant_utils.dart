import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// Utility class for handling variants in Next UI.
class NextVariantUtil {
  /// Returns a color based on the provided variant.
  static Color getColor(NextVariant variant) {
    switch (variant) {
      case NextVariant.success:
        return NextColorVariant.success;
      case NextVariant.primary:
        return NextColorVariant.primary;
      case NextVariant.secondary:
        return NextColorVariant.secondary;
      case NextVariant.warning:
        return NextColorVariant.warning;
      case NextVariant.info:
        return NextColorVariant.info;
      case NextVariant.light:
        return NextColorVariant.light;
      case NextVariant.danger:
        return NextColorVariant.danger;
      case NextVariant.dark:
        return NextColorVariant.dark;
      case NextVariant.custom:
        return NextColorVariant.success;
    }
  }

  /// Returns a color utility object based on the provided variant.
  static NextAlertColorUtil getColorUtil(NextVariant variant) {
    switch (variant) {
      case NextVariant.success:
        return NextAlertColorUtil.success;
      case NextVariant.primary:
        return NextAlertColorUtil.primary;
      case NextVariant.secondary:
        return NextAlertColorUtil.secondary;
      case NextVariant.warning:
        return NextAlertColorUtil.warning;
      case NextVariant.info:
        return NextAlertColorUtil.info;
      case NextVariant.light:
        return NextAlertColorUtil.light;
      case NextVariant.danger:
        return NextAlertColorUtil.danger;
      case NextVariant.dark:
        return NextAlertColorUtil.dark;
      case NextVariant.custom:
        return NextAlertColorUtil.success;
    }
  }
}

/// Utility class for handling alert colors in Next UI.
///
/// Inspired by Tailwind CSS and Bootstrap alert color schemes.
/// Provides modern, accessible color combinations with proper contrast.
class NextAlertColorUtil {
  const NextAlertColorUtil({
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  /// Primary text color for the alert content.
  final Color color;

  /// Background color of the alert.
  final Color backgroundColor;

  /// Border color (also used as accent color for left border).
  final Color borderColor;

  /// Accent color (same as border color for left border accent).
  Color get accentColor => borderColor;

  /// Text color for content (same as color).
  Color get textColor => color;

  // Bootstrap 5.3 color schemes
  // Colors match Bootstrap's --{color}-text-emphasis, --{color}-bg-subtle, and --{color}-border-subtle

  /// Primary variant - Blue theme
  /// Matches Bootstrap's .alert-primary
  static const NextAlertColorUtil primary = NextAlertColorUtil(
    color: Color(0xFF084298), // --bs-primary-text-emphasis
    backgroundColor: Color(0xFFCFE2FF), // --bs-primary-bg-subtle
    borderColor: Color(0xFF0D6EFD), // --bs-primary-border-subtle
  );

  /// Secondary variant - Gray theme
  /// Matches Bootstrap's .alert-secondary
  static const NextAlertColorUtil secondary = NextAlertColorUtil(
    color: Color(0xFF41464B), // --bs-secondary-text-emphasis
    backgroundColor: Color(0xFFE2E3E5), // --bs-secondary-bg-subtle
    borderColor: Color(0xFF6C757D), // --bs-secondary-border-subtle
  );

  /// Success variant - Green theme
  /// Matches Bootstrap's .alert-success
  static const NextAlertColorUtil success = NextAlertColorUtil(
    color: Color(0xFF0F5132), // --bs-success-text-emphasis
    backgroundColor: Color(0xFFD1E7DD), // --bs-success-bg-subtle
    borderColor: Color(0xFF198754), // --bs-success-border-subtle
  );

  /// Danger variant - Red theme
  /// Matches Bootstrap's .alert-danger
  static const NextAlertColorUtil danger = NextAlertColorUtil(
    color: Color(0xFF842029), // --bs-danger-text-emphasis
    backgroundColor: Color(0xFFF8D7DA), // --bs-danger-bg-subtle
    borderColor: Color(0xFFDC3545), // --bs-danger-border-subtle
  );

  /// Warning variant - Yellow/Orange theme
  /// Matches Bootstrap's .alert-warning
  static const NextAlertColorUtil warning = NextAlertColorUtil(
    color: Color(0xFF664D03), // --bs-warning-text-emphasis
    backgroundColor: Color(0xFFFFF3CD), // --bs-warning-bg-subtle
    borderColor: Color(0xFFFFC107), // --bs-warning-border-subtle
  );

  /// Info variant - Cyan theme
  /// Matches Bootstrap's .alert-info
  static const NextAlertColorUtil info = NextAlertColorUtil(
    color: Color(0xFF055160), // --bs-info-text-emphasis
    backgroundColor: Color(0xFFCFF4FC), // --bs-info-bg-subtle
    borderColor: Color(0xFF0DCAF0), // --bs-info-border-subtle
  );

  /// Light variant - Light gray theme
  /// Matches Bootstrap's .alert-light
  static const NextAlertColorUtil light = NextAlertColorUtil(
    color: Color(0xFF636464), // --bs-light-text-emphasis
    backgroundColor: Color(0xFFFCFCFD), // --bs-light-bg-subtle
    borderColor: Color(0xFFFEFEFE), // --bs-light-border-subtle
  );

  /// Dark variant - Dark theme
  /// Matches Bootstrap's .alert-dark
  static const NextAlertColorUtil dark = NextAlertColorUtil(
    color: Color(0xFF141619), // --bs-dark-text-emphasis
    backgroundColor: Color(0xFFD3D3D4), // --bs-dark-bg-subtle
    borderColor: Color(0xFF212529), // --bs-dark-border-subtle
  );
}
