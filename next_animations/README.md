# next_animations

One motion spec and one player.

```dart
import 'package:next_animations/next_animations.dart';

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

## Contributors

This list is generated from the GitHub contributors graph and updates as people commit.

[![Contributors](https://contrib.rocks/image?repo=shashiben/flutter_next)](https://github.com/shashiben/flutter_next/graphs/contributors)

Made with [contrib.rocks](https://contrib.rocks).
