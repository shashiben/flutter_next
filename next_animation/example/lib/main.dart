import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'pages/home_page.dart';
import 'pages/bounce_page.dart';
import 'pages/fade_page.dart';
import 'pages/slide_page.dart';
import 'pages/zoom_page.dart';
import 'pages/flip_page.dart';
import 'pages/color_tween_page.dart';
import 'pages/getting_started_page.dart';
import 'pages/api_reference_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(const DocsApp());
}

class DocsApp extends StatelessWidget {
  const DocsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Next Animation Documentation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/getting-started',
      builder: (context, state) => const GettingStartedPage(),
    ),
    GoRoute(
      path: '/bounce',
      builder: (context, state) => const BouncePage(),
    ),
    GoRoute(
      path: '/fade',
      builder: (context, state) => const FadePage(),
    ),
    GoRoute(
      path: '/slide',
      builder: (context, state) => const SlidePage(),
    ),
    GoRoute(
      path: '/zoom',
      builder: (context, state) => const ZoomPage(),
    ),
    GoRoute(
      path: '/flip',
      builder: (context, state) => const FlipPage(),
    ),
    GoRoute(
      path: '/color-tween',
      builder: (context, state) => const ColorTweenPage(),
    ),
    GoRoute(
      path: '/api',
      builder: (context, state) => const ApiReferencePage(),
    ),
  ],
);

