import 'package:flutter/widgets.dart';

import 'next_scope.dart';
import 'responsive_breakpoints.dart';

/// A value that changes with the parent breakpoint.
class NextValue<T> {
  /// Creates a responsive value.
  ///
  /// A set value applies at that breakpoint and wider. If the active
  /// breakpoint is narrower than every set value, the narrowest set value is used.
  const NextValue({this.xs, this.sm, this.md, this.lg, this.xl, this.xxl});

  /// Value at the extra-small breakpoint and wider.
  final T? xs;

  /// Value at the small breakpoint and wider.
  final T? sm;

  /// Value at the medium breakpoint and wider.
  final T? md;

  /// Value at the large breakpoint and wider.
  final T? lg;

  /// Value at the extra-large breakpoint and wider.
  final T? xl;

  /// Value at the extra-extra-large breakpoint.
  final T? xxl;

  /// Value for the parent breakpoint in [context].
  T resolve(BuildContext context, {T? fallback}) {
    return resolveAt(NextMetrics.of(context).breakpoint, fallback: fallback);
  }

  /// Value at [breakpoint].
  T resolveAt(Breakpoint breakpoint, {T? fallback}) {
    final values = <T?>[xs, sm, md, lg, xl, xxl];
    for (var i = breakpoint.index; i >= 0; i--) {
      final value = values[i];
      if (value != null) {
        return value;
      }
    }
    for (var i = breakpoint.index + 1; i < values.length; i++) {
      final value = values[i];
      if (value != null) {
        return value;
      }
    }
    if (fallback != null) {
      return fallback;
    }
    throw StateError('NextValue has no value for ${breakpoint.name}.');
  }
}
