import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class FadeInAnimationExample extends StatelessWidget {
  const FadeInAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: NextFadeInVariant.values.asMap().entries.map((entry) {
      var e = entry.value;
      return NextFadeInAnimation(
        fadeInVariant: e,
        animationDuration: const Duration(milliseconds: 2500),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.orange,
          child: Center(
            child: Text(
              "FadeIn",
              style: context.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      );
    }).toList());
  }
}

class FadeOutAnimationExample extends StatelessWidget {
  const FadeOutAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: NextFadeOutVariant.values.asMap().entries.map((entry) {
      var e = entry.value;
      return NextFadeOutAnimation(
        fadeOutVariant: e,
        animationDuration: const Duration(milliseconds: 2500),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.orange,
          child: Center(
            child: Text(
              "FadeOut",
              style: context.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      );
    }).toList());
  }
}
