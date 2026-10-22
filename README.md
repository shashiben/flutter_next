# Flutter Next

Responsive layout for Flutter, plus one motion spec.

[![pub package](https://img.shields.io/pub/v/flutter_next)](https://pub.dev/packages/flutter_next)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![stars](https://img.shields.io/github/stars/shashiben/flutter_next?style=flat&logo=github)](https://github.com/shashiben/flutter_next)

A column reads the width of its parent. The window can be `xxl` while a frame inside it is `sm`. `NextSpan`, `NextValue`, and `NextShow` share that cascade. Motion is a single `NextMotion` played by `NextMotionView`.

| Package | What it is |
| --- | --- |
| [`flutter_next`](flutter_next/) | Layout, theme colors, and controls. Re-exports motion. |
| [`next_animations`](next_animations/) | Fade, slide, zoom, flip, and bounce. |

```dart
import 'package:flutter_next/flutter_next.dart';
```

Package docs: [flutter_next](flutter_next/README.md) and [next_animations](next_animations/README.md).

## Gallery

```bash
cd example_shared
flutter run
```

The gallery has three screens: Layout, Values, and Motion. Each package also has an `example/` used on pub.dev.

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
└── next_animations/      # Motion
    └── lib/src/
```

Public imports are `package:flutter_next/flutter_next.dart` and `package:next_animations/next_animations.dart`.

## Contributors

This list is generated from the GitHub contributors graph and updates as people commit.

[![Contributors](https://contrib.rocks/image?repo=shashiben/flutter_next)](https://github.com/shashiben/flutter_next/graphs/contributors)

Made with [contrib.rocks](https://contrib.rocks).
