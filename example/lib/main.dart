import 'animations/bounce.animations.dart';
import 'animations/fade.animations.dart';
import 'animations/flip.animations.dart';
import 'animations/zoom.animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import 'animations/colortween.animations.dart';
import 'animations/slide.animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Next Grid View",
              style: context.titleLarge,
            ),
            NextGridView(
                mainAxisExtent: 50,
                widthPercentages: const {
                  GridPrefix.xs: 100,
                  GridPrefix.sm: 50,
                  GridPrefix.md: 25,
                  GridPrefix.lg: 25,
                  GridPrefix.xl: 25,
                  GridPrefix.xxl: 25
                },
                children: List.generate(
                    10,
                    (index) => Container(
                          color: Colors.orange,
                          child: const Center(
                            child: Icon(Icons.star),
                          ),
                        ))),
                         Text(
              "Next Row",
              style: context.titleLarge,
            ),
            NextRow(
                children: List.generate(
              4,
              (index) => NextCol(
                widthPercentages: const {
                  GridPrefix.xs: 100,
                  GridPrefix.sm: 50,
                  GridPrefix.md: 25,
                  GridPrefix.lg: 25,
                  GridPrefix.xl: 25,
                  GridPrefix.xxl: 25
                },
                child: Container(
                  color: Colors.orange,
                  height: 100,
                  child: const Center(
                    child: Text(
                      "Hello",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )),
            Text(
              "Zoom Animations",
              style: context.titleLarge,
            ),
            const ZoomAnimationsExample(),
            Text(
              "Slide Animations",
              style: context.titleLarge,
            ),
            const SlideAnimationsExample(),
            Text(
              "ColorTween Animations",
              style: context.titleLarge,
            ),
            const ColorTweenAnimationExample(),
            Text(
              "Flip Animations",
              style: context.titleLarge,
            ),
            const FlipAnimationsExample(),
            Text(
              "Fade In Animations",
              style: context.titleLarge,
            ),
            const FadeInAnimationExample(),
            Text(
              "Fade Out Animations",
              style: context.titleLarge,
            ),
            const FadeOutAnimationExample(),
            Text(
              "Bounce Animations",
              style: context.titleLarge,
            ),
            const BounceAnimationsExample(),
            Text(
              "Avatar Group",
              style: context.titleLarge,
            ),
            const SizedBox(
              height: 15,
            ),
            NextAvatarGroup(
                avatarBackgroundColor: Colors.orange,
                avatarImages: List.generate(
                    6,
                    (index) => const NetworkImage(
                        "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp"))),
            Text(
              "Custom Avatar Group",
              style: context.titleLarge,
            ),
            const SizedBox(
              height: 15,
            ),
            NextAvatarGroup(
              avatarBackgroundColor: Colors.orange,
              displayLimit: 6,
              widthReductionFactor: 0.8,
              excessCountBuilder: (context, hiddenCount) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 1.5)),
                  child: Center(
                    child: Text(
                      "+$hiddenCount",
                      style: context.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                );
              },
              avatarImages: List.generate(
                  10,
                  (index) => const NetworkImage(
                      "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp")),
              avatarBuilder: (context, index, image) => Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: image),
                        border: Border.all(color: Colors.orange, width: 1.5),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  if (index % 3 == 0)
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 5,
                      ),
                    )
                ],
              ),
            ),
            Text(
              "Avatar Group Limit count",
              style: context.titleMedium,
            ),
            const SizedBox(
              height: 15,
            ),
            NextAvatarGroup(
              avatarBackgroundColor: Colors.orange,
              displayLimit: 5,
              avatarImages: List.generate(
                  10,
                  (index) => const NetworkImage(
                      "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp")),
              widthReductionFactor: 0.5,
            )
          ]),
        ),
      ),
    );
  }
}
