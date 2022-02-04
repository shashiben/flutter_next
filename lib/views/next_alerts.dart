import 'package:nil/nil.dart';

import '../flutter_next.dart';
import 'dart:ui' as ui;

class NextAlert extends Text {
  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsets padding;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsets margin;

  /// Declare the type of [NextVariant] by default value is [NextVariant.success]
  final NextVariant variant;

  ///
  /// Round corner radius Default value is 4.
  ///
  final BorderRadiusGeometry borderRadius;

  ///
  /// To display heading of an alert
  ///
  final Widget? heading;

  ///
  /// Width of an alert
  ///
  final double? width;

  ///
  /// Trailing and leading widget to show button or an icon
  ///
  final Widget? leading, trailing;

  const NextAlert(
    String data, {
    Key? key,
    this.leading,
    this.trailing,
    InlineSpan? textSpan,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    ui.TextHeightBehavior? textHeightBehavior,
    this.heading,
    this.width,
    TextStyle? style,
    this.variant = NextVariant.success,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : super(data,
            key: key,
            semanticsLabel: semanticsLabel,
            softWrap: softWrap,
            locale: locale,
            overflow: overflow,
            maxLines: maxLines,
            style: style,
            textDirection: textDirection,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,
            textScaleFactor: textScaleFactor,
            strutStyle: strutStyle,
            textAlign: textAlign);

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
      child: Row(
        children: [
          leading ?? const Nil(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading ?? const Nil(),
              result,
            ],
          )),
          trailing ?? const Nil(),
        ],
      ),
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
