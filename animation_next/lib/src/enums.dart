/// Enum for Next fade-in animation variants.
/// Inspired by Animate.css fade-in animations.
enum NextFadeInVariant {
  /// Simple fade in (opacity only, no movement).
  fadeIn,

  /// Fade in from the left side.
  fadeInLeft,

  /// Fade in from the left side (big movement).
  fadeInLeftBig,

  /// Fade in from the right side.
  fadeInRight,

  /// Fade in from the right side (big movement).
  fadeInRightBig,

  /// Fade in from the top.
  fadeInTop,

  /// Fade in from the top (big movement).
  fadeInUpBig,

  /// Fade in from the bottom.
  fadeInBottom,

  /// Fade in from the bottom (big movement).
  fadeInDownBig,

  /// Fade in from the top-left corner.
  fadeInTopLeft,

  /// Fade in from the top-right corner.
  fadeInTopRight,

  /// Fade in from the bottom-left corner.
  fadeInBottomLeft,

  /// Fade in from the bottom-right corner.
  fadeInBottomRight,
}

/// Enum for Next fade-out animation variants.
/// Inspired by Animate.css fade-out animations.
enum NextFadeOutVariant {
  /// Simple fade out (opacity only, no movement).
  fadeOut,

  /// Fade out to the left side.
  fadeOutLeft,

  /// Fade out to the left side (big movement).
  fadeOutLeftBig,

  /// Fade out to the right side.
  fadeOutRight,

  /// Fade out to the right side (big movement).
  fadeOutRightBig,

  /// Fade out to the top.
  fadeOutTop,

  /// Fade out to the top (big movement).
  fadeOutUpBig,

  /// Fade out to the bottom.
  fadeOutBottom,

  /// Fade out to the bottom (big movement).
  fadeOutDownBig,

  /// Fade out to the top-left corner.
  fadeOutTopLeft,

  /// Fade out to the top-right corner.
  fadeOutTopRight,

  /// Fade out to the bottom-left corner.
  fadeOutBottomLeft,

  /// Fade out to the bottom-right corner.
  fadeOutBottomRight,
}

/// Enum for Next slide animation variants.
/// Inspired by Animate.css slide animations.
enum NextSlideVariant {
  /// Slide in from the top.
  slideInTop,

  /// Slide in from the bottom.
  slideInBottom,

  /// Slide in from the left.
  slideInLeft,

  /// Slide in from the right.
  slideInRight,

  /// Slide out to the top.
  slideOutTop,

  /// Slide out to the bottom.
  slideOutBottom,

  /// Slide out to the left.
  slideOutLeft,

  /// Slide out to the right.
  slideOutRight,
}

/// Enum for Next zoom animation variants.
/// Inspired by Animate.css zoom animations.
enum NextZoomVariant {
  /// Zoom in animation (center).
  zoomIn,

  /// Zoom in from the top.
  zoomInDown,

  /// Zoom in from the left.
  zoomInLeft,

  /// Zoom in from the right.
  zoomInRight,

  /// Zoom in from the bottom.
  zoomInUp,

  /// Zoom out animation (center).
  zoomOut,

  /// Zoom out to the top.
  zoomOutDown,

  /// Zoom out to the left.
  zoomOutLeft,

  /// Zoom out to the right.
  zoomOutRight,

  /// Zoom out to the bottom.
  zoomOutUp,
}

/// Enum for Next bounce animation variants.
/// Inspired by Animate.css bounce animations.
enum NextBounceVariant {
  /// Bounce in animation (center).
  bounceIn,

  /// Bounce in from the top.
  bounceInTop,

  /// Bounce in from the bottom.
  bounceInBottom,

  /// Bounce in from the left.
  bounceInLeft,

  /// Bounce in from the right.
  bounceInRight,

  /// Bounce out animation (center).
  bounceOut,

  /// Bounce out to the top.
  bounceOutTop,

  /// Bounce out to the bottom.
  bounceOutBottom,

  /// Bounce out to the left.
  bounceOutLeft,

  /// Bounce out to the right.
  bounceOutRight,
}

/// Enum for Next flip animation variants.
/// Inspired by Animate.css flip animations.
enum NextFlipVariant {
  /// Flip in along the X-axis (horizontal flip in).
  flipInX,

  /// Flip in along the Y-axis (vertical flip in).
  flipInY,

  /// Flip out along the X-axis (horizontal flip out).
  flipOutX,

  /// Flip out along the Y-axis (vertical flip out).
  flipOutY,
}
