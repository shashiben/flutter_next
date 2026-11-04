# animation_next

One motion spec and one player.

```dart
import 'package:animation_next/animation_next.dart';

child.fadeIn(variant: NextFadeIn.fadeInUp);

NextMotionView.slide(
  variant: NextSlide.slideInLeft,
  duration: const Duration(milliseconds: 400),
  delay: const Duration(milliseconds: 80),
  curve: Curves.easeOutCubic,
  child: card,
);
```

`NextMotion` holds the start and end of opacity, translation, scale, and rotation. `NextMotionView` plays that spec. The controller lasts `delay + duration`, and the curve applies after the delay. `MediaQuery.disableAnimationsOf` jumps an entrance or exit to its end state. `playWhenVisible` starts the motion once the widget is on screen.

`NextColorTween` blends to a new color when `end` changes.

## Composer

`NextAnimated` plays a list. Put the list next to the widget. Moves, rotations, and skews add. Scales multiply. A later fade, size, blur, tint, radius, reveal, or shadow replaces the earlier one on that channel. The first animation on a channel holds its initial value until it starts, so a delayed fade does not flash.

```dart
child.animate(
  [
    NextFade(to: 1, initial: 0),
    NextMove(y: 0, initialY: 40),
    NextScale(by: 1, initial: 0.9, spring: NextSpring.bouncy),
    NextMove(x: 120, start: const Duration(milliseconds: 600)),
  ],
  repeat: 2,
  reverse: true,
  alignment: Alignment.bottomLeft,
);
```

The default easing is `NextSpring.smooth` (stiffness 75, damping 200, overshoot clamped), stretched across 500ms. `NextSpring.gentle`, `snappy`, and `bouncy` are the other presets. Pass `curve:` for any Flutter curve. Pass `duration: null` to play a spring for its real settle time.

| Type | What it changes |
| --- | --- |
| `NextFade` | Opacity |
| `NextMove` | x, y, and z offset. z uses the player's perspective |
| `NextScale` | Scale. `by` sets both axes |
| `NextRotate` | Degrees around z, x, and y |
| `NextSkew` | Skew, in degrees |
| `NextSize` | Width and height. This one changes layout |
| `NextBlur` | Blur sigma. Costly when many play at once |
| `NextTint` | A modulate color |
| `NextRadius` | Clip corner radius |
| `NextReveal` | A clip that opens from an edge |
| `NextShadow` | A shadow. Costly when many play at once |

`delay` shifts every start. `playWhenVisible` waits until the widget is on screen. `repeat: NextAnimated.forever` does not stop, and `reverse` plays back after each pass. `inPoint` and `outPoint` hide the child outside that window and are not affected by `delay`. `MediaQuery.disableAnimationsOf` jumps to the end values.

## Contributors

This list is generated from the GitHub contributors graph and updates as people commit.

[![Contributors](https://contrib.rocks/image?repo=shashiben/flutter_next)](https://github.com/shashiben/flutter_next/graphs/contributors)

Made with [contrib.rocks](https://contrib.rocks).
