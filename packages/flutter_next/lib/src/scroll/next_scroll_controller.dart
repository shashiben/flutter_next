import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'next_scroll_config.dart';

/// A [ScrollController] whose positions ease pointer-scroll deltas.
///
/// Touch drags still move on the frame they arrive. A layout pass while
/// the ease is running does not cancel it.
/// Pass [config] to pick lenis, linear, elastic, or direct scrolling.
/// NextSmoothScroll keeps one of these for a subtree.
class NextScrollController extends ScrollController {
  /// Creates a controller. [config] defaults to lenis.
  NextScrollController({
    this.config = const NextScrollConfig.lenis(),
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  });

  /// Active tuning. Replacing this does not recreate attached positions.
  NextScrollConfig config;

  /// Whether any attached position is easing a wheel notch.
  @visibleForTesting
  bool get isEasing {
    for (final position in positions) {
      if (position is NextSmoothScrollPosition && position.isEasing) {
        return true;
      }
    }
    return false;
  }

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return NextSmoothScrollPosition(
      controller: this,
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }
}

/// Scroll position that eases a wheel notch toward a target.
class NextSmoothScrollPosition extends ScrollPositionWithSingleContext {
  /// Creates a position driven by [controller.config].
  NextSmoothScrollPosition({
    required this.controller,
    required super.physics,
    required super.context,
    super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
  });

  /// Controller that owns [NextScrollController.config].
  final NextScrollController controller;

  /// Whether the ease ticker is running.
  @visibleForTesting
  bool get isEasing => _ticker?.isActive ?? false;

  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;
  double _target = 0;
  double _velocity = 0;
  bool _reportedScroll = false;
  bool _settling = false;

  static const double _restDistance = 0.5;
  static const double _maxFrameSeconds = 0.032;
  static const double _frameSeconds = 1 / 60;

  @override
  void pointerScroll(double delta) {
    if (!hasPixels || !hasContentDimensions) {
      super.pointerScroll(delta);
      return;
    }
    if (delta == 0.0) {
      _stopEase();
      super.pointerScroll(0);
      return;
    }
    if (_prefersDirect) {
      _stopEase();
      super.pointerScroll(delta * controller.config.scrollSpeed);
      _target = pixels;
      return;
    }

    if (!isEasing) {
      _target = pixels;
    }
    final scaled = delta * controller.config.scrollSpeed;
    _target = (_target + scaled).clamp(minScrollExtent, maxScrollExtent);
    if ((_target - pixels).abs() < _restDistance) {
      return;
    }
    updateUserScrollDirection(
      scaled < 0 ? ScrollDirection.forward : ScrollDirection.reverse,
    );
    _beginEase();
  }

  bool get _prefersDirect {
    if (controller.config.kind == NextScrollKind.direct) {
      return true;
    }
    final notificationContext = context.notificationContext;
    if (notificationContext == null) {
      return false;
    }
    return MediaQuery.disableAnimationsOf(notificationContext);
  }

  @override
  void applyUserOffset(double delta) {
    _stopEase();
    super.applyUserOffset(delta);
    _target = pixels;
  }

  @override
  void jumpTo(double value) {
    _stopEase();
    super.jumpTo(value);
    _target = pixels;
  }

  @override
  void goBallistic(double velocity) {
    // A growing list calls this every frame. Stopping here cuts the glide.
    if (isEasing && !_settling) {
      return;
    }
    super.goBallistic(velocity);
  }

  @override
  ScrollHoldController hold(VoidCallback holdCancelCallback) {
    _stopEase();
    return super.hold(holdCancelCallback);
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    super.dispose();
  }

  void _beginEase() {
    if (!_reportedScroll) {
      _reportedScroll = true;
      isScrollingNotifier.value = true;
      didStartScroll();
    }
    goIdle();
    _ticker ??= context.vsync.createTicker(_onTick);
    if (!_ticker!.isActive) {
      _lastElapsed = Duration.zero;
      _ticker!.start();
    }
  }

  void _stopEase() {
    _ticker?.stop();
    _velocity = 0;
    if (_reportedScroll) {
      _reportedScroll = false;
      didEndScroll();
      isScrollingNotifier.value = false;
    }
    if (hasPixels) {
      _target = pixels;
    }
  }

  void _onTick(Duration elapsed) {
    if (!hasPixels || !hasContentDimensions) {
      _stopEase();
      return;
    }
    var dt =
        (elapsed - _lastElapsed).inMicroseconds /
        Duration.microsecondsPerSecond;
    _lastElapsed = elapsed;
    if (dt <= 0) {
      dt = _frameSeconds;
    } else if (dt > _maxFrameSeconds) {
      dt = _maxFrameSeconds;
    }

    _target = _target.clamp(minScrollExtent, maxScrollExtent);
    final distance = _target - pixels;
    final next = switch (controller.config.kind) {
      NextScrollKind.lenis => pixels + distance * _lenisFactor(dt),
      NextScrollKind.linear => pixels + _linearStep(distance, dt),
      NextScrollKind.elastic => _elasticStep(distance, dt),
      NextScrollKind.direct => _target,
    };
    final clamped = next.clamp(minScrollExtent, maxScrollExtent);
    if (clamped != pixels) {
      final oldPixels = pixels;
      forcePixels(clamped);
      didUpdateScrollPositionBy(pixels - oldPixels);
    }

    final atRest =
        (_target - pixels).abs() < _restDistance &&
        _velocity.abs() < _restDistance;
    if (!atRest) {
      return;
    }
    _ticker?.stop();
    _velocity = 0;
    final settled = _target.clamp(minScrollExtent, maxScrollExtent);
    if (settled != pixels) {
      final oldPixels = pixels;
      forcePixels(settled);
      didUpdateScrollPositionBy(pixels - oldPixels);
    }
    if (_reportedScroll) {
      _reportedScroll = false;
      didEndScroll();
      isScrollingNotifier.value = false;
    }
    _settling = true;
    goBallistic(0);
    _settling = false;
  }

  double _lenisFactor(double dt) {
    final frames = dt / _frameSeconds;
    return 1 - math.pow(1 - controller.config.damping, frames).toDouble();
  }

  double _linearStep(double distance, double dt) {
    final duration =
        controller.config.duration.inMicroseconds /
        Duration.microsecondsPerSecond;
    if (duration <= 0) {
      return distance;
    }
    final step = distance * (dt / duration);
    if (step.abs() > distance.abs()) {
      return distance;
    }
    return step;
  }

  double _elasticStep(double distance, double dt) {
    _velocity += distance * controller.config.stiffness * dt;
    final decay = (1 - controller.config.springDamping * dt).clamp(0.0, 1.0);
    _velocity *= decay;
    return pixels + _velocity * dt;
  }
}
