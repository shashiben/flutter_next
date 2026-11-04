import 'package:flutter/material.dart';

/// 🌟 Extension on [String] to quickly create a [Text] widget.
///
/// Example:
/// ```dart
/// 'Hello World'.text(); // 🚀 Instantly get a Text widget!
/// ```
extension TextWidgetExtensions on String {
  /// Converts a [String] to a [Text] widget.
  ///
  /// Example:
  /// ```dart
  /// 'Hello'.text(); // ✨ Simple and fast!
  /// ```
  Text text() {
    return Text(
      this,
    );
  }
}

/// 🎨 Extension on [Text] to apply Material text theme styles easily.
///
/// Example usage:
/// ```dart
/// Text('Headline Large').hl(context); // 🏷️ Headline Large
/// Text('Body Medium').bm(context, textAlign: TextAlign.center); // 📄 Centered Body Medium
/// ```
extension TextThemeExtensions on Text {
  /// 🏷️ Applies [ThemeData.textTheme.headlineLarge] style to the [Text] widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Headline Large').hl(context); // 🏷️
  /// ```
  Text hl(
    BuildContext context, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    String? semanticsIdentifier,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) =>
      Text(
        data ?? '',
        key: key,
        style: (style ?? Theme.of(context).textTheme.headlineLarge),
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: this.textAlign ?? textAlign,
        textDirection: this.textDirection ?? textDirection,
        locale: this.locale ?? locale,
        softWrap: this.softWrap ?? softWrap,
        overflow: this.overflow ?? overflow,
        textScaler: this.textScaler ?? textScaler,
        maxLines: this.maxLines ?? maxLines,
        semanticsLabel: this.semanticsLabel ?? semanticsLabel,
        semanticsIdentifier: this.semanticsIdentifier ?? semanticsIdentifier,
        textWidthBasis: this.textWidthBasis ?? textWidthBasis,
        textHeightBehavior: this.textHeightBehavior ?? textHeightBehavior,
        selectionColor: this.selectionColor ?? selectionColor,
      );

  /// 🏷️ Applies [ThemeData.textTheme.headlineMedium] style to the [Text] widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Headline Medium').hm(context); // 🏷️
  /// ```
  Text hm(
    BuildContext context, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    String? semanticsIdentifier,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) =>
      Text(
        data ?? '',
        key: key,
        style: (style ?? Theme.of(context).textTheme.headlineMedium),
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: this.textAlign ?? textAlign,
        textDirection: this.textDirection ?? textDirection,
        locale: this.locale ?? locale,
        softWrap: this.softWrap ?? softWrap,
        overflow: this.overflow ?? overflow,
        textScaler: this.textScaler ?? textScaler,
        maxLines: this.maxLines ?? maxLines,
        semanticsLabel: this.semanticsLabel ?? semanticsLabel,
        semanticsIdentifier: this.semanticsIdentifier ?? semanticsIdentifier,
        textWidthBasis: this.textWidthBasis ?? textWidthBasis,
        textHeightBehavior: this.textHeightBehavior ?? textHeightBehavior,
        selectionColor: this.selectionColor ?? selectionColor,
      );

  /// 🏷️ Applies [ThemeData.textTheme.headlineSmall] style to the [Text] widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Headline Small').hs(context); // 🏷️
  /// ```
  Text hs(
    BuildContext context, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    String? semanticsIdentifier,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) =>
      Text(
        data ?? '',
        key: key,
        style: (style ?? Theme.of(context).textTheme.headlineSmall),
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: this.textAlign ?? textAlign,
        textDirection: this.textDirection ?? textDirection,
        locale: this.locale ?? locale,
        softWrap: this.softWrap ?? softWrap,
        overflow: this.overflow ?? overflow,
        textScaler: this.textScaler ?? textScaler,
        maxLines: this.maxLines ?? maxLines,
        semanticsLabel: this.semanticsLabel ?? semanticsLabel,
        semanticsIdentifier: this.semanticsIdentifier ?? semanticsIdentifier,
        textWidthBasis: this.textWidthBasis ?? textWidthBasis,
        textHeightBehavior: this.textHeightBehavior ?? textHeightBehavior,
        selectionColor: this.selectionColor ?? selectionColor,
      );

  /// 📄 Applies [ThemeData.textTheme.bodyLarge] style to the [Text] widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Body Large').bl(context); // 📄
  /// ```
  Text bl(
    BuildContext context, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    String? semanticsIdentifier,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) =>
      Text(
        data ?? '',
        key: key,
        style: (style ?? Theme.of(context).textTheme.bodyLarge),
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: this.textAlign ?? textAlign,
        textDirection: this.textDirection ?? textDirection,
        locale: this.locale ?? locale,
        softWrap: this.softWrap ?? softWrap,
        overflow: this.overflow ?? overflow,
        textScaler: this.textScaler ?? textScaler,
        maxLines: this.maxLines ?? maxLines,
        semanticsLabel: this.semanticsLabel ?? semanticsLabel,
        semanticsIdentifier: this.semanticsIdentifier ?? semanticsIdentifier,
        textWidthBasis: this.textWidthBasis ?? textWidthBasis,
        textHeightBehavior: this.textHeightBehavior ?? textHeightBehavior,
        selectionColor: this.selectionColor ?? selectionColor,
      );

  /// 📄 Applies [ThemeData.textTheme.bodyMedium] style to the [Text] widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Body Medium').bm(context); // 📄
  /// ```
  Text bm(
    BuildContext context, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    String? semanticsIdentifier,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) =>
      Text(
        data ?? '',
        key: key,
        style: (style ?? Theme.of(context).textTheme.bodyMedium),
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: this.textAlign ?? textAlign,
        textDirection: this.textDirection ?? textDirection,
        locale: this.locale ?? locale,
        softWrap: this.softWrap ?? softWrap,
        overflow: this.overflow ?? overflow,
        textScaler: this.textScaler ?? textScaler,
        maxLines: this.maxLines ?? maxLines,
        semanticsLabel: this.semanticsLabel ?? semanticsLabel,
        semanticsIdentifier: this.semanticsIdentifier ?? semanticsIdentifier,
        textWidthBasis: this.textWidthBasis ?? textWidthBasis,
        textHeightBehavior: this.textHeightBehavior ?? textHeightBehavior,
        selectionColor: this.selectionColor ?? selectionColor,
      );

  /// 📄 Applies [ThemeData.textTheme.bodySmall] style to the [Text] widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Body Small').bs(context); // 📄
  /// ```
  Text bs(
    BuildContext context, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    String? semanticsIdentifier,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) =>
      Text(
        data ?? '',
        key: key,
        style: (style ?? Theme.of(context).textTheme.bodySmall),
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: this.textAlign ?? textAlign,
        textDirection: this.textDirection ?? textDirection,
        locale: this.locale ?? locale,
        softWrap: this.softWrap ?? softWrap,
        overflow: this.overflow ?? overflow,
        textScaler: this.textScaler ?? textScaler,
        maxLines: this.maxLines ?? maxLines,
        semanticsLabel: this.semanticsLabel ?? semanticsLabel,
        semanticsIdentifier: this.semanticsIdentifier ?? semanticsIdentifier,
        textWidthBasis: this.textWidthBasis ?? textWidthBasis,
        textHeightBehavior: this.textHeightBehavior ?? textHeightBehavior,
        selectionColor: this.selectionColor ?? selectionColor,
      );
}
