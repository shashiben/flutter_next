import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';

class FadeInAnimationExample extends StatelessWidget {
  const FadeInAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: NextFadeInVariant.values.asMap().entries.map((entry) {
        var e = entry.value;
        return NextFadeInAnimation(
          variant: e,
          duration: const Duration(milliseconds: 600),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.orange,
            child: Center(
              child: Text(
                "FadeIn",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        );
      }).toList(),
    );
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
          variant: e,
          duration: const Duration(milliseconds: 600),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.orange,
            child: Center(
              child: Text(
                "FadeOut",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
