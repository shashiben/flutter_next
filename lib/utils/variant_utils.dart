import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextVariantUtils {
  static Color getColorByVariant(NextVariant variant) {
    switch (variant) {
      case NextVariant.success:
        return NextColorVariants.success;
      case NextVariant.primary:
        return NextColorVariants.primary;
      case NextVariant.secondary:
        return NextColorVariants.secondary;
      case NextVariant.warning:
        return NextColorVariants.warning;
      case NextVariant.info:
        return NextColorVariants.info;
      case NextVariant.light:
        return NextColorVariants.light;
      case NextVariant.danger:
        return NextColorVariants.danger;
      case NextVariant.dark:
        return NextColorVariants.dark;
      default:
        return NextColorVariants.success;
    }
  }

  static NextAlertColorUtils getColorUtilsByVariant(NextVariant variant) {
    switch (variant) {
      case NextVariant.success:
        return NextAlertColorUtils.success;
      case NextVariant.primary:
        return NextAlertColorUtils.primary;
      case NextVariant.secondary:
        return NextAlertColorUtils.secondary;
      case NextVariant.warning:
        return NextAlertColorUtils.warning;
      case NextVariant.info:
        return NextAlertColorUtils.info;
      case NextVariant.light:
        return NextAlertColorUtils.light;
      case NextVariant.danger:
        return NextAlertColorUtils.danger;
      case NextVariant.dark:
        return NextAlertColorUtils.dark;
      default:
        return NextAlertColorUtils.success;
    }
  }
}

class NextAlertColorUtils {
  /// Define primary color of [NextAlert]
  final Color color;

  /// Define background color of [NextAlert]
  final Color backgroundColor;

  /// Define Border color of [NextAlert]
  final Color borderColor;

  const NextAlertColorUtils(
      {required this.color,
      required this.backgroundColor,
      required this.borderColor});

  static const NextAlertColorUtils primary = NextAlertColorUtils(
    color: NextColorVariants.primary,
    backgroundColor: Color(0xffcfe2ff),
    borderColor: Color(0xffb6d4fe),
  );

  static const NextAlertColorUtils secondary = NextAlertColorUtils(
    color: NextColorVariants.secondary,
    backgroundColor: Color(0xffe2e3e5),
    borderColor: Color(0xffd3d6d8),
  );

  static const NextAlertColorUtils success = NextAlertColorUtils(
    color: NextColorVariants.success,
    backgroundColor: Color(0xffd1e7dd),
    borderColor: Color(0xffbadbcc),
  );

  static const NextAlertColorUtils danger = NextAlertColorUtils(
    color: NextColorVariants.danger,
    backgroundColor: Color(0xfff8d7da),
    borderColor: Color(0xfff5c2c7),
  );

  static const NextAlertColorUtils warning = NextAlertColorUtils(
    color: NextColorVariants.warning,
    backgroundColor: Color(0xfffff3cd),
    borderColor: Color(0xffffecb5),
  );

  static const NextAlertColorUtils info = NextAlertColorUtils(
    color: NextColorVariants.info,
    backgroundColor: Color(0xffcff4fc),
    borderColor: Color(0xffb6effb),
  );

  static const NextAlertColorUtils light = NextAlertColorUtils(
    color: NextColorVariants.light,
    backgroundColor: Color(0xfffefefe),
    borderColor: Color(0xfffdfdfe),
  );

  static const NextAlertColorUtils dark = NextAlertColorUtils(
      color: NextColorVariants.dark,
      backgroundColor: Color(0xffd3d3d4),
      borderColor: Color(0xffbcbebf));
}
