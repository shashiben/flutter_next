import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';

/// A spring curve. [transform] runs from 0 to 1 across the spring's settle time.
///
/// [clamp] keeps the value inside 0 and 1. That is Remotion's overshoot
/// clamping. Without it, a loose spring passes the target and comes back.
class NextSpring extends Curve {
  /// Creates a spring from its physical constants.
  const NextSpring({
    this.mass = 1,
    this.stiffness = 75,
    this.damping = 200,
    this.clamp = true,
  });

  /// Soft and clamped. Stiffness 75, damping 200, matching Remotion's default.
  static const NextSpring smooth = NextSpring();

  /// Critically damped. No bounce.
  static const NextSpring gentle = NextSpring(stiffness: 120, damping: 22);

  /// Fast, with the overshoot cut off.
  static const NextSpring snappy = NextSpring(stiffness: 380, damping: 26);

  /// Underdamped, so it passes the target and settles back.
  static const NextSpring bouncy = NextSpring(
    stiffness: 220,
    damping: 8,
    clamp: false,
  );

  /// Mass. Heavier springs take longer to settle.
  final double mass;

  /// Stiffness. Higher values pull toward the end faster.
  final double stiffness;

  /// Damping coefficient. Higher values kill bounce.
  final double damping;

  /// When true, the curve stays inside 0 and 1.
  final bool clamp;

  /// How long this spring takes to settle, in real time.
  ///
  /// Pass this as an animation duration to play the spring at its natural
  /// speed. The usual animation duration stretches the same shape into 500ms.
  Duration get settle => _run(mass, stiffness, damping).settle;

  @override
  double transformInternal(double t) {
    final run = _run(mass, stiffness, damping);
    final x = run.simulation.x(t * run.seconds);
    if (clamp) {
      return x.clamp(0.0, 1.0);
    }
    return x;
  }
}

final _runs = <(double, double, double), _SpringRun>{};

_SpringRun _run(double mass, double stiffness, double damping) {
  return _runs[(mass, stiffness, damping)] ??= _SpringRun(
    mass,
    stiffness,
    damping,
  );
}

class _SpringRun {
  _SpringRun(double mass, double stiffness, double damping)
    : simulation = SpringSimulation(
        SpringDescription(mass: mass, stiffness: stiffness, damping: damping),
        0,
        1,
        0,
      ) {
    var high = 0.05;
    if (!simulation.isDone(0)) {
      while (high < 30 && !simulation.isDone(high)) {
        high *= 1.5;
      }
      var low = 0.0;
      for (var i = 0; i < 24; i++) {
        final mid = (low + high) / 2;
        if (simulation.isDone(mid)) {
          high = mid;
        } else {
          low = mid;
        }
      }
    }
    seconds = high;
    settle = Duration(
      microseconds: (high * Duration.microsecondsPerSecond).round(),
    );
  }

  final SpringSimulation simulation;
  late final double seconds;
  late final Duration settle;
}
