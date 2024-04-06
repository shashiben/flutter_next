import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget container(
          {Key? key,
          AlignmentGeometry? alignment,
          EdgeInsetsGeometry? padding,
          Color? color,
          Decoration? decoration,
          Decoration? foregroundDecoration,
          double? width,
          double? height,
          BoxConstraints? constraints,
          EdgeInsetsGeometry? margin,
          Matrix4? transform,
          AlignmentGeometry? transformAlignment,
          Clip clipBehavior = Clip.none,
          bool shouldAnimate = false,
          Duration animationDuration = const Duration(milliseconds: 450)}) =>
      shouldAnimate
          ? AnimatedContainer(
              decoration: decoration,
              alignment: alignment,
              padding: padding,
              color: color,
              clipBehavior: clipBehavior,
              duration: animationDuration,
              foregroundDecoration: foregroundDecoration,
              width: width,
              height: height,
              constraints: constraints,
              transform: transform,
              transformAlignment: transformAlignment,
              margin: margin,
              child: this,
            )
          : Container(
              decoration: decoration,
              alignment: alignment,
              padding: padding,
              color: color,
              clipBehavior: clipBehavior,
              foregroundDecoration: foregroundDecoration,
              width: width,
              height: height,
              constraints: constraints,
              transform: transform,
              transformAlignment: transformAlignment,
              margin: margin,
              child: this,
            );
  Widget addDecoration(BoxDecoration decoration) => DecoratedBox(
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
        flex: flex,
        fit: fit,
        child: this,
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
    final BoxDecoration decoration = BoxDecoration(
      boxShadow: <BoxShadow>[
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
      decoration: decoration,
      child: this,
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
        clipper: clipper,
        clipBehavior: clipBehavior,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? all ?? 0.0),
          topRight: Radius.circular(topRight ?? all ?? 0.0),
          bottomLeft: Radius.circular(bottomLeft ?? all ?? 0.0),
          bottomRight: Radius.circular(bottomRight ?? all ?? 0.0),
        ),
        child: this,
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
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      maintainBottomViewPadding: maintainBottomViewPadding,
      minimum: minimum,
      child: this,
    );
  }
}
