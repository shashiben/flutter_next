import '../flutter_next.dart';

class NextAlert extends Text {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final NextVariant variant;
  final BorderRadiusGeometry borderRadius;
  final Widget? heading;
  final double? width;
  const NextAlert(
    String data, {
    Key? key,
    this.heading,
    this.width,
    required this.variant,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : super(
          data,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOverride(context)) {
      effectiveTextStyle = effectiveTextStyle!
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    Widget result = RichText(
      textAlign: textAlign ?? TextAlign.left,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow:
          overflow ?? effectiveTextStyle?.overflow ?? defaultTextStyle.overflow,
      textScaleFactor: textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.of(context),
      text: TextSpan(
        style: style ??
            TextStyle(
                color: NextVariantUtils.getColorByVariant(variant),
                fontSize: 16,
                fontWeight: FontWeight.w400),
        text: data,
        children: textSpan != null ? <InlineSpan>[textSpan!] : null,
      ),
    );
    if (semanticsLabel != null) {
      result = Semantics(
        textDirection: textDirection,
        label: semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return Container(
      width: width ?? double.maxFinite,
      child: result,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: NextVariantUtils.getColorByVariant(variant).withOpacity(0.2),
          borderRadius: borderRadius,
          border: Border.all(
              width: 0.75, color: NextVariantUtils.getColorByVariant(variant))),
    );
  }
}
