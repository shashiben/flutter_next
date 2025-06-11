import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class BounceAnimationsExample extends StatelessWidget {
  const BounceAnimationsExample({super.key});

  @override
  Widget build(BuildContext context) {
    var icons = [
      Icons.favorite,
      Icons.star,
      Icons.thumb_up,
      Icons.sentiment_satisfied,
    ];

    return Row(
      children: NextBounceVariant.values.asMap().entries.map((entry) {
        var e = entry.value;
        var icon = icons[entry.key % icons.length];
        return NextBounceAnimation(
          variant: e,
          duration: const Duration(milliseconds: 2500),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.orange,
            child: Center(
              child: Icon(
                icon,
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
