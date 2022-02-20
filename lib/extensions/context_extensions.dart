import 'package:flutter/material.dart';

import 'package:universal_io/io.dart' as io;

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;

  double get width => size.width;
  double get height => size.height;

  double get blockSizeHorizontal => width / 100;
  double get blockSizeVertical => height / 100;

  ThemeData get themeData => Theme.of(this);
  TextTheme get textTheme => themeData.textTheme;
  ButtonThemeData get buttonTheme => themeData.buttonTheme;
  SnackBarThemeData get snackBarTheme => themeData.snackBarTheme;
  IconThemeData get primaryIconTheme => themeData.primaryIconTheme;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  double get shortestSide => size.shortestSide;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isMobile =>
      (io.Platform.isAndroid || io.Platform.isIOS || size.width < 600);
  bool get isXXL => size.width >= 1400;
  bool get isXl => size.width >= 1200 && size.width < 1400;
  bool get isLg => size.width >= 992 && size.width < 1200;
  bool get isMd => size.width >= 768 && size.width < 992;
  bool get isSm => size.width >= 576 && size.width < 768;
  bool get isXs => size.width < 576;
  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  Color get primaryColor => themeData.primaryColor;
  Color get primaryColorDark => themeData.primaryColorDark;
  Color get primaryColorLight => themeData.primaryColorLight;
  Color get cardColor => themeData.cardColor;
  Color get backgroundColor => themeData.backgroundColor;
  Color get scaffoldBackgroundColor => themeData.scaffoldBackgroundColor;
  Color get accentColor => themeData.colorScheme.secondary;
  Color get canvasColor => themeData.canvasColor;
  Color get shadowColor => themeData.shadowColor;
  Color get errorColor => themeData.errorColor;
  Color get hintColor => themeData.hintColor;
  Color get dividerColor => themeData.dividerColor;
  Color get disabledColor => themeData.disabledColor;
  Color get highlightColor => themeData.highlightColor;
  Color get splashColor => themeData.splashColor;
  Color get selectedRowColor => themeData.selectedRowColor;
  Color get unselectedWidgetColor => themeData.unselectedWidgetColor;
  Color get secondaryHeaderColor => themeData.secondaryHeaderColor;

  TextStyle? get textThemeHeadline1 => textTheme.headline1;
  TextStyle? get textThemeHeadline2 => textTheme.headline2;
  TextStyle? get textThemeHeadline3 => textTheme.headline3;
  TextStyle? get textThemeHeadline4 => textTheme.headline4;
  TextStyle? get textThemeHeadline5 => textTheme.headline5;
  TextStyle? get textThemeHeadline6 => textTheme.headline6;
  TextStyle? get textThemeSubtitle1 => textTheme.subtitle1;
  TextStyle? get textThemeSubtitle2 => textTheme.subtitle2;
  TextStyle? get textThemeBodyText1 => textTheme.bodyText1;
  TextStyle? get textThemeBodyText2 => textTheme.bodyText2;
  TextStyle? get textThemeButton => textTheme.button;
  TextStyle? get textThemeCaption => textTheme.caption;
  TextStyle? get textThemeOverline => textTheme.overline;

  NavigatorState get navigator => Navigator.of(this);
}
