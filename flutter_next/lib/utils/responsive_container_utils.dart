/// 📐 Returns max container width for fixed (non-fluid) layouts.
double responsiveMaxWidth(double screenWidth) {
  if (screenWidth >= 1200) {
    return 1140;
  }
  if (screenWidth >= 992) {
    return 960;
  }
  if (screenWidth >= 768) {
    return 720;
  }
  if (screenWidth >= 576) {
    return 540;
  }
  return screenWidth; // fallback
}
