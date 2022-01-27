import '../flutter_next.dart';

class NextButton extends StatelessWidget {
  final Widget Function(bool isHovered) child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final void Function()? onPressed;
  final Color? color;
  final Color? outlineColor;

  final NextButtonVariant variant;
  final BorderRadiusGeometry? borderRadius;
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
