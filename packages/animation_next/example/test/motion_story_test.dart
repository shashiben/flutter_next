import 'package:animation_next_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('curve, delay, and reduced motion are on the page', (
    tester,
  ) async {
    await tester.pumpWidget(const AnimationNextExample());
    await tester.pump();

    expect(find.text('linear'), findsWidgets);
    expect(find.text('easeIn'), findsWidgets);
    expect(find.textContaining('500ms'), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pump();
    expect(find.text('Tile 1'), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0, 400));
    await tester.pump();
    await tester.tap(find.byType(FilterChip));
    await tester.pump();
    expect(tester.widget<FilterChip>(find.byType(FilterChip)).selected, isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
