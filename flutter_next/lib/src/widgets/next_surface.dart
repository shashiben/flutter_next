import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../utils/next_colors.dart';
import '../utils/shadows/next_shadow.dart';

/// A card that uses [NextColors] and lifts on hover.
class NextSurface extends StatefulWidget {
  /// Creates a surface.
  const NextSurface({
    required this.child,
    this.variant = NextVariant.primary,
    this.elevation = 200,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.liftOnHover = true,
    this.onTap,
    super.key,
  });

  /// Contents.
  final Widget child;

  /// Color set from [NextColors].
  final NextVariant variant;

  /// Shadow preset from 100 to 800.
  final int elevation;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  /// Corner radius.
  final BorderRadius borderRadius;

  /// Moves the card up by 4 pixels while the pointer is over it.
  final bool liftOnHover;

  /// Tap callback. When null, the card does not look tappable.
  final VoidCallback? onTap;

  @override
  State<NextSurface> createState() => _NextSurfaceState();
}

class _NextSurfaceState extends State<NextSurface> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = NextColors.of(context).setFor(widget.variant);
    final lifted = _hovered && widget.liftOnHover;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, lifted ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: widget.borderRadius,
          border: Border.all(color: colors.border),
          boxShadow: NextShadow.level(
            context,
            lifted ? widget.elevation + 100 : widget.elevation,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: widget.borderRadius,
            child: Padding(
              padding: widget.padding,
              child: DefaultTextStyle.merge(
                style: TextStyle(color: colors.foreground),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
