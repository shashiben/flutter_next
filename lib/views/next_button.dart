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
  final EdgeInsets? padding;

  ///Margin around the button
  final EdgeInsets? margin;

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
  const NextButton(
      {Key? key,
      this.leading,
      this.itemBuilder,
      this.enabled = true,
      this.trailing,
      required this.title,
      this.style,
      this.onPressed,
      this.color,
      this.outlineColor,
      this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      this.margin = const EdgeInsets.all(4),
      this.variant = NextButtonVariant.filled,
      this.borderRadius = const BorderRadius.all(Radius.circular(6)),
      this.animationDuration,
      this.hoverDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: HoverWidget(
          hoverDuration: hoverDuration ?? const Duration(milliseconds: 800),
          builder: (context, isHovered) {
            if (variant == NextButtonVariant.filled) {
              return MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  color: color ?? context.primaryColor,
                  onPressed: onPressed,
                  child: Text(
                    title,
                    style: style,
                  ));
            } else if (variant == NextButtonVariant.outlined) {
              return NextColorTweenWidget(
                  beginColor: context.themeData.backgroundColor,
                  endColor: color ?? context.primaryColor,
                  child: (controller, value) {
                    if (isHovered) {
                      controller.forward();
                    } else {
                      controller.reverse();
                    }
                    return MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: borderRadius,
                            side: BorderSide(
                                color: color ?? context.primaryColor)),
                        color: value,
                        onPressed: onPressed,
                        child: Text(
                          title,
                          style: style,
                        ));
                  });
            } else {
              return const BackButton();
            }
          }),
    );
  }
}
