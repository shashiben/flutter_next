import 'package:flutter/material.dart';
import 'package:flutter_next_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('the frame breakpoint is not the window breakpoint', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FlutterNextExample());
    await tester.pump();

    expect(find.textContaining('Window 1400px · xxl'), findsOneWidget);
    expect(find.textContaining('This frame is sm'), findsOneWidget);
    expect(find.textContaining('Hidden until the frame reaches lg'), findsOneWidget);
    expect(find.text('One'), findsOneWidget);
  });
}
