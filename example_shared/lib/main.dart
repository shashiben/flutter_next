import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'pages/playground_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(const DocsApp());
}

class DocsApp extends StatelessWidget {
  const DocsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Next Animation & Flutter Next Documentation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
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
  initialLocation: '/playground',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/playground',
    ),
    GoRoute(
      path: '/playground',
      builder: (context, state) => PlaygroundPage(state: state),
    ),
  ],
);
