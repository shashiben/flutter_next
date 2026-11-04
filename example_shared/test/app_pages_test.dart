import 'package:example/main.dart';
import 'package:example/pages/apps/checkout_page.dart';
import 'package:example/pages/apps/dashboard_page.dart';
import 'package:example/pages/apps/devices_page.dart';
import 'package:example/pages/apps/landing_page.dart';
import 'package:example/pages/apps/storefront_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('the gallery lists the live apps', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ShowcaseApp());
    await tester.pump();

    expect(find.text('Storefront'), findsWidgets);
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Checkout'), findsWidgets);
    expect(find.text('Landing'), findsWidgets);
    expect(find.text('Devices'), findsWidgets);
    expect(find.text('The frame changes.'), findsOneWidget);
    expect(find.text('Layout follows the parent'), findsNothing);
  });

  testWidgets('the storefront reads the width of its parent', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              SizedBox(
                width: 420,
                height: 900,
                child: NextScope(child: StorefrontView()),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    // A narrow parent drops the filter rail panel but shows the
    // inline filter button.
    expect(find.text('Filters'), findsOneWidget);
    expect(find.text('In stock only'), findsNothing);
    expect(find.text('Featured gear'), findsOneWidget);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: StorefrontPage())),
    );
    await tester.pump();

    // A wide parent keeps the rail panel.
    expect(find.text('Filters'), findsOneWidget);
    expect(find.text('In stock only'), findsOneWidget);
    expect(find.text('Featured gear'), findsOneWidget);
  });

  testWidgets('the checkout applies a promo code', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CheckoutPage())),
    );
    await tester.pump();

    expect(find.text('TEAM10 applied'), findsNothing);

    await tester.ensureVisible(find.text('Apply'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();

    expect(find.text('TEAM10 applied'), findsOneWidget);
    expect(find.text('Pay \$467.40'), findsOneWidget);
  });

  testWidgets('the checkout puts the summary first on a phone', (tester) async {
    tester.view.physicalSize = const Size(390, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CheckoutPage())),
    );
    await tester.pump();

    final summary = tester.getTopLeft(find.text('Order summary'));
    final contact = tester.getTopLeft(find.text('Contact'));
    expect(summary.dy, lessThan(contact.dy));
  });

  testWidgets('the devices page previews the same app at three widths', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DevicesPage())),
    );
    await tester.pump();

    expect(find.text('One widget tree, three widths'), findsOneWidget);
    expect(find.textContaining('iPhone 16 · 393px · xs'), findsOneWidget);
    expect(find.textContaining('820px · md'), findsOneWidget);
    expect(find.textContaining('1920px · xxl'), findsOneWidget);
  });

  testWidgets('the overview shows the apps and the span inspector', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    expect(find.text('The frame changes.'), findsOneWidget);
    expect(find.text('Commerce'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('Layout'), findsOneWidget);
    expect(find.text('col-12 col-md-6 col-lg-4'), findsOneWidget);
    expect(find.text('400 px · xs'), findsOneWidget);
  });

  testWidgets('an example tile opens its screen', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Commerce'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Commerce'));
    await tester.pumpAndSettle();

    expect(find.text('Featured gear'), findsOneWidget);
  });

  testWidgets('scroll settings change the wheel behaviour', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Scroll settings'));
    await tester.pumpAndSettle();

    expect(find.text('Lenis'), findsOneWidget);
    expect(
      find.text('Eases with decay. Lower damping feels heavier.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Direct'));
    await tester.pumpAndSettle();

    expect(find.text('Applies the notch on the same frame.'), findsOneWidget);
    expect(find.text('Damping'), findsNothing);

    await tester.tap(find.text('Elastic'));
    await tester.pumpAndSettle();
    expect(find.text('Stiffness'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the overview has no overflow from phone to desktop', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1;

    for (final width in <double>[360, 768, 1200, 1600]) {
      tester.view.physicalSize = Size(width, 1000);
      await tester.pumpWidget(ShowcaseApp(key: ValueKey<double>(width)));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'home at ${width}px');

      await tester.ensureVisible(find.text('Five apps. Same kit.'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'tiles at ${width}px');
    }
  });

  testWidgets('the apps have no overflow from phone to desktop', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1;

    const pages = <Widget>[
      StorefrontPage(),
      DashboardPage(),
      CheckoutPage(),
      LandingPage(),
      DevicesPage(),
    ];
    for (final width in <double>[360, 834, 1280]) {
      tester.view.physicalSize = Size(width, 900);
      for (final page in pages) {
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: page)));
        await tester.pump();
        expect(
          tester.takeException(),
          isNull,
          reason: '${page.runtimeType} at ${width}px',
        );
      }
    }
  });

  test('bootstrap classes resolve to tracks', () {
    // col-12 col-md-6 col-lg-4 carries down to the widest breakpoint.
    final span = NextSpan.parse('col-12 col-md-6 col-lg-4');
    final tracks = span.resolve();
    expect(tracks[Breakpoint.xs], 12);
    expect(tracks[Breakpoint.sm], 12);
    expect(tracks[Breakpoint.md], 6);
    expect(tracks[Breakpoint.lg], 4);
    expect(tracks[Breakpoint.xl], 4);
    expect(tracks[Breakpoint.xxl], 4);

    final track = NextTrack.parse('offset-lg-2');
    expect(track.resolve()[Breakpoint.md], 0);
    expect(track.resolve()[Breakpoint.lg], 2);
  });
}
