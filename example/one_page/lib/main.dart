import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app/router.dart';
import 'app/theme.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Testing Bootstrap',
      theme: themeData(context),
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
    );
  }
}
