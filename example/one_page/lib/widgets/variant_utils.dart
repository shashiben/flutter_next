import 'package:one_page/constants.dart';
import 'package:flutter/material.dart';

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
}
