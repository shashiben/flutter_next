import '../../flutter_next.dart';

class NextButton extends StatelessWidget {
  /// Title of the button or else you can customise using itemBuilder
  final String title;

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
  final Widget Function(BuildContext context, bool isHovered)? itemBuilder;

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
  const NextButton(
      {Key? key,
      this.leading,
      this.itemBuilder,
      this.enabled = true,
      this.trailing,
      this.title = "",
      this.style,
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
      this.disabledElevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: HoverWidget(
          hoverDuration: hoverDuration ?? const Duration(milliseconds: 800),
          builder: (context, isHovered) {
            if (itemBuilder != null) {
              return (itemBuilder!(context, isHovered)).onTap(() {
                if (onPressed != null) {
                  onPressed!();
                }
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
                      child: Text(
                        title,
                        style: style,
                      ),
                    ));
              } else if (variant == NextButtonVariant.outlined) {
                return NextColorTweenWidget(
                    beginColor: color ?? context.themeData.backgroundColor,
                    endColor: outlineColor ?? context.primaryColor,
                    child: (controller, value) {
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
                            child: Text(
                              title,
                              style: (style ??
                                      context.themeData.textTheme.button ??
                                      const TextStyle(
                                          fontWeight: FontWeight.w600))
                                  .copyWith(
                                      color: isHovered
                                          ? color ??
                                              context.themeData.backgroundColor
                                          : outlineColor ??
                                              context.primaryColor),
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
