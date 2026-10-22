import 'package:flutter/material.dart';

import '../utils/next_scope.dart';
import '../utils/responsive_breakpoints.dart';

/// An extension on [BuildContext] to provide convenient access to various properties.
extension ContextExtension on BuildContext {
  /// Returns the [MediaQueryData] associated with this context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the [Size] of the media query.
  Size get size => mediaQuery.size;

  /// Returns the width of the media query.
  double get width => size.width;

  /// Returns the height of the media query.
  double get height => size.height;

  /// Returns the horizontal block size, which is the width divided by 100.
  double get blockSizeHorizontal => width / 100;

  /// Returns the vertical block size, which is the height divided by 100.
  double get blockSizeVertical => height / 100;

  /// Returns the [ThemeData] associated with this context.
  ThemeData get themeData => Theme.of(this);

  /// Returns the [TextTheme] from the theme data.
  TextTheme get textTheme => themeData.textTheme;

  /// Returns the [ButtonThemeData] from the theme data.
  ButtonThemeData get buttonTheme => themeData.buttonTheme;

  /// Returns the [SnackBarThemeData] from the theme data.
  SnackBarThemeData get snackBarTheme => themeData.snackBarTheme;

  /// Returns the [IconThemeData] for the primary icon from the theme data.
  IconThemeData get primaryIconTheme => themeData.primaryIconTheme;

  /// Returns the padding of the media query.
  EdgeInsets get mediaQueryPadding => mediaQuery.padding;

  /// Returns the view padding of the media query.
  EdgeInsets get mediaQueryViewPadding => mediaQuery.viewPadding;

  /// Returns the view insets of the media query.
  EdgeInsets get mediaQueryViewInsets => mediaQuery.viewInsets;

  /// Returns the platform brightness of the media query.
  Brightness get platformBrightness => mediaQuery.platformBrightness;

  /// Returns the device pixel ratio of the media query.
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Returns the shortest side of the media query size.
  double get shortestSide => size.shortestSide;

  /// Returns the orientation of the media query.
  Orientation get orientation => mediaQuery.orientation;

  /// Returns true if the orientation is landscape.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns true if the orientation is portrait.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Parent-width breakpoint from the nearest [NextScope] or [NextRow].
  Breakpoint get breakpoint => NextMetrics.of(this).breakpoint;

  /// True when the parent breakpoint is extra-small or small.
  bool get isNarrow =>
      breakpoint == Breakpoint.xs || breakpoint == Breakpoint.sm;

  /// True when the layout is narrow. This follows width, not the target platform.
  bool get isMobile => isNarrow;

  /// True at the extra-extra-large breakpoint.
  bool get isXXL => breakpoint == Breakpoint.xxl;

  /// True at the extra-large breakpoint.
  bool get isXl => breakpoint == Breakpoint.xl;

  /// True at the large breakpoint.
  bool get isLg => breakpoint == Breakpoint.lg;

  /// True at the medium breakpoint.
  bool get isMd => breakpoint == Breakpoint.md;

  /// True at the small breakpoint.
  bool get isSm => breakpoint == Breakpoint.sm;

  /// True at the extra-small breakpoint.
  bool get isXs => breakpoint == Breakpoint.xs;

  /// Returns true if the 24-hour format is always used.
  bool get alwaysUse24HourFormat => mediaQuery.alwaysUse24HourFormat;

  /// Returns the primary color from the theme data.
  Color get primaryColor => themeData.primaryColor;

  /// Returns the dark primary color from the theme data.
  Color get primaryColorDark => themeData.primaryColorDark;

  /// Returns the light primary color from the theme data.
  Color get primaryColorLight => themeData.primaryColorLight;

  /// Returns the card color from the theme data.
  Color get cardColor => themeData.cardColor;

  /// Returns the background color from the color scheme of the theme data.
  Color get backgroundColor => themeData.colorScheme.surface;

  /// Returns the scaffold background color from the theme data.
  Color get scaffoldBackgroundColor => themeData.scaffoldBackgroundColor;

  /// Returns the canvas color from the theme data.
  Color get canvasColor => themeData.canvasColor;

  /// Returns the shadow color from the theme data.
  Color get shadowColor => themeData.shadowColor;

  /// Returns the error color from the color scheme of the theme data.
  Color get errorColor => themeData.colorScheme.error;

  /// Returns the hint color from the theme data.
  Color get hintColor => themeData.hintColor;

  /// Returns the divider color from the theme data.
  Color get dividerColor => themeData.dividerColor;

  /// Returns the disabled color from the theme data.
  Color get disabledColor => themeData.disabledColor;

  /// Returns the highlight color from the theme data.
  Color get highlightColor => themeData.highlightColor;

  /// Returns the splash color from the theme data.
  Color get splashColor => themeData.splashColor;

  /// Returns the unselected widget color from the theme data.
  Color get unselectedWidgetColor => themeData.unselectedWidgetColor;

  /// Returns the secondary header color from the theme data.
  Color get secondaryHeaderColor => themeData.secondaryHeaderColor;

  /// Returns the large display text style from the text theme.
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Returns the medium display text style from the text theme.
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Returns the small display text style from the text theme.
  TextStyle? get displaySmall => textTheme.displaySmall;

  /// Returns the medium headline text style from the text theme.
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Returns the small headline text style from the text theme.
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  /// Returns the large title text style from the text theme.
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Returns the medium title text style from the text theme.
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Returns the small title text style from the text theme.
  TextStyle? get titleSmall => textTheme.titleSmall;

  /// Returns the large body text style from the text theme.
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Returns the medium body text style from the text theme.
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Returns the small body text style from the text theme.
  TextStyle? get bodySmall => textTheme.bodySmall;

  /// Returns the large label text style from the text theme.
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Returns the medium label text style from the text theme.
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Returns the small label text style from the text theme.
  TextStyle? get labelSmall => textTheme.labelSmall;

  /// Returns the [NavigatorState] associated with this context.
  NavigatorState get navigator => Navigator.of(this);
}
