import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextButton extends StatelessWidget {
  const NextButton(
      {super.key,
      this.leading,
      this.itemBuilder,
      this.enabled = true,
      this.trailing,
      this.style,
      this.child,
      this.onPressed,
      this.color,
      this.outlineColor,
      this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      this.margin = const EdgeInsets.all(4),
      this.variant = NextButtonVariant.filled,
      this.borderRadius = const BorderRadius.all(Radius.circular(6)),
      this.animationDuration,
      this.hoverDuration,
      this.elevation,
      this.focusElevation,
      this.hoverElevation,
      this.highlightElevation,
      this.disabledElevation});

  /// Main Child
  final Widget? child;

  /// Text style for the title
  final TextStyle? style;

  /// Leading Widget
  final Widget? leading;

  /// Trailing Widget
  final Widget? trailing;

  ///Padding for the button
  final EdgeInsets padding;

  ///Margin around the button
  final EdgeInsets margin;

  ///On Tap of button what should happen
  final void Function()? onPressed;

  /// Color of button if null takes primary Color
  final Color? color;

  /// Outline Color is the border color
  final Color? outlineColor;

  ///
  /// Variant of button whether it should be outlined or filled
  ///
  final NextButtonVariant variant;

  ///
  /// Represents the radius of button
  ///
  final BorderRadiusGeometry borderRadius;

  ///
  /// Customise your button
  ///
  final Widget Function(BuildContext context, bool isHovered, Color? color)?
      itemBuilder;

  ///
  /// [Hover Duration] - Animation to reverse from hover to normal state
  /// [Animation Duration] - Duration of animation
  ///
  final Duration? animationDuration, hoverDuration;

  ///If [enabled]->false then onPressed wont work
  final bool enabled;

  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: HoverableWidget(
          hoverTransitionDuration:
              hoverDuration ?? const Duration(milliseconds: 800),
          hoverBuilder: (BuildContext context, bool isHovered) {
            if (itemBuilder != null) {
              return NextColorTweenWidget(
                  beginColor: color ?? context.themeData.colorScheme.background,
                  endColor: outlineColor ?? context.primaryColor,
                  child: (AnimationController controller, Color? value) {
                    if (isHovered) {
                      controller.forward();
                    } else {
                      controller.reverse();
                    }
                    return itemBuilder!(context, isHovered, value).onTap(() {
                      if (onPressed != null) {
                        onPressed!();
                      }
                    });
                  });
            } else {
              if (variant == NextButtonVariant.filled) {
                return MaterialButton(
                    padding: EdgeInsets.zero,
                    elevation: elevation ?? 0.0,
                    hoverElevation: hoverElevation ?? 0.0,
                    focusElevation: focusElevation,
                    disabledElevation: disabledElevation,
                    highlightElevation: highlightElevation,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                    color: color ?? context.primaryColor,
                    onPressed: onPressed,
                    child: Padding(
                      padding: padding,
                      child: child,
                    ));
              } else if (variant == NextButtonVariant.outlined) {
                return NextColorTweenWidget(
                    beginColor:
                        color ?? context.themeData.colorScheme.background,
                    endColor: outlineColor ?? context.primaryColor,
                    child: (AnimationController controller, Color? value) {
                      if (isHovered) {
                        controller.forward();
                      } else {
                        controller.reverse();
                      }
                      return MaterialButton(
                          padding: EdgeInsets.zero,
                          elevation: elevation ?? 0.0,
                          hoverElevation: hoverElevation ?? 0.0,
                          focusElevation: focusElevation,
                          disabledElevation: disabledElevation,
                          highlightElevation: highlightElevation,
                          shape: RoundedRectangleBorder(
                              borderRadius: borderRadius,
                              side: BorderSide(
                                  width: 1.5,
                                  color: outlineColor ?? context.primaryColor)),
                          color: value,
                          onPressed: onPressed,
                          child: Padding(
                            padding: padding,
                            child: DefaultTextStyle(
                              style: (style ??
                                      context.themeData.textTheme.labelLarge ??
                                      const TextStyle(
                                          fontWeight: FontWeight.w600))
                                  .copyWith(
                                      color: isHovered
                                          ? color ??
                                              context.themeData.colorScheme
                                                  .background
                                          : outlineColor ??
                                              context.primaryColor),
                              child: child ?? const SizedBox(),
                            ),
                          ));
                    });
              } else {
                return const BackButton();
              }
            }
          }),
    );
  }
}
