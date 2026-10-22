# flutter_next

Responsive layout and controls for Flutter. Columns, type, and visibility follow the **parent** width, not the screen.

[![pub package](https://img.shields.io/pub/v/flutter_next)](https://pub.dev/packages/flutter_next)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![stars](https://img.shields.io/github/stars/shashiben/flutter_next?style=flat&logo=github)](https://github.com/shashiben/flutter_next)

```dart
import 'package:flutter_next/flutter_next.dart';
```

Import that library only. `lib/src` is not a supported path. Motion comes from [`next_animations`](https://pub.dev/packages/next_animations), which this package re-exports.

```yaml
dependencies:
  flutter_next: ^1.0.0
```

Requires Dart 3.8 and Flutter 3.32.

## Layout follows the parent

`NextScope` measures the width it is given. A row inside a 720px frame is `md` even when the window is wider. Without a scope, widgets fall back to the screen width and the Bootstrap defaults: 12 columns, 16px gutter.

```dart
NextScope(
  child: NextRow(
    children: [
      NextCol(
        span: const NextSpan(xs: 12, md: 6, lg: 4),
        child: const Text('One'),
      ),
      NextCol(
        span: const NextSpan(xs: 12, md: 6, lg: 4),
        child: const Text('Two'),
      ),
      NextCol(
        span: const NextSpan(xs: 12, md: 6, lg: 4),
        child: const Text('Three'),
      ),
    ],
  ),
)
```

`NextSpan` is mobile-first. A set value applies at that breakpoint and every wider one. `NextSpan(md: 6)` is full width below 768 and half width from 768 up. `NextSpan.parse('col-12 col-md-6')` exists for migration. `col-12` means `xs`.

`NextGrid` gives every child the same span:

```dart
NextGrid(
  span: const NextSpan(xs: 12, md: 6, lg: 4),
  children: const [Text('One'), Text('Two'), Text('Three')],
)
```

Nest another `NextScope` to change the gutter, column count, or container widths for one subtree.

### Breakpoints

| | xs | sm | md | lg | xl | xxl |
| --- | --- | --- | --- | --- | --- | --- |
| Min width | 0 | 576 | 768 | 992 | 1200 | 1400 |
| Container max | full | 540 | 720 | 960 | 1140 | 1320 |

`NextContainer` centers content at the max width for the parent breakpoint. `fluid: true` uses the full parent.

## The same cascade, for anything

`NextValue` uses the same mobile-first walk as a span.

```dart
final padding = NextValue<double>(xs: 8, md: 16, lg: 28).resolve(context);
```

`NextShow` shows a subtree for a range of breakpoints. `from` is inclusive and `until` is exclusive. `only` lists exact breakpoints. Anything else renders `fallback`.

```dart
NextShow(
  from: Breakpoint.lg,
  fallback: const Text('Narrow'),
  child: const Text('Wide'),
)
```

## Controls

Buttons, alerts, surfaces, and avatars read `NextColors`, a `ThemeExtension` taken from the current `ColorScheme`.

```dart
NextButton(
  onPressed: () {},
  child: const Text('Filled'),
)

NextButton(
  onPressed: () {},
  variant: NextButtonVariant.outlined,
  child: const Text('Outlined'),
)

NextSurface(
  variant: NextVariant.primary,
  child: const Text('Primary'),
)
```

`NextButton.itemBuilder` replaces the label when you need a hover-aware child. `HoverWidget` reports pointer hover through `MouseRegion`. `NextAccordion` wraps `ExpansionTile`. `NextAlert` is a variant-colored banner. `NextShadow.shadow100(context)` returns theme-aware `BoxShadow`s.

## Motion

One `NextMotion` describes opacity, translation, scale, and rotation. `NextMotionView` plays it. The controller lasts `delay + duration`, and the curve runs after the delay. `MediaQuery.disableAnimationsOf` jumps an entrance or exit to its end.

```dart
child.fadeIn(variant: NextFadeIn.fadeInUp);

NextStagger(
  motion: NextMotion.fadeIn(NextFadeIn.fadeInUp),
  children: cards,
);
```

`playWhenVisible: true` waits until the widget is on screen. See [`next_animations`](https://pub.dev/packages/next_animations) for slide, zoom, flip, bounce, and `NextColorTween`.

## Extensions

```dart
context.width
'flutter'.capitalize()
false.toggle()
widget.pad(20)
widget.onTap(() {})
[widget].column()
```

## Contributors

This list is generated from the GitHub contributors graph and updates as people commit.

[![Contributors](https://contrib.rocks/image?repo=shashiben/flutter_next)](https://github.com/shashiben/flutter_next/graphs/contributors)

Made with [contrib.rocks](https://contrib.rocks).

## License

MIT. See [LICENSE](LICENSE).
