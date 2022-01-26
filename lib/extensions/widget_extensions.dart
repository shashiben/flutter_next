import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget container(EdgeInsets? padding,
          {EdgeInsets? margin,
          bool shouldAnimate = false,
          Duration animationDuration = const Duration(milliseconds: 300),
          Curve? animationCurve}) =>
      shouldAnimate
          ? AnimatedContainer(
              duration: animationDuration,
              padding: padding,
              margin: margin,
              child: this,
            )
          : Container(
              padding: padding,
              margin: margin,
              child: this,
            );
  Widget decoration(BoxDecoration decoration) => DecoratedBox(
        decoration: decoration,
        child: this,
      );
  Widget center({
    Key? key,
    double? widthFactor,
    double? heightFactor,
  }) =>
      Center(
        key: key,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );

  Widget onTap(void Function() onTap) => InkWell(
        radius: 40,
        onTap: onTap,
        child: this,
      );
  Widget aspectRatio({
    Key? key,
    required double aspectRatio,
  }) =>
      AspectRatio(
        key: key,
        aspectRatio: aspectRatio,
        child: this,
      );

  Widget fittedBox({
    Key? key,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      FittedBox(
        key: key,
        fit: fit,
        alignment: alignment,
        child: this,
      );

  Widget fractionallySizedBox({
    Key? key,
    AlignmentGeometry alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) =>
      FractionallySizedBox(
        key: key,
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );
  Widget flexible({
    Key? key,
    int flex = 1,
    FlexFit fit = FlexFit.loose,
  }) =>
      Flexible(
        key: key,
        child: this,
        flex: flex,
        fit: fit,
      );
  Widget clipRect({
    Key? key,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      ClipRect(
        key: key,
        clipper: clipper,
        clipBehavior: clipBehavior,
        child: this,
      );

  Widget clipOval({
    Key? key,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) =>
      ClipOval(
        clipBehavior: clipBehavior,
        clipper: clipper,
        key: key,
        child: this,
      );
  Widget boxShadow({
    Key? key,
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    double spreadRadius = 0.0,
    bool animate = false,
  }) {
    BoxDecoration decoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: color,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: offset,
        ),
      ],
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget clipRRect({
    Key? key,
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
    bool animate = false,
  }) =>
      ClipRRect(
        key: key,
        child: this,
        clipper: clipper,
        clipBehavior: clipBehavior,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? all ?? 0.0),
          topRight: Radius.circular(topRight ?? all ?? 0.0),
          bottomLeft: Radius.circular(bottomLeft ?? all ?? 0.0),
          bottomRight: Radius.circular(bottomRight ?? all ?? 0.0),
        ),
      );
  Widget sizedBox({Key? key, double? width, double? height}) {
    return SizedBox(
      key: key,
      width: width,
      height: height,
      child: this,
    );
  }

  Widget safeArea({
    Key? key,
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) {
    return SafeArea(
      child: this,
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      maintainBottomViewPadding: maintainBottomViewPadding,
      minimum: minimum,
    );
  }
}
