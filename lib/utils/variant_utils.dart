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
class NextAlertColorUtil {
  const NextAlertColorUtil({
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  /// Primary color of the alert.
  final Color color;

  /// Background color of the alert.
  final Color backgroundColor;

  /// Border color of the alert.
  final Color borderColor;

  // Define color utilities for each variant.
  static const NextAlertColorUtil primary = NextAlertColorUtil(
    color: NextColorVariant.primary,
    backgroundColor: Color(0xffcfe2ff),
    borderColor: Color(0xffb6d4fe),
  );

  static const NextAlertColorUtil secondary = NextAlertColorUtil(
    color: NextColorVariant.secondary,
    backgroundColor: Color(0xffe2e3e5),
    borderColor: Color(0xffd3d6d8),
  );

  static const NextAlertColorUtil success = NextAlertColorUtil(
    color: NextColorVariant.success,
    backgroundColor: Color(0xffd1e7dd),
    borderColor: Color(0xffbadbcc),
  );

  static const NextAlertColorUtil danger = NextAlertColorUtil(
    color: NextColorVariant.danger,
    backgroundColor: Color(0xfff8d7da),
    borderColor: Color(0xfff5c2c7),
  );

  static const NextAlertColorUtil warning = NextAlertColorUtil(
    color: NextColorVariant.warning,
    backgroundColor: Color(0xfffff3cd),
    borderColor: Color(0xffffecb5),
  );

  static const NextAlertColorUtil info = NextAlertColorUtil(
    color: NextColorVariant.info,
    backgroundColor: Color(0xffcff4fc),
    borderColor: Color(0xffb6effb),
  );

  static const NextAlertColorUtil light = NextAlertColorUtil(
    color: NextColorVariant.light,
    backgroundColor: Color(0xfffefefe),
    borderColor: Color(0xfffdfdfe),
  );

  static const NextAlertColorUtil dark = NextAlertColorUtil(
    color: NextColorVariant.dark,
    backgroundColor: Color(0xffd3d3d4),
    borderColor: Color(0xffbcbebf),
  );
}
