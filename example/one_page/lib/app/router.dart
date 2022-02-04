import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home.dart';
import '../views/portfolio_detail_section.dart';

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(key: state.pageKey, child: const Home()),
    ),
    GoRoute(
      path: '/portfolio-details',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
              key: state.pageKey, child: const PortfolioDetailSection()),
    )
  ],
  urlPathStrategy: UrlPathStrategy.path,
);
