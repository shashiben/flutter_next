import '../flutter_next.dart';

class NextButton extends StatelessWidget {
  ///isHovered represents whether widget is hovered or not
  final Widget Function(bool isHovered) child;

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
  final BorderRadiusGeometry? borderRadius;

  ///
  /// [Hover Duration] - Animation to reverse from hover to normal state
  /// [Animation Duration] - Duration of animation
  ///
  final Duration? animationDuration, hoverDuration;
  const NextButton(
      {Key? key,
      required this.child,
      this.onPressed,
      this.color,
      this.outlineColor,
      this.padding,
      this.margin,
      this.variant = NextButtonVariant.filled,
      this.borderRadius,
      this.animationDuration,
      this.hoverDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: HoverWidget(
            hoverDuration: hoverDuration ?? const Duration(milliseconds: 800),
            builder: (BuildContext context, bool isHovered) => variant ==
                    NextButtonVariant.filled
                ? Container(
                    margin: margin,
                    padding: padding,
                    decoration: BoxDecoration(
                        color: color ?? context.primaryColor,
                        borderRadius: borderRadius ?? BorderRadius.circular(5)),
                    child: child(isHovered),
                  )
                : AnimatedContainer(
                    duration:
                        animationDuration ?? const Duration(milliseconds: 300),
                    margin: margin,
                    padding: padding,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: color ?? context.primaryColor, width: 1.5),
                        color: isHovered
                            ? (color ?? context.primaryColor)
                            : outlineColor,
                        borderRadius: borderRadius ?? BorderRadius.circular(5)),
                    child: child(isHovered),
                  )));
  }
}
