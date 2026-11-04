import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'easeIn is behind linear at the midpoint and a delay holds the start',
    () {
      expect(
        nextMotionT(
          t: 0.5,
          delay: Duration.zero,
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear,
        ),
        0.5,
      );
      expect(
        nextMotionT(
          t: 0.5,
          delay: Duration.zero,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        ),
        closeTo(Curves.easeIn.transform(0.5), 0.001),
      );
      expect(
        nextMotionT(
          t: 0.25,
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        ),
        0,
      );
    },
  );

  testWidgets('a linear fade is halfway at half the duration', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NextMotionView.fadeIn(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 400),
          child: const SizedBox(width: 10, height: 10),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      tester.widget<Opacity>(find.byType(Opacity)).opacity,
      closeTo(0.5, 0.05),
    );
  });

  testWidgets('delay keeps the fade at its start', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NextMotionView.fadeIn(
          curve: Curves.linear,
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 200),
          child: const SizedBox(width: 10, height: 10),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0);
  });

  testWidgets('reduced motion jumps to the end', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: NextMotionView.fadeIn(
            child: const SizedBox(width: 10, height: 10),
          ),
        ),
      ),
    );

    expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
  });
}
