import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class ColorTweenAnimationExample extends StatelessWidget {
  const ColorTweenAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return NextColorTweenWidget(
      beginColor: Colors.orange,
      endColor: Colors.blue,
      animationDuration: const Duration(milliseconds: 2500),
      child: (controller, color) {
        return Container(
          width: 100,
          height: 100,
          color: color,
          child: const Center(
            child: Icon(
              Icons.star,
              size: 50,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
