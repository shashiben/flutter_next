import 'package:flutter_next/flutter_next.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('col-md-6 is full width below md and half width from md up', () {
    final resolved = NextSpan.parse('col-md-6').resolve();
    expect(resolved[Breakpoint.xs], 12);
    expect(resolved[Breakpoint.sm], 12);
    expect(resolved[Breakpoint.md], 6);
    expect(resolved[Breakpoint.lg], 6);
    expect(resolved[Breakpoint.xl], 6);
    expect(resolved[Breakpoint.xxl], 6);
  });

  test('col-12 is the xs span and does not overwrite larger spans', () {
    final resolved = NextSpan.parse('col-12 col-md-6 col-lg-4').resolve();
    expect(resolved[Breakpoint.xs], 12);
    expect(resolved[Breakpoint.sm], 12);
    expect(resolved[Breakpoint.md], 6);
    expect(resolved[Breakpoint.lg], 4);
    expect(resolved[Breakpoint.xxl], 4);
  });

  test('a typed span uses the same cascade', () {
    final resolved = const NextSpan(md: 6, lg: 4).resolve();
    expect(resolved[Breakpoint.sm], 12);
    expect(resolved[Breakpoint.md], 6);
    expect(resolved[Breakpoint.lg], 4);
  });

  test('offset stays zero until its breakpoint', () {
    final resolved = NextTrack.parse('offset-md-3').resolve();
    expect(resolved[Breakpoint.sm], 0);
    expect(resolved[Breakpoint.md], 3);
    expect(resolved[Breakpoint.xl], 3);
  });

  test('hiddenFrom reads breakpoint names', () {
    expect(NextSpan.hiddenFrom('xs sm'), {Breakpoint.xs, Breakpoint.sm});
  });

  test('NextValue carries a value upward and falls back below it', () {
    const value = NextValue<double>(xs: 16, md: 24, lg: 32);
    expect(value.resolveAt(Breakpoint.sm), 16);
    expect(value.resolveAt(Breakpoint.md), 24);
    expect(value.resolveAt(Breakpoint.xl), 32);
    expect(const NextValue<double>(md: 24).resolveAt(Breakpoint.xs), 24);
  });

  test('a full row of tracks plus gutters equals the parent width', () {
    const parent = 1200.0;
    const gutter = 16.0;
    const columns = 12;
    final track = nextTrackSize(parent, gutter, columns);
    final half = nextSpanWidth(6, track, gutter);
    expect(half * 2 + gutter, closeTo(parent, 0.01));
    expect(nextSpanWidth(12, track, gutter), closeTo(parent, 0.01));
  });
}
