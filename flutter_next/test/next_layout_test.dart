import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('columns use the parent width, not the screen', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(1400, 800)),
          child: Center(
            child: SizedBox(
              width: 700,
              child: NextRow(
                children: [
                  NextCol(span: NextSpan(xs: 12), child: _BreakpointLabel()),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('sm'), findsOneWidget);
  });

  testWidgets('two half columns share the row after the gutter', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1400, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: SizedBox(
            width: 1200,
            child: NextRow(
              gutter: 16,
              children: [
                NextCol(
                  span: NextSpan(xs: 6),
                  child: SizedBox(
                    key: Key('left'),
                    width: double.infinity,
                    height: 10,
                  ),
                ),
                NextCol(
                  span: NextSpan(xs: 6),
                  child: SizedBox(
                    key: Key('right'),
                    width: double.infinity,
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final left = tester.getSize(find.byKey(const Key('left'))).width;
    final right = tester.getSize(find.byKey(const Key('right'))).width;
    expect(left, closeTo(right, 0.1));
    expect(left, lessThan(600));
    expect(left + right + 16, closeTo(1200, 0.5));
  });

  testWidgets('a disabled button does not call onPressed', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: NextButton(
          enabled: false,
          onPressed: () => taps++,
          child: const Text('Save'),
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    expect(taps, 0);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });

  testWidgets('NextShow follows the parent breakpoint', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: SizedBox(
            width: 800,
            child: NextShow(
              from: Breakpoint.lg,
              fallback: Text('narrow'),
              child: Text('wide'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('narrow'), findsOneWidget);
    expect(find.text('wide'), findsNothing);
  });
}

class _BreakpointLabel extends StatelessWidget {
  const _BreakpointLabel();

  @override
  Widget build(BuildContext context) {
    return Text(context.breakpoint.name);
  }
}
