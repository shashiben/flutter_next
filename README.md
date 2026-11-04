# Flutter Next

Responsive layout for Flutter, plus one motion spec.

[![pub package](https://img.shields.io/pub/v/flutter_next)](https://pub.dev/packages/flutter_next)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![stars](https://img.shields.io/github/stars/shashiben/flutter_next?style=flat&logo=github)](https://github.com/shashiben/flutter_next)

A column reads the width of its parent. The window can be `xxl` while a frame inside it is `sm`. `NextSpan`, `NextValue`, and `NextShow` share that cascade. Motion is a single `NextMotion` played by `NextMotionView`.

| Package | What it is |
| --- | --- |
| [`flutter_next`](flutter_next/) | Layout, theme colors, and controls. Re-exports motion. |
| [`animation_next`](animation_next/) | Fade, slide, zoom, flip, and bounce. |

```dart
import 'package:flutter_next/flutter_next.dart';
```

Package docs: [flutter_next](flutter_next/README.md) and [animation_next](animation_next/README.md).

## Gallery

```bash
cd example_shared
flutter run
```

The gallery opens on a full-width introduction: a live device frame you can
resize, a span inspector, and the theme and shadow scale. A top bar opens each
screen:

| Screen | What it shows |
| --- | --- |
| Storefront | A product grid with a filter rail that appears only when the parent is wide enough. |
| Dashboard | KPI tiles, a revenue chart, and an activity feed with a loading state. |
| Checkout | A two column form and order summary, with an accordion, a breadcrumb, and a promo code. |
| Landing | A marketing page with a hero, a feature grid, pricing tiers, and staggered motion. |
| Devices | The same app rendered in phone, tablet, and desktop frames, plus a width slider. |

The overview itself is built from `NextContainer`, `NextGrid`, `NextSurface`,
and `NextShadow`, and the tiles animate in with `NextMotion`. Every screen is
the same widget tree at a different parent width, so the layout follows the
frame instead of the window. Each package also has an `example/` used on
pub.dev.

## Development

```bash
dart pub get
melos bootstrap
```

```
flutter_next/
├── example_shared/       # Gallery
├── flutter_next/         # Layout and controls
│   └── lib/src/
└── animation_next/      # Motion
    └── lib/src/
```

Public imports are `package:flutter_next/flutter_next.dart` and `package:animation_next/animation_next.dart`.

## Contributors

This list is generated from the GitHub contributors graph and updates as people commit.

[![Contributors](https://contrib.rocks/image?repo=shashiben/flutter_next)](https://github.com/shashiben/flutter_next/graphs/contributors)

Made with [contrib.rocks](https://contrib.rocks).
