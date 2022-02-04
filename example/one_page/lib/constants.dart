import 'package:flutter/material.dart';

List<String> prefixesList = ['xl', 'lg', 'md', 'sm', 'xs'];
List<String> prefixesReversedList = prefixesList.reversed.toList();
List<String> allPrefixList = ['xl', 'lg', 'md', 'sm', 'xs'];

double oneColumnRatio = 0.083333;
double gutterSize = 48.0;
int numberOfColumns = 12;

mixin Prefixes {
  static const String xl = 'xl';
  static const String lg = 'lg';
  static const String md = 'md';
  static const String sm = 'sm';
}
mixin ArgPrefixType {
  static const String order = 'order';
  static const String col = 'col';
  static const String offset = 'offset';
}
enum GridPrefixes { xl, lg, md, sm, xs }
enum NextVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark
}
mixin NextColorVariants {
  static Color primary = const Color(0xFF007BFF);
  static Color secondary = const Color(0xFF6c757d);
  static Color success = const Color(0xFF28a745);
  static Color danger = const Color(0xFFdc3545);
  static Color warning = const Color(0xFFffc107);
  static Color info = const Color(0xFF17a2b8);
  static Color light = const Color(0xFFf8f9fa);
  static Color dark = const Color(0xFF343a40);
}
mixin NextTextStyles {
  static TextStyle primary = const TextStyle();
  static TextStyle secondary = const TextStyle();
  static TextStyle success = const TextStyle();
  static TextStyle danger = const TextStyle();
  static TextStyle warning = const TextStyle();
  static TextStyle info = const TextStyle();
  static TextStyle light = const TextStyle();
  static TextStyle dark = const TextStyle();
}
