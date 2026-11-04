/// How a discrete mouse-wheel notch catches up to its target.
enum NextScrollKind {
  /// Exponential decay. Lower [NextScrollConfig.damping] feels heavier.
  lenis,

  /// Closes the gap over [NextScrollConfig.duration].
  linear,

  /// Spring toward the target, clamped to the scroll extents.
  elastic,

  /// Applies the wheel delta on the same frame.
  direct,
}

/// Tuning for [NextScrollKind].
class NextScrollConfig {
  /// Exponential decay. [scrollSpeed] defaults to 1.2 and [damping] to 0.08.
  const NextScrollConfig.lenis({this.scrollSpeed = 1.2, this.damping = 0.08})
    : kind = NextScrollKind.lenis,
      duration = const Duration(milliseconds: 300),
      stiffness = 100,
      springDamping = 10,
      assert(scrollSpeed > 0, 'scrollSpeed must be positive'),
      assert(
        damping > 0 && damping <= 1,
        'damping must be greater than 0 and at most 1',
      );

  /// Constant approach over [duration], which defaults to 300ms.
  const NextScrollConfig.linear({
    this.scrollSpeed = 1.2,
    this.duration = const Duration(milliseconds: 300),
  }) : kind = NextScrollKind.linear,
       damping = 0.08,
       stiffness = 100,
       springDamping = 10,
       assert(scrollSpeed > 0, 'scrollSpeed must be positive'),
       assert(duration > Duration.zero, 'duration must be positive');

  /// Spring follow. [stiffness] defaults to 100 and [springDamping] to 10.
  const NextScrollConfig.elastic({
    this.scrollSpeed = 1.2,
    this.stiffness = 100,
    this.springDamping = 10,
  }) : kind = NextScrollKind.elastic,
       damping = 0.08,
       duration = const Duration(milliseconds: 300),
       assert(scrollSpeed > 0, 'scrollSpeed must be positive'),
       assert(stiffness > 0, 'stiffness must be positive'),
       assert(springDamping > 0, 'springDamping must be positive');

  /// Same-frame wheel scrolling. [scrollSpeed] defaults to 1.
  const NextScrollConfig.direct({this.scrollSpeed = 1})
    : kind = NextScrollKind.direct,
      damping = 1,
      duration = Duration.zero,
      stiffness = 100,
      springDamping = 10,
      assert(scrollSpeed > 0, 'scrollSpeed must be positive');

  /// Which integration to run for a discrete notch.
  final NextScrollKind kind;

  /// Multiplier applied to the wheel delta before it is integrated.
  final double scrollSpeed;

  /// Per-frame fraction at 60Hz for [NextScrollKind.lenis].
  final double damping;

  /// Time over which [NextScrollKind.linear] closes the current gap.
  final Duration duration;

  /// Spring force scale for [NextScrollKind.elastic].
  final double stiffness;

  /// Velocity decay scale for [NextScrollKind.elastic].
  final double springDamping;
}
