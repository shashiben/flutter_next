import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextAlert extends StatelessWidget {
  /// Construct [NextAlert]
  const NextAlert(
      {Key? key,
      this.visible = true,
      this.borderRadius = const BorderRadius.all(Radius.circular(4)),
      this.trailing,
      this.heading,
      this.onClosedIconPressed,
      this.variant = NextVariant.primary,
      this.textStyle,
      this.verticalHeadingSpace = 10.0,
      this.headingTextStyle,
      this.customConfigs,
      this.margin,
      this.padding,
      this.child,
      this.transitionBuilder})
      : super(key: key);

  /// define visibility [NextAlert]
  final bool visible;

  /// define heading [NextAlert]
  final Widget? heading;

  /// By default trailing will be close button
  final Widget? trailing;

  /// define child [NextAlert]
  final Widget? child;

  /// define style [NextAlert]
  final NextVariant variant;

  /// define textStyle [NextAlert]
  final TextStyle? textStyle;

  /// define headingTextStyle [NextAlert]
  final TextStyle? headingTextStyle;

  /// define margin [NextAlert]
  final EdgeInsetsGeometry? margin;

  /// define padding [NextAlert]
  final EdgeInsetsGeometry? padding;

  ///BorderRadius for box
  final BorderRadiusGeometry borderRadius;

  /// on trailing button pressed
  final void Function()? onClosedIconPressed;

  ///Closing transition builder
  final Widget Function(Widget, Animation<double>)? transitionBuilder;

  ///Space between heading and child
  final double verticalHeadingSpace;

  ///Custom Configs for alert works only when variant is custom
  final NextAlertColorUtils? customConfigs;

  @override
  Widget build(BuildContext context) {
    final NextAlertColorUtils _config = variant == NextVariant.custom
        ? customConfigs ?? NextAlertColorUtils.danger
        : NextVariantUtils.getColorUtilsByVariant(variant);
    return AnimatedSwitcher(
      transitionBuilder: transitionBuilder ??
          (child, animation) {
            return ScaleTransition(
              alignment: Alignment.topLeft,
              scale: animation,
              child: child,
            );
          },
      duration: const Duration(milliseconds: 500),
      child: !visible
          ? const SizedBox()
          : Container(
              margin: margin,
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                  color: _config.backgroundColor,
                  borderRadius: borderRadius,
                  border: Border.all(color: _config.borderColor, width: 0.5)),
              child: DefaultTextStyle(
                style: TextStyle(color: _config.color, fontSize: 16.0)
                    .merge(textStyle),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (heading != null)
                          DefaultTextStyle(
                            style: TextStyle(
                                color: _config.color,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                            child: Container(
                              padding:
                                  EdgeInsets.only(bottom: verticalHeadingSpace),
                              child: heading,
                            ),
                          ),
                        if (child != null) child!,
                      ],
                    )),
                    trailing ??
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(30.0, 30.0),
                          ),
                          onPressed: onClosedIconPressed,
                          child: Icon(Icons.close,
                              size: 14.0, color: _config.color),
                        )
                  ],
                ),
              ),
            ),
    );
  }
}
