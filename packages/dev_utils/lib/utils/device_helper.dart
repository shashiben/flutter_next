import 'package:dev_utils/constants/enums.dart';

/// Utility class for determining device and screen configurations.
class DeviceHelper {
  /// Configurable breakpoints for responsive design.
  static ResponsiveConfig responsiveConfig = ResponsiveConfig.defaultConfig();

  /// Determines the screen type based on device size.
  static ScreenType getScreenType(double width) {
    if (width >= responsiveConfig.foldableMinWidth) {
      return ScreenType.foldable;
    } else if (width >= responsiveConfig.desktopMinWidth) {
      return ScreenType.desktop;
    } else if (width >= responsiveConfig.tabletMinWidth) {
      return ScreenType.tablet;
    } else {
      return ScreenType.mobile;
    }
  }

  /// Determines the responsive breakpoint based on width.
  static ResponsiveType getResponsiveType(double width) {
    if (width < responsiveConfig.sm) {
      return ResponsiveType.xs;
    } else if (width < responsiveConfig.md) {
      return ResponsiveType.sm;
    } else if (width < responsiveConfig.lg) {
      return ResponsiveType.md;
    } else if (width < responsiveConfig.xl) {
      return ResponsiveType.lg;
    } else if (width < responsiveConfig.xxl) {
      return ResponsiveType.xl;
    } else {
      return ResponsiveType.xxl;
    }
  }
}

/// Configuration for responsive breakpoints.
class ResponsiveConfig {
  const ResponsiveConfig({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    this.tabletMinWidth = 600.0,
    this.desktopMinWidth = 1024.0,
    this.foldableMinWidth = 1800.0,
  });

  /// Default configuration for breakpoints.
  factory ResponsiveConfig.defaultConfig() {
    return const ResponsiveConfig(
      xs: 0,
      sm: 576,
      md: 768,
      lg: 992,
      xl: 1200,
      xxl: 1440,
    );
  }

  final double xs; // Extra small
  final double sm; // Small
  final double md; // Medium
  final double lg; // Large
  final double xl; // Extra large
  final double xxl; // Extra extra large

  final double tabletMinWidth;
  final double desktopMinWidth;
  final double foldableMinWidth;
}
