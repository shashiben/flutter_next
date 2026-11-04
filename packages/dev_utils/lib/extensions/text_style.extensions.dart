import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A set of extensions on [TextStyle] that provides easy access to common text styling properties.
extension TextStyleExtensions on TextStyle {
  /// Sets the font weight to [FontWeight.w100] (thin).
  ///
  /// Example:
  /// ```dart
  /// Text('Thin Text', style: TextStyle().thin);
  /// ```
  TextStyle get thin => weight(FontWeight.w100);

  /// Sets the font weight to [FontWeight.w200] (extra light).
  ///
  /// Example:
  /// ```dart
  /// Text('Extra Light Text', style: TextStyle().extraLight);
  /// ```
  TextStyle get extraLight => weight(FontWeight.w200);

  /// Sets the font weight to [FontWeight.w300] (light).
  ///
  /// Example:
  /// ```dart
  /// Text('Light Text', style: TextStyle().light);
  /// ```
  TextStyle get light => weight(FontWeight.w300);

  /// Sets the font weight to [FontWeight.normal] (regular).
  ///
  /// Example:
  /// ```dart
  /// Text('Regular Text', style: TextStyle().regular);
  /// ```
  TextStyle get regular => weight(FontWeight.normal);

  /// Sets the font weight to [FontWeight.w500] (medium).
  ///
  /// Example:
  /// ```dart
  /// Text('Medium Text', style: TextStyle().medium);
  /// ```
  TextStyle get medium => weight(FontWeight.w500);

  /// Sets the font weight to [FontWeight.w600] (semi-bold).
  ///
  /// Example:
  /// ```dart
  /// Text('Semi-bold Text', style: TextStyle().semiBold);
  /// ```
  TextStyle get semiBold => weight(FontWeight.w600);

  /// Sets the font weight to [FontWeight.w700] (bold).
  ///
  /// Example:
  /// ```dart
  /// Text('Bold Text', style: TextStyle().bold);
  /// ```
  TextStyle get bold => weight(FontWeight.w700);

  /// Sets the font weight to [FontWeight.w800] (extra-bold).
  ///
  /// Example:
  /// ```dart
  /// Text('Extra-bold Text', style: TextStyle().extraBold);
  /// ```
  TextStyle get extraBold => weight(FontWeight.w800);

  /// Sets the font weight to [FontWeight.w900] (black).
  ///
  /// Example:
  /// ```dart
  /// Text('Black Text', style: TextStyle().black);
  /// ```
  TextStyle get black => weight(FontWeight.w900);

  /// Shortcut for applying italics style.
  ///
  /// Example:
  /// ```dart
  /// Text('Italic Text', style: TextStyle().italic);
  /// ```
  TextStyle get italic => style(FontStyle.italic);

  /// Shortcut for applying underline to text.
  ///
  /// Example:
  /// ```dart
  /// Text('Underlined Text', style: TextStyle().underline);
  /// ```
  TextStyle get underline => textDecoration(TextDecoration.underline);

  /// Shortcut for applying line-through style.
  ///
  /// Example:
  /// ```dart
  /// Text('Line-through Text', style: TextStyle().lineThrough);
  /// ```
  TextStyle get lineThrough => textDecoration(TextDecoration.lineThrough);

  /// Shortcut for applying overline style.
  ///
  /// Example:
  /// ```dart
  /// Text('Overlined Text', style: TextStyle().overline);
  /// ```
  TextStyle get overline => textDecoration(TextDecoration.overline);

  /// Applies the given color to the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Colored Text', style: TextStyle().textColor(Colors.red));
  /// ```
  TextStyle textColor(Color v) => copyWith(color: v);

  /// Applies the given background color to the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Text with Background Color', style: TextStyle().textBackgroundColor(Colors.yellow));
  /// ```
  TextStyle textBackgroundColor(Color v) => copyWith(backgroundColor: v);

  /// Changes the font size of the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Large Text', style: TextStyle().size(24));
  /// ```
  TextStyle size(double v) => copyWith(fontSize: v);

  /// Scales the font size by the given factor.
  ///
  /// Example:
  /// ```dart
  /// Text('Scaled Text', style: TextStyle().scale(1.5));
  /// ```
  TextStyle scale(double v) =>
      copyWith(fontSize: fontSize != null ? fontSize! * v : null);

  /// Changes the font weight to the specified [FontWeight].
  ///
  /// Example:
  /// ```dart
  /// Text('Bold Text', style: TextStyle().weight(FontWeight.w600));
  /// ```
  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  /// Changes the font style to the specified [FontStyle].
  ///
  /// Example:
  /// ```dart
  /// Text('Italic Text', style: TextStyle().style(FontStyle.italic));
  /// ```
  TextStyle style(FontStyle v) => copyWith(fontStyle: v);

  /// Changes the letter spacing of the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Spaced Text', style: TextStyle().letterSpace(2.0));
  /// ```
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  /// Changes the word spacing of the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Spaced Words', style: TextStyle().wordSpace(3.0));
  /// ```
  TextStyle wordSpace(double v) => copyWith(wordSpacing: v);

  /// Changes the text baseline alignment.
  ///
  /// Example:
  /// ```dart
  /// Text('Baseline Text', style: TextStyle().baseline(TextBaseline.alphabetic));
  /// ```
  TextStyle baseline(TextBaseline v) => copyWith(textBaseline: v);

  /// Adjusts the line height (leading) of the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Line Height Adjusted', style: TextStyle().textHeight(1.5));
  /// ```
  TextStyle textHeight(double v) => copyWith(height: v);

  /// Sets the locale of the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Localized Text', style: TextStyle().textLocale(Locale('en', 'US')));
  /// ```
  TextStyle textLocale(Locale v) => copyWith(locale: v);

  /// Applies a foreground paint to the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Text with Foreground', style: TextStyle().textForeground(Paint()));
  /// ```
  TextStyle textForeground(Paint v) => copyWith(foreground: v);

  /// Applies a background paint to the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Text with Background Paint', style: TextStyle().textBackground(Paint()));
  /// ```
  TextStyle textBackground(Paint v) => copyWith(background: v);

  /// Adds shadows to the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Text with Shadows', style: TextStyle().textShadows([Shadow(color: Colors.black, blurRadius: 2)]));
  /// ```
  TextStyle textShadows(List<Shadow> v) => copyWith(shadows: v);

  /// Applies a list of font features to the text.
  ///
  /// Example:
  /// ```dart
  /// Text('Text with Font Features', style: TextStyle().textFeatures([FontFeature.enable('smcp')]));
  /// ```
  TextStyle textFeatures(List<FontFeature> v) => copyWith(fontFeatures: v);

  /// Adds a text decoration with optional style, color, and thickness.
  ///
  /// Example:
  /// ```dart
  /// Text('Underlined Text with Style', style: TextStyle().textDecoration(TextDecoration.underline, color: Colors.red));
  /// ```
  TextStyle textDecoration(
    TextDecoration v, {
    Color? color,
    TextDecorationStyle? style,
    double? thickness,
  }) => copyWith(
    decoration: v,
    decorationColor: color,
    decorationStyle: style,
    decorationThickness: thickness,
  );
}
