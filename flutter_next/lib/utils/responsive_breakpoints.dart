/// 📏 Enum representing all supported screen breakpoints
enum Breakpoint {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
}

/// List of breakpoints in order from smallest to largest
const List<Breakpoint> kBreakpoints = [
  Breakpoint.xs,
  Breakpoint.sm,
  Breakpoint.md,
  Breakpoint.lg,
  Breakpoint.xl,
  Breakpoint.xxl,
];

/// Returns the string label of a [Breakpoint] enum
String breakpointToString(Breakpoint bp) {
  return bp.name; // .name returns 'xs', 'sm', etc. in Dart >=2.15
}

/// 🧠 Get the breakpoint based on screen width.
///
/// | Width      | Breakpoint |
/// |------------|------------|
/// | ≥ 1400     | xxl        |
/// | ≥ 1200     | xl         |
/// | ≥ 992      | lg         |
/// | ≥ 768      | md         |
/// | ≥ 576      | sm         |
/// | < 576      | xs         |
Breakpoint breakpointForWidth(double width) {
  if (width >= 1400) return Breakpoint.xxl;
  if (width >= 1200) return Breakpoint.xl;
  if (width >= 992) return Breakpoint.lg;
  if (width >= 768) return Breakpoint.md;
  if (width >= 576) return Breakpoint.sm;
  return Breakpoint.xs;
}
