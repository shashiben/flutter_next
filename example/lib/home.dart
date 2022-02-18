import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Fade In Animations").customPadding(bottom: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const ContainerThing().fadeIn(
                variant: NextFadeInVariant.fadeInLeft,
                duration: const Duration(milliseconds: 600)),
            const ContainerThing().fadeIn(
                variant: NextFadeInVariant.fadeInTop,
                duration: const Duration(milliseconds: 600)),
            const ContainerThing().fadeIn(
                variant: NextFadeInVariant.fadeInBottom,
                duration: const Duration(milliseconds: 600)),
            const ContainerThing().fadeIn(
                variant: NextFadeInVariant.fadeInRight,
                duration: const Duration(milliseconds: 600)),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Fade out Animations").customPadding(bottom: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const ContainerThing(
              color: Colors.red,
            ).fadeOut(
                variant: NextFadeOutVariant.fadeOutLeft,
                duration: const Duration(milliseconds: 600)),
            const ContainerThing(
              color: Colors.red,
            ).fadeOut(
                variant: NextFadeOutVariant.fadeOutTop,
                duration: const Duration(milliseconds: 600)),
            const ContainerThing(
              color: Colors.red,
            ).fadeOut(
                variant: NextFadeOutVariant.fadeOutBottom,
                duration: const Duration(milliseconds: 600)),
            const ContainerThing(
              color: Colors.red,
            ).fadeOut(
                variant: NextFadeOutVariant.fadeOutRight,
                duration: const Duration(milliseconds: 600)),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Flip Animations").customPadding(bottom: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const ContainerThing(
              color: Colors.yellow,
            ).flip(
                variant: NextFlipVariant.flipX,
                duration: const Duration(milliseconds: 600)),
            const ContainerThing(
              color: Colors.yellow,
            ).flip(
                variant: NextFlipVariant.flipY,
                duration: const Duration(milliseconds: 600)),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Zoom Animations").customPadding(bottom: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const ContainerThing().zoom(variant: NextZoomVariant.zoomIn),
            const ContainerThing().zoom(variant: NextZoomVariant.zoomOut),
          ],
        )
      ],
    );
  }
}

class ContainerThing extends StatelessWidget {
  final Color? color;
  const ContainerThing({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      color: color ?? Colors.blue,
    );
  }
}
