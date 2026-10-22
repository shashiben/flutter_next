/// Screen-size steps used by the layout kit.
///
/// Widths are minimums. A width belongs to the largest breakpoint it has
/// reached.
enum Breakpoint {
  /// Below the small breakpoint.
  xs,

  /// Small screens.
  sm,

  /// Medium screens.
  md,

  /// Large screens.
  lg,

  /// Extra-large screens.
  xl,

  /// Extra-extra-large screens.
  xxl,
}

/// Breakpoints from smallest to largest.
const List<Breakpoint> kBreakpoints = <Breakpoint>[
  Breakpoint.xs,
  Breakpoint.sm,
  Breakpoint.md,
  Breakpoint.lg,
  Breakpoint.xl,
  Breakpoint.xxl,
];

/// Short name of [bp], such as `md`.
String breakpointToString(Breakpoint bp) => bp.name;

/// Breakpoint for [width] using [breakpoints], or the Bootstrap 5.3 defaults.
Breakpoint breakpointForWidth(
  double width, [
  Map<Breakpoint, double>? breakpoints,
]) {
  final table = breakpoints ?? defaultBreakpointWidths;
  if (width >=
      (table[Breakpoint.xxl] ?? defaultBreakpointWidths[Breakpoint.xxl]!)) {
    return Breakpoint.xxl;
  }
  if (width >=
      (table[Breakpoint.xl] ?? defaultBreakpointWidths[Breakpoint.xl]!)) {
    return Breakpoint.xl;
  }
  if (width >=
      (table[Breakpoint.lg] ?? defaultBreakpointWidths[Breakpoint.lg]!)) {
    return Breakpoint.lg;
  }
  if (width >=
      (table[Breakpoint.md] ?? defaultBreakpointWidths[Breakpoint.md]!)) {
    return Breakpoint.md;
  }
  if (width >=
      (table[Breakpoint.sm] ?? defaultBreakpointWidths[Breakpoint.sm]!)) {
    return Breakpoint.sm;
  }
  return Breakpoint.xs;
}

/// Bootstrap 5.3 minimum widths.
const Map<Breakpoint, double> defaultBreakpointWidths = <Breakpoint, double>{
  Breakpoint.xs: 0,
  Breakpoint.sm: 576,
  Breakpoint.md: 768,
  Breakpoint.lg: 992,
  Breakpoint.xl: 1200,
  Breakpoint.xxl: 1400,
};

/// Bootstrap 5.3 container max widths. `null` means the full parent width.
const Map<Breakpoint, double?> defaultContainerMaxWidths =
    <Breakpoint, double?>{
      Breakpoint.xs: null,
      Breakpoint.sm: 540,
      Breakpoint.md: 720,
      Breakpoint.lg: 960,
      Breakpoint.xl: 1140,
      Breakpoint.xxl: 1320,
    };
