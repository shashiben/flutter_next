import 'package:flutter/material.dart';

/// ✨ Extension on [Widget] to easily attach tooltips with customization options.
extension WidgetsExtension on Widget {
  /// 🏷️ Adds a tooltip to the widget displaying the provided [message].
  ///
  /// This extension simplifies tooltip integration by allowing full customization.
  ///
  /// ---
  /// 📝 **Example Usage**
  /// ```dart
  /// Text("Hover me").withTooltip(
  ///   "This is a tooltip",
  ///   decoration: BoxDecoration(
  ///     color: Colors.black87,
  ///     borderRadius: BorderRadius.circular(8),
  ///   ),
  /// );
  /// ```
  /// ---
  ///
  /// ✅ **Use Cases:**
  /// - Enhancing accessibility by providing additional context.
  /// - Displaying extra information on **hover, long press, or tap**.
  /// - Improving user experience with **interactive tooltips**.
  ///
  /// ---
  ///
  /// **🔹 Parameters:**
  /// - `message` 📜 *(required)*: The tooltip text to display.
  /// - `enabled` ✅ *(default: `true`)*: Enables or disables the tooltip.
  /// - `decoration` 🎨 *(optional)*: Custom styling for the tooltip's background.
  /// - `height` 📏 *(optional)*: Height of the tooltip.
  /// - `preferBelow` ⬇️ *(default: `true`)*: Whether the tooltip should appear **below** the widget.
  /// - `padding` 🛋️ *(optional)*: Inner padding of the tooltip.
  /// - `textStyle` 🔠 *(optional)*: Custom style for the tooltip text.
  /// - `waitDuration` ⏳ *(optional)*: Delay before the tooltip appears.
  /// - `margin` 📏 *(optional)*: Margin around the tooltip.
  /// - `verticalOffset` 🏗️ *(optional)*: Distance between the widget and tooltip.
  /// - `excludeFromSemantics` 🔇 *(optional)*: Excludes the tooltip from **semantic trees**.
  /// - `textAlign` 📐 *(optional)*: Alignment of the tooltip text.
  /// - `showDuration` ⏱ *(optional)*: How long the tooltip stays visible.
  /// - `exitDuration` ⌛ *(optional)*: Animation duration when dismissing the tooltip.
  /// - `enableTapToDismiss` 🖱 *(default: `true`)*: Dismisses tooltip on tap.
  /// - `triggerMode` 🎯 *(optional)*: Defines how the tooltip is triggered (hover, tap, etc.).
  /// - `enableFeedback` 🔊 *(optional)*: Enables **haptic/auditory feedback**.
  /// - `onTriggered` 🎬 *(optional)*: Callback when the tooltip is triggered.
  /// - `mouseCursor` 🖱 *(optional)*: Custom **mouse cursor** when hovered.
  /// - `ignorePointer` 🚫 *(optional)*: If `true`, ignores pointer interactions.
  ///
  Widget withTooltip(
    String message, {
    bool enabled = true,
    Decoration? decoration,
    BoxConstraints? constraints,
    bool preferBelow = true,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    Duration? waitDuration,
    EdgeInsetsGeometry? margin,
    double? verticalOffset,
    bool? excludeFromSemantics,
    TextAlign? textAlign,
    Duration? showDuration,
    Duration? exitDuration,
    bool enableTapToDismiss = true,
    TooltipTriggerMode? triggerMode,
    bool? enableFeedback,
    void Function()? onTriggered,
    MouseCursor? mouseCursor,
    bool? ignorePointer,
  }) {
    if (!enabled) return this;

    return Tooltip(
      message: message,
      decoration: decoration,
      constraints: constraints,
      preferBelow: preferBelow,
      padding: padding,
      textStyle: textStyle,
      waitDuration: waitDuration,
      margin: margin,
      verticalOffset: verticalOffset,
      excludeFromSemantics: excludeFromSemantics,
      textAlign: textAlign,
      showDuration: showDuration,
      enableTapToDismiss: enableTapToDismiss,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      mouseCursor: mouseCursor,
      ignorePointer: ignorePointer,
      exitDuration: exitDuration,
      child: this,
    );
  }
}
