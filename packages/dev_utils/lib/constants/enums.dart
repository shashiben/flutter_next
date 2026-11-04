/// Represents various device types the application can run on.
enum DeviceType {
  /// A device running on Android operating system.
  android,

  /// A device running on iOS operating system.
  ios,

  /// A device running on Fuchsia operating system.
  fuchsia,

  /// A web-based device or browser.
  web,

  /// A device running on Windows operating system.
  windows,

  /// A device running on macOS.
  mac,

  /// A device running on Linux operating system.
  linux,

  /// A device running on ChromeOS.
  chromeos,

  /// A device running on HarmonyOS.
  harmonyos,

  /// A device with an unspecified or unknown operating system.
  unknown,
}

/// Represents different types of screens based on form factor.
enum ScreenType {
  /// A screen typically found on mobile phones.
  mobile,

  /// A screen typically found on tablets.
  tablet,

  /// A screen typically found on desktops or larger displays.
  desktop,

  /// A screen with foldable characteristics.
  foldable,
}

/// Represents responsive breakpoints used for layout designs.
enum ResponsiveType {
  /// Extra small screens (e.g., phones in portrait mode).
  xs,

  /// Small screens (e.g., phones in landscape mode or small tablets).
  sm,

  /// Medium screens (e.g., tablets or small laptops).
  md,

  /// Large screens (e.g., desktops and larger laptops).
  lg,

  /// Extra large screens (e.g., wide desktops or high-resolution displays).
  xl,

  /// Extra extra large screens (e.g., ultra-wide monitors or TVs).
  xxl,
}
