import 'package:flutter/material.dart';
import '../flutter_next.dart';

/// A customizable alert widget with optional heading and trailing widgets.
///
/// The alert can be customized with various styles, margins, paddings, and more.
/// It also supports custom transition animations.
class NextAlert extends StatelessWidget {
  /// Creates a [NextAlert].
  ///
  /// The [visible], [borderRadius], [variant], and [verticalHeadingSpace] arguments must not be null.
  /// If [variant] is [NextVariant.custom], then [customConfigs] must not be null.
  const NextAlert({
    super.key,
    this.visible = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.trailing,
    this.heading,
    this.onClosePressed,
    this.variant = NextVariant.primary,
    this.textStyle,
    this.verticalHeadingSpace = 10.0,
    this.headingTextStyle,
    this.customConfigs,
    this.margin,
    this.padding,
    this.child,
    this.transitionBuilder,
  });

  /// Whether the alert is visible.
  final bool visible;

  /// The heading widget for the alert.
  final Widget? heading;

  /// The trailing widget for the alert. Typically a close button.
  final Widget? trailing;

  /// The child widget for the alert.
  final Widget? child;

  /// The style variant for the alert.
  final NextVariant variant;

  /// The text style for the alert.
  final TextStyle? textStyle;

  /// The text style for the heading.
  final TextStyle? headingTextStyle;

  /// The margin for the alert.
  final EdgeInsetsGeometry? margin;

  /// The padding for the alert.
  final EdgeInsetsGeometry? padding;

  /// The border radius for the alert.
  final BorderRadiusGeometry borderRadius;

  /// The callback that is called when the close button is pressed.
  final void Function()? onClosePressed;

  /// The custom transition builder for the alert.
  final Widget Function(Widget, Animation<double>)? transitionBuilder;

  /// The vertical space between the heading and the child.
  final double verticalHeadingSpace;

  /// The custom configurations for the alert. Only used when [variant] is [NextVariant.custom].
  final NextAlertColorUtil? customConfigs;

  @override
  Widget build(BuildContext context) {
    final NextAlertColorUtil config = variant == NextVariant.custom
        ? customConfigs ?? NextAlertColorUtil.danger
        : NextVariantUtil.getColorUtil(variant);

    return AnimatedSwitcher(
      transitionBuilder: transitionBuilder ?? _defaultTransitionBuilder,
      duration: const Duration(milliseconds: 500),
      child: !visible ? const SizedBox.shrink() : _buildAlertContainer(config),
    );
  }

  Widget _defaultTransitionBuilder(Widget child, Animation<double> animation) {
    return ScaleTransition(
      alignment: Alignment.topLeft,
      scale: animation,
      child: child,
    );
  }

  Widget _buildAlertContainer(NextAlertColorUtil config) {
    return Container(
      margin: margin,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: config.borderColor, width: 0.5),
      ),
      child: _buildAlertContent(config),
    );
  }

  Widget _buildAlertContent(NextAlertColorUtil config) {
    return DefaultTextStyle(
      style: TextStyle(color: config.color, fontSize: 16.0).merge(textStyle),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildAlertChildren(config),
            ),
          ),
          trailing ?? _buildDefaultTrailingButton(config),
        ],
      ),
    );
  }

  List<Widget> _buildAlertChildren(NextAlertColorUtil config) {
    final List<Widget> children = <Widget>[];
    if (heading != null) {
      children.add(
        DefaultTextStyle(
          style: TextStyle(
              color: config.color, fontSize: 24.0, fontWeight: FontWeight.bold),
          child: Container(
            padding: EdgeInsets.only(bottom: verticalHeadingSpace),
            child: heading,
          ),
        ),
      );
    }
    if (child != null) {
      children.add(child!);
    }
    return children;
  }

  Widget _buildDefaultTrailingButton(NextAlertColorUtil config) {
    return TextButton(
      style: TextButton.styleFrom(minimumSize: const Size(30.0, 30.0)),
      onPressed: onClosePressed,
      child: Icon(Icons.close, size: 14.0, color: config.color),
    );
  }
}
