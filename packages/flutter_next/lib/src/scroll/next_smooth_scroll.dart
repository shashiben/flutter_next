import 'package:flutter/material.dart';

import 'next_scroll_config.dart';
import 'next_scroll_controller.dart';

/// Publishes a [NextScrollController] for scroll views in [child].
///
/// Place it around a page, including as [MaterialApp.home], or around one
/// scroll view. A vertical list with no controller of its own inherits it on
/// every platform. The first list to inherit blocks descendants, not siblings.
/// A list that already has a controller keeps that controller.
///
/// [MaterialApp.scrollBehavior] and [MaterialApp.builder] cannot install this.
/// Each route inserts its own plain [PrimaryScrollController] inside the
/// navigator, closer to the page than [MaterialApp.builder].
class NextSmoothScroll extends StatefulWidget {
  /// Creates a scope. [config] defaults to lenis and [scrollDirection] to vertical.
  const NextSmoothScroll({
    required this.child,
    this.config = const NextScrollConfig.lenis(),
    this.scrollDirection = Axis.vertical,
    super.key,
  });

  /// Subtree whose primary scroll views inherit [config].
  final Widget child;

  /// Wheel tuning for this subtree.
  final NextScrollConfig config;

  /// Axis that inherits this scope. A horizontal list needs [Axis.horizontal].
  final Axis scrollDirection;

  @override
  State<NextSmoothScroll> createState() => _NextSmoothScrollState();
}

class _NextSmoothScrollState extends State<NextSmoothScroll> {
  late final NextScrollController _controller = NextScrollController(
    config: widget.config,
  );

  @override
  void didUpdateWidget(NextSmoothScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.config = widget.config;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _controller,
      scrollDirection: widget.scrollDirection,
      automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
      child: widget.child,
    );
  }
}
