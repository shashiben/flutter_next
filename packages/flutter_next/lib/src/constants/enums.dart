/// Visual tone shared by alerts, buttons, and surfaces.
enum NextVariant {
  /// Primary tone.
  primary,

  /// Secondary tone.
  secondary,

  /// Success tone.
  success,

  /// Danger tone.
  danger,

  /// Warning tone.
  warning,

  /// Info tone.
  info,

  /// Light tone.
  light,

  /// Dark tone.
  dark,

  /// Caller-supplied colors.
  custom,
}

/// Fill style for [NextButton].
enum NextButtonVariant {
  /// Solid fill.
  filled,

  /// Border only.
  outlined,
}

/// How a breadcrumb lays out when it overflows.
enum NextBreadcrumbVariant {
  /// Wraps onto the next line.
  wrap,

  /// Scrolls horizontally.
  scroll,
}
