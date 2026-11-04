import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const linear = Duration(milliseconds: 100);

  test('moves add, scales multiply, and a later fade waits', () {
    final added = NextPose()
      ..sample(const [
        NextMove(x: 20, y: 4, curve: Curves.linear, duration: linear),
        NextMove(x: 30, curve: Curves.linear, duration: linear),
      ], linear);
    expect(added.x, 50);
    expect(added.y, 4);

    final waiting = NextPose()
      ..sample(const [
        NextMove(x: 0, initialX: 10, curve: Curves.linear, duration: linear),
        NextMove(x: 40, initialX: 40, start: linear),
      ], Duration.zero);
    expect(waiting.x, 10);

    final scaled = NextPose()
      ..sample(const [
        NextScale(by: 2, curve: Curves.linear, duration: linear),
        NextScale(by: 3, curve: Curves.linear, duration: linear),
      ], linear);
    expect(scaled.scaleX, 6);
    expect(scaled.scaleY, 6);

    const fades = [
      NextFade(to: 1, initial: 0, curve: Curves.linear, duration: linear),
      NextFade(to: 0, start: linear, curve: Curves.linear, duration: linear),
    ];
    expect(
      (NextPose()..sample(fades, const Duration(milliseconds: 50))).opacity,
      closeTo(0.5, 0.001),
    );
    expect(
      (NextPose()..sample(fades, const Duration(milliseconds: 150))).opacity,
      closeTo(0.5, 0.001),
    );
    expect(
      (NextPose()..sample(const [
            NextFade(
              to: 1,
              initial: 0,
              start: Duration(milliseconds: 200),
              curve: Curves.linear,
            ),
          ], const Duration(milliseconds: 100)))
          .opacity,
      0,
    );
  });

  test(
    'springs start and end at the ends, and a clamped spring stays inside',
    () {
      expect(NextSpring.smooth.transform(0), 0);
      expect(NextSpring.smooth.transform(1), 1);
      for (var i = 0; i <= 20; i++) {
        final value = NextSpring.smooth.transform(i / 20);
        expect(value, inInclusiveRange(0, 1));
      }
      expect(NextSpring.bouncy.transform(0), 0);
      expect(NextSpring.bouncy.transform(1), 1);
    },
  );

  testWidgets('repeat and reverse land on the right opacity', (tester) async {
    const fade = NextFade(
      to: 1,
      initial: 0,
      curve: Curves.linear,
      duration: Duration(milliseconds: 100),
    );
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: NextAnimated(
          key: ValueKey('repeat'),
          repeat: 2,
          animations: [fade],
          child: SizedBox(width: 8, height: 8),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
    expect(_opacity(tester), closeTo(0.5, 0.05));
    await tester.pump(const Duration(milliseconds: 100));
    expect(_opacity(tester), closeTo(0.5, 0.05));

    const returning = NextFade(
      to: 0.8,
      initial: 0,
      curve: Curves.linear,
      duration: Duration(milliseconds: 100),
    );
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: NextAnimated(
          key: ValueKey('reverse'),
          reverse: true,
          animations: [returning],
          child: SizedBox(width: 8, height: 8),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
    expect(_opacity(tester), closeTo(0.4, 0.05));
    await tester.pump(const Duration(milliseconds: 50));
    expect(_opacity(tester), closeTo(0.8, 0.05));
    await tester.pump(const Duration(milliseconds: 50));
    expect(_opacity(tester), closeTo(0.4, 0.05));

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('reduced motion shows the end, and rest skips empty layers', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: NextAnimated(
            animations: [
              NextFade(
                to: 0.2,
                initial: 1,
                curve: Curves.linear,
                duration: Duration(seconds: 5),
              ),
              NextMove(
                x: 40,
                curve: Curves.linear,
                duration: Duration(seconds: 5),
              ),
            ],
            child: SizedBox(width: 8, height: 8),
          ),
        ),
      ),
    );
    expect(_opacity(tester), closeTo(0.2, 0.001));
    expect(
      tester
          .widget<Transform>(find.byType(Transform))
          .transform
          .getTranslation()
          .x,
      closeTo(40, 0.01),
    );

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: NextAnimated(
            animations: [
              NextFade(to: 1, initial: 0),
              NextBlur(to: 0, initial: 8),
              NextRadius(to: 0, initial: 12),
            ],
            child: SizedBox(width: 8, height: 8),
          ),
        ),
      ),
    );
    expect(find.byType(Opacity), findsNothing);
    expect(find.byType(ImageFiltered), findsNothing);
    expect(find.byType(ClipRRect), findsNothing);
  });
}

double _opacity(WidgetTester tester) {
  return tester.widget<Opacity>(find.byType(Opacity)).opacity;
}
