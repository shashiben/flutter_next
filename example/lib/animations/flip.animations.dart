import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class FlipAnimationsExample extends StatelessWidget {
  const FlipAnimationsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: NextFlipVariant.values.asMap().entries.map((entry) {
        var e = entry.value;
        return NextFlipAnimation(
          flipVariant: e,
          animationDuration: const Duration(milliseconds: 2500),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.orange,
            child: const Center(
              child: Icon(
                Icons.star,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
