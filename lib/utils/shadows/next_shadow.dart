import 'package:flutter/material.dart';

class NextShadow {
  static List<BoxShadow> shadow100({Color? color}) => [
        BoxShadow(
            blurStyle: BlurStyle.solid,
            offset: const Offset(0, 4),
            spreadRadius: -2,
            blurRadius: 4,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.08)),
        BoxShadow(
            offset: const Offset(0, 2),
            spreadRadius: -2,
            blurRadius: 4,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
  static List<BoxShadow> shadow200({Color? color}) => [
        BoxShadow(
            offset: const Offset(0, 8),
            spreadRadius: -4,
            blurRadius: 8,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.08)),
        BoxShadow(
            offset: const Offset(0, 4),
            spreadRadius: -4,
            blurRadius: 6,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
  static List<BoxShadow> shadow300({Color? color}) => [
        BoxShadow(
            offset: const Offset(0, 8),
            spreadRadius: -6,
            blurRadius: 16,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.08)),
        BoxShadow(
            offset: const Offset(0, 6),
            spreadRadius: -6,
            blurRadius: 8,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
  static List<BoxShadow> shadow400({Color? color}) => [
        BoxShadow(
            offset: const Offset(0, 8),
            spreadRadius: -4,
            blurRadius: 24,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.08)),
        BoxShadow(
            offset: const Offset(0, 6),
            spreadRadius: -6,
            blurRadius: 12,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
  static List<BoxShadow> shadow500({Color? color}) => [
        BoxShadow(
            offset: const Offset(0, 10),
            spreadRadius: -4,
            blurRadius: 32,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.10)),
        BoxShadow(
            offset: const Offset(0, 6),
            spreadRadius: -6,
            blurRadius: 14,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
  static List<BoxShadow> shadow600({Color? color}) => [
        BoxShadow(
            offset: const Offset(0, 12),
            spreadRadius: -4,
            blurRadius: 42,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12)),
        BoxShadow(
            offset: const Offset(0, 8),
            spreadRadius: -6,
            blurRadius: 18,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
  static List<BoxShadow> shadow700({Color? color}) => [
        BoxShadow(
            offset: const Offset(0, 14),
            spreadRadius: -4,
            blurRadius: 64,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12)),
        BoxShadow(
            offset: const Offset(0, 8),
            spreadRadius: -6,
            blurRadius: 22,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
  static List<BoxShadow> shadow800({Color? color}) => [
        BoxShadow(
            offset: const Offset(0, 18),
            spreadRadius: -4,
            blurRadius: 88,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.14)),
        BoxShadow(
            offset: const Offset(0, 8),
            spreadRadius: -6,
            blurRadius: 28,
            color: (color ?? const Color(0xFF18274B)).withOpacity(0.12))
      ];
}
