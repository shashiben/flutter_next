import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('each screen shows one idea', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ShowcaseApp());
    await tester.pump();

    expect(find.text('Layout follows the parent'), findsOneWidget);
    expect(find.text('One'), findsOneWidget);
    expect(find.text('Motion is one spec.'), findsNothing);

    await tester.tap(find.text('Values'));
    await tester.pumpAndSettle();
    expect(find.text('The same cascade, for anything.'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);

    await tester.tap(find.text('Motion'));
    await tester.pump();
    expect(find.text('Motion is one spec.'), findsOneWidget);
    expect(find.text('linear'), findsWidgets);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
