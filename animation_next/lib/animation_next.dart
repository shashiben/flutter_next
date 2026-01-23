// A comprehensive Flutter animation package providing smooth, customizable
// animations including bounce, fade, slide, zoom, flip, and color tween animations.
//
// This package provides:
// - **Bounce Animations**: Elastic bounce effects from any direction
// - **Fade Animations**: Smooth fade in/out with optional directional movement
// - **Slide Animations**: Slide elements into view from any direction
// - **Zoom Animations**: Scale elements in or out with smooth transitions
// - **Flip Animations**: 3D flip effects along X or Y axis
// - **Color Tween**: Smooth color transitions between two colors
//
// All animations start automatically when widgets are built, providing smooth
// and polished transitions. They can also be controlled manually via controllers.
//
// **Getting Started:**
//
// ```dart
// import 'package:animation_next/animation_next.dart';
//
// // Using animation widgets directly
// NextFadeInAnimation(
//   variant: NextFadeInVariant.fadeInLeft,
//   duration: Duration(milliseconds: 500),
//   child: Text('Hello World'),
// )
//
// // Using extension methods (more convenient)
// Container(
//   width: 100,
//   height: 100,
//   color: Colors.blue,
// ).fadeIn(
//   variant: NextFadeInVariant.fadeInLeft,
//   duration: Duration(milliseconds: 500),
// )
// ```

// Export animations
export 'src/animations/next_bounce_animation.dart';
export 'src/animations/next_color_tween_widget.dart';
export 'src/animations/next_fade_in_animation.dart';
export 'src/animations/next_fade_out_animation.dart';
export 'src/animations/next_flip_animation.dart';
export 'src/animations/next_slide_animation.dart';
export 'src/animations/next_zoom_animation.dart';

// Export enums
export 'src/enums.dart';

// Export extensions
export 'src/extensions/animation_extension.dart';
