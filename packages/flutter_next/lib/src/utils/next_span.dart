import 'responsive_breakpoints.dart';

/// Copies each set value onto that breakpoint and every wider one.
///
/// Breakpoints below the first set value use [fallback].
Map<Breakpoint, int> resolveTracks({
  required int? xs,
  required int? sm,
  required int? md,
  required int? lg,
  required int? xl,
  required int? xxl,
  required int fallback,
}) {
  final specified = <int?>[xs, sm, md, lg, xl, xxl];
  final resolved = <Breakpoint, int>{};
  int? carried;
  for (var i = 0; i < Breakpoint.values.length; i++) {
    final value = specified[i];
    if (value != null) {
      carried = value;
    }
    resolved[Breakpoint.values[i]] = carried ?? fallback;
  }
  return resolved;
}

/// Reads `prefix-12` as xs and `prefix-md-6` as md.
///
/// Only breakpoints named in [input] are returned. Missing entries stay null
/// so [resolveTracks] can apply the mobile-first cascade.
Map<Breakpoint, int?> parseTracks(String input, String prefix, {int max = 12}) {
  final parsed = <Breakpoint, int?>{
    for (final breakpoint in Breakpoint.values) breakpoint: null,
  };
  final parts = input
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty);
  final bare = RegExp('^$prefix-(\\d+)\$');
  for (final part in parts) {
    final bareMatch = bare.firstMatch(part);
    if (bareMatch != null) {
      parsed[Breakpoint.xs] = _accepted(bareMatch.group(1), max);
      continue;
    }
    for (final breakpoint in Breakpoint.values) {
      final match = RegExp(
        '^$prefix-${breakpoint.name}-(\\d+)\$',
      ).firstMatch(part);
      if (match != null) {
        parsed[breakpoint] = _accepted(match.group(1), max);
      }
    }
  }
  return parsed;
}

int? _accepted(String? raw, int max) {
  final value = int.tryParse(raw ?? '');
  if (value == null || value < 0 || value > max) {
    return null;
  }
  return value;
}

/// How many columns a cell spans at each breakpoint.
class NextSpan {
  /// Creates a span. A set value applies at that breakpoint and wider.
  const NextSpan({this.xs, this.sm, this.md, this.lg, this.xl, this.xxl});

  /// Parses Bootstrap column classes. `col-12` means [xs].
  factory NextSpan.parse(String input, {int columns = 12}) {
    final parsed = parseTracks(input, 'col', max: columns);
    return NextSpan(
      xs: parsed[Breakpoint.xs],
      sm: parsed[Breakpoint.sm],
      md: parsed[Breakpoint.md],
      lg: parsed[Breakpoint.lg],
      xl: parsed[Breakpoint.xl],
      xxl: parsed[Breakpoint.xxl],
    );
  }

  /// Columns at the extra-small breakpoint and wider, until a larger value is set.
  final int? xs;

  /// Columns at the small breakpoint and wider.
  final int? sm;

  /// Columns at the medium breakpoint and wider.
  final int? md;

  /// Columns at the large breakpoint and wider.
  final int? lg;

  /// Columns at the extra-large breakpoint and wider.
  final int? xl;

  /// Columns at the extra-extra-large breakpoint.
  final int? xxl;

  /// Breakpoints named in [input], such as `xs sm`.
  static Set<Breakpoint> hiddenFrom(String input) {
    final hidden = <Breakpoint>{};
    for (final part in input.toLowerCase().split(RegExp(r'\s+'))) {
      for (final breakpoint in Breakpoint.values) {
        if (part == breakpoint.name) {
          hidden.add(breakpoint);
        }
      }
    }
    return hidden;
  }

  /// Resolved column counts. Unset smaller breakpoints use [columns].
  Map<Breakpoint, int> resolve({int columns = 12}) {
    return resolveTracks(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: columns,
    );
  }
}

/// Column offset or order. Unset smaller breakpoints stay at 0.
class NextTrack {
  /// Creates a track value.
  const NextTrack({this.xs, this.sm, this.md, this.lg, this.xl, this.xxl});

  /// Parses `offset-md-2` or `order-sm-1`. A bare `offset-2` means xs.
  factory NextTrack.parse(String input, {int max = 12}) {
    final prefix = input.trim().toLowerCase().startsWith('order')
        ? 'order'
        : 'offset';
    final parsed = parseTracks(input, prefix, max: max);
    return NextTrack(
      xs: parsed[Breakpoint.xs],
      sm: parsed[Breakpoint.sm],
      md: parsed[Breakpoint.md],
      lg: parsed[Breakpoint.lg],
      xl: parsed[Breakpoint.xl],
      xxl: parsed[Breakpoint.xxl],
    );
  }

  /// Value at the extra-small breakpoint and wider.
  final int? xs;

  /// Value at the small breakpoint and wider.
  final int? sm;

  /// Value at the medium breakpoint and wider.
  final int? md;

  /// Value at the large breakpoint and wider.
  final int? lg;

  /// Value at the extra-large breakpoint and wider.
  final int? xl;

  /// Value at the extra-extra-large breakpoint.
  final int? xxl;

  /// Resolved values. Unset smaller breakpoints use 0.
  Map<Breakpoint, int> resolve() {
    return resolveTracks(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      fallback: 0,
    );
  }
}

/// Width of one track when [columns] tracks and the gaps between them fill [parentWidth].
double nextTrackSize(double parentWidth, double gutter, int columns) {
  if (columns <= 1) {
    return parentWidth;
  }
  final gap = gutter < 0 ? 0.0 : gutter;
  return (parentWidth - gap * (columns - 1)) / columns;
}

/// Outer width of [span] tracks, including the gutters inside the span.
double nextSpanWidth(int span, double track, double gutter) {
  if (span <= 0) {
    return 0;
  }
  final gap = gutter < 0 ? 0.0 : gutter;
  return span * track + (span - 1) * gap;
}
