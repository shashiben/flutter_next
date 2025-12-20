# 🎬 Next Animation - Smooth Flutter Animations Package

A comprehensive Flutter animation package providing smooth, customizable animations including bounce, fade, slide, zoom, flip, and color tween animations.

## ✨ Features

- 🎯 **Bounce Animations**: Elastic bounce effects from any direction
- 🌊 **Fade Animations**: Smooth fade in/out with optional directional movement
- 🎢 **Slide Animations**: Slide elements into view from any direction
- 🔍 **Zoom Animations**: Scale elements in or out with smooth transitions
- 🔄 **Flip Animations**: 3D flip effects along X or Y axis
- 🎨 **Color Tween**: Smooth color transitions between two colors
- ⚡ **Auto-Start**: Animations start automatically when widgets are built
- 🎛️ **Highly Customizable**: Control duration, delay, curves, controllers, and more
- 🎨 **Smooth Curves**: Optimized animation curves for polished, professional feel

## 📦 Installation

Add `next_animation` to your `pubspec.yaml`:

```yaml
dependencies:
  next_animation:
    path: ../next_animation  # For local development
    # or
    # next_animation: ^0.1.0  # When published
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:next_animation/next_animation.dart';

// Using animation widgets directly
NextFadeInAnimation(
  variant: NextFadeInVariant.fadeInLeft,
  animationDuration: Duration(milliseconds: 500),
  child: Text('Hello World'),
)

// Using extension methods (more convenient)
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
).fadeIn(
  variant: NextFadeInVariant.fadeInLeft,
  duration: Duration(milliseconds: 500),
)
```

## 📚 Animation Types

### 1. Bounce Animations

Create elastic bounce effects from any direction:

```dart
NextBounceAnimation(
  variant: NextBounceVariant.bounceInLeft,
  duration: Duration(milliseconds: 500),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.orange,
  ),
)

// Or using extension
Container(
  width: 100,
  height: 100,
  color: Colors.orange,
).bounce(
  variant: NextBounceVariant.bounceInTop,
)
```

**Variants:**
- `bounceInTop` - Bounce from top
- `bounceInBottom` - Bounce from bottom
- `bounceInLeft` - Bounce from left
- `bounceInRight` - Bounce from right

### 2. Fade Animations

Smooth fade in/out with optional directional movement:

```dart
// Fade In
NextFadeInAnimation(
  variant: NextFadeInVariant.fadeInLeft,
  duration: Duration(milliseconds: 500),
  child: Text('Fading in!'),
)

// Fade Out
NextFadeOutAnimation(
  variant: NextFadeOutVariant.fadeOutRight,
  duration: Duration(milliseconds: 500),
  child: Text('Fading out!'),
)

// Using extensions
Text('Hello').fadeIn(variant: NextFadeInVariant.fadeInTop)
Text('Goodbye').fadeOut(variant: NextFadeOutVariant.fadeOutBottom)
```

**Fade In Variants:**
- `fadeInLeft` - Fade in from left
- `fadeInRight` - Fade in from right
- `fadeInTop` - Fade in from top
- `fadeInBottom` - Fade in from bottom

**Fade Out Variants:**
- `fadeOutLeft` - Fade out to left
- `fadeOutRight` - Fade out to right
- `fadeOutTop` - Fade out to top
- `fadeOutBottom` - Fade out to bottom

### 3. Slide Animations

Slide elements into view from any direction:

```dart
NextSlideAnimation(
  variant: NextSlideVariant.slideInLeft,
  duration: Duration(milliseconds: 500),
  child: Card(
    child: ListTile(title: Text('Sliding in!')),
  ),
)

// Using extension
Card(
  child: ListTile(title: Text('Sliding in!')),
).slide(variant: NextSlideVariant.slideInRight)
```

**Variants:**
- `slideInTop` - Slide from top
- `slideInBottom` - Slide from bottom
- `slideInLeft` - Slide from left
- `slideInRight` - Slide from right

### 4. Zoom Animations

Scale elements in or out with smooth transitions:

```dart
NextZoomAnimation(
  variant: NextZoomVariant.zoomIn,
  duration: Duration(milliseconds: 500),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.blue,
  ),
)

// Using extension
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
).zoom(variant: NextZoomVariant.zoomOut)
```

**Variants:**
- `zoomIn` - Scale from 0 to 1
- `zoomOut` - Scale from 1 to 0

### 5. Flip Animations

3D flip effects along X or Y axis:

```dart
NextFlipAnimation(
  variant: NextFlipVariant.flipX,
  animationDuration: Duration(milliseconds: 500),
  child: Container(
    width: 100,
    height: 100,
    color: Colors.purple,
  ),
)

// Using extension
Container(
  width: 100,
  height: 100,
  color: Colors.purple,
).flip(variant: NextFlipVariant.flipY)
```

**Variants:**
- `flipX` - Flip along X-axis (horizontal)
- `flipY` - Flip along Y-axis (vertical)

### 6. Color Tween

Smooth color transitions between two colors:

```dart
NextColorTweenWidget(
  beginColor: Colors.blue,
  endColor: Colors.red,
  duration: Duration(milliseconds: 500),
  child: (controller, color) {
    return GestureDetector(
      onTap: () {
        if (controller.isCompleted) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
      child: Container(
        width: 100,
        height: 100,
        color: color,
      ),
    );
  },
)
```

## 🎛️ Advanced Usage

### Custom Animation Controllers

You can provide your own animation controller for more control:

```dart
final controller = AnimationController(
  duration: Duration(milliseconds: 1000),
  vsync: this,
);

NextFadeInAnimation(
  controller: controller,
  autoStart: false,
  fadeInVariant: NextFadeInVariant.fadeInLeft,
  child: Text('Custom controlled'),
)
```

### Manual Control

Animations can be controlled manually using a controller:

```dart
final controller = AnimationController(
  duration: Duration(milliseconds: 1000),
  vsync: this,
);

NextFadeInAnimation(
  controller: controller,
  autoStart: false, // Don't start automatically
  fadeInVariant: NextFadeInVariant.fadeInLeft,
  child: Text('Manually controlled'),
)

// Later, trigger the animation
controller.forward();
```

### Delayed Animations

Add delays before animations start:

```dart
NextSlideAnimation(
  animationDelay: Duration(milliseconds: 500),
  slideVariant: NextSlideVariant.slideInLeft,
  child: Text('Delayed animation'),
)
```

### Combining Animations

You can combine multiple animations:

```dart
NextFadeInAnimation(
  fadeInVariant: NextFadeInVariant.fadeInTop,
  child: NextSlideAnimation(
    slideVariant: NextSlideVariant.slideInTop,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    ),
  ),
)
```

## 📖 API Reference

### Common Parameters

All animation widgets support these common parameters:

- `duration`: Duration of the animation (default: 400ms for most, 600ms for bounce/flip)
- `delay`: Delay before animation starts (default: Duration.zero)
- `controller`: Optional custom animation controller for manual control
- `autoStart`: Whether to start automatically when built (default: true)
- `curve`: Animation curve for smooth motion (default: Curves.easeOutCubic)
- `initialPosition`: Initial offset for directional animations (default: 50-100px)

### Extension Methods

All animations are available as extension methods on `Widget`:

- `.fadeIn()` - Fade in animation
- `.fadeOut()` - Fade out animation
- `.slide()` - Slide animation
- `.zoom()` - Zoom animation
- `.flip()` - Flip animation

## 🎨 Examples

Check out the [example app](../flutter_next/example) for comprehensive examples of all animation types.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with ❤️ using Flutter
- Part of the Flutter Next ecosystem
