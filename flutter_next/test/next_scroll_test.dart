import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('lenis eases a wheel notch on macOS', (tester) async {
    final controller = await _pumpList(tester);

    await _scroll(tester, 100);
    expect(controller.position.pixels, 0);

    await tester.pump(const Duration(milliseconds: 16));
    final mid = controller.position.pixels;
    expect(mid, greaterThan(0));
    expect(mid, lessThan(100));
    expect(mid, isNot(mid.roundToDouble()));

    for (var frame = 0; frame < 90; frame++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(controller.position.pixels, closeTo(120, 0.5));
    expect(controller.isEasing, isFalse);
  });

  testWidgets('direct applies the notch on the same frame', (tester) async {
    final controller = await _pumpList(
      tester,
      config: const NextScrollConfig.direct(),
    );

    await _scroll(tester, 100);
    expect(controller.position.pixels, 100);
    expect(controller.isEasing, isFalse);
  });

  testWidgets('disableAnimations applies the notch on the same frame', (
    tester,
  ) async {
    final controller = await _pumpList(tester, disableAnimations: true);

    await _scroll(tester, 100);
    expect(controller.position.pixels, 120);
    expect(controller.isEasing, isFalse);
  });

  testWidgets('small and rapid notches keep easing toward the summed target', (
    tester,
  ) async {
    final controller = await _pumpList(tester);

    await _scroll(tester, 20);
    await _scroll(tester, 8);
    await _scroll(tester, 20);

    expect(controller.position.pixels, 0);
    expect(controller.isEasing, isTrue);

    await tester.pump(const Duration(milliseconds: 16));
    expect(controller.position.pixels, greaterThan(0));
    expect(controller.position.pixels, lessThan(48 * 1.2));

    for (var frame = 0; frame < 90; frame++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(controller.position.pixels, closeTo(48 * 1.2, 0.5));
    expect(controller.isEasing, isFalse);
  });

  testWidgets('a layout pass does not cut the ease', (tester) async {
    final controller = await _pumpList(tester);

    await _scroll(tester, 100);
    await tester.pump(const Duration(milliseconds: 16));
    final mid = controller.position.pixels;
    expect(mid, greaterThan(0));

    (controller.position as NextSmoothScrollPosition).goBallistic(0);
    expect(controller.isEasing, isTrue);

    await tester.pump(const Duration(milliseconds: 16));
    expect(controller.position.pixels, greaterThan(mid));

    for (var frame = 0; frame < 90; frame++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(controller.position.pixels, closeTo(120, 0.5));
    expect(controller.isEasing, isFalse);
  });

  testWidgets('a list outside the scope jumps', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.macOS),
        home: const Scaffold(body: _TallList()),
      ),
    );
    await tester.pump();

    await _scroll(tester, 100);
    final position = tester
        .state<ScrollableState>(find.byType(Scrollable))
        .position;
    expect(position, isNot(isA<NextSmoothScrollPosition>()));
    expect(position.pixels, 100);
  });

  testWidgets('a nested horizontal list keeps a normal position', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.macOS),
        home: Scaffold(
          body: NextSmoothScroll(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [SizedBox(width: 4000, height: 40)],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    final position = tester
        .state<ScrollableState>(find.byType(Scrollable))
        .position;
    expect(position, isNot(isA<NextSmoothScrollPosition>()));
  });

  testWidgets('inside a route controller eases, outside it does not', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.macOS),
        home: PrimaryScrollController(
          controller: ScrollController(),
          child: const Scaffold(body: NextSmoothScroll(child: _TallList())),
        ),
      ),
    );
    await tester.pump();

    final inside = _nextController(tester);
    await _scroll(tester, 100);
    await tester.pump(const Duration(milliseconds: 16));
    expect(inside.position.pixels, greaterThan(0));
    expect(inside.position.pixels, lessThan(100));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.macOS),
        home: NextSmoothScroll(
          child: PrimaryScrollController(
            controller: ScrollController(),
            child: const Scaffold(body: _TallList()),
          ),
        ),
      ),
    );
    await tester.pump();

    await _scroll(tester, 100);
    final outside = tester
        .state<ScrollableState>(find.byType(Scrollable))
        .position;
    expect(outside, isNot(isA<NextSmoothScrollPosition>()));
    expect(outside.pixels, 100);
    expect(_nextController(tester).hasClients, isFalse);
  });
}

Future<NextScrollController> _pumpList(
  WidgetTester tester, {
  NextScrollConfig config = const NextScrollConfig.lenis(),
  bool disableAnimations = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(platform: TargetPlatform.macOS),
      home: Builder(
        builder: (context) {
          final child = NextSmoothScroll(
            config: config,
            child: const Scaffold(body: _TallList()),
          );
          if (!disableAnimations) {
            return child;
          }
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: child,
          );
        },
      ),
    ),
  );
  await tester.pump();
  return _nextController(tester);
}

NextScrollController _nextController(WidgetTester tester) {
  return tester
      .widgetList<PrimaryScrollController>(find.byType(PrimaryScrollController))
      .map((scope) => scope.controller)
      .whereType<NextScrollController>()
      .single;
}

Future<void> _scroll(WidgetTester tester, double dy) {
  return tester.sendEventToBinding(
    PointerScrollEvent(
      viewId: tester.view.viewId,
      position: tester.getCenter(find.byType(Scrollable)),
      scrollDelta: Offset(0, dy),
    ),
  );
}

class _TallList extends StatelessWidget {
  const _TallList();

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [SizedBox(height: 4000)]);
  }
}
