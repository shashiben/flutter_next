import 'package:flutter/material.dart';
import 'package:animation_next/animation_next.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Next Animation Example',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Animation Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bounce Animation
            NextBounceAnimation(
              variant: NextBounceVariant.bounceInTop,
              child: Container(
                height: 100,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  'Bounce Animation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Fade In Animation
            NextFadeInAnimation(
              variant: NextFadeInVariant.fadeIn,
              child: Container(
                height: 100,
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text(
                  'Fade In Animation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Slide Animation
            NextSlideAnimation(
              variant: NextSlideVariant.slideInLeft,
              child: Container(
                height: 100,
                color: Colors.orange,
                alignment: Alignment.center,
                child: const Text(
                  'Slide Animation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Zoom Animation
            NextZoomAnimation(
              variant: NextZoomVariant.zoomIn,
              child: Container(
                height: 100,
                color: Colors.purple,
                alignment: Alignment.center,
                child: const Text(
                  'Zoom Animation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Flip Animation
            NextFlipAnimation(
              variant: NextFlipVariant.flipInX,
              child: Container(
                height: 100,
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text(
                  'Flip Animation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Color Tween
            NextColorTweenWidget(
              beginColor: Colors.blue,
              endColor: Colors.pink,
              autoStart: true,
              child: (controller, color) {
                return Container(
                  height: 100,
                  color: color ?? Colors.blue,
                  alignment: Alignment.center,
                  child: const Text(
                    'Color Tween Animation',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
