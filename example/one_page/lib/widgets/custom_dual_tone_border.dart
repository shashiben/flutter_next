import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    const double lineWidth = 60;

    final Paint redPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final Path topRightArc = Path()
      ..moveTo(w, h)
      ..lineTo(w - lineWidth, h);

    final Path bottomLeftArc = Path()
      ..moveTo(w, h)
      ..lineTo(w, h - lineWidth);
    final Path c = Path()
      ..moveTo(0, 0)
      ..lineTo(lineWidth, 0);

    final Path d = Path()
      ..moveTo(0, 0)
      ..lineTo(0, lineWidth);

    canvas.drawPath(topRightArc, redPaint);
    canvas.drawPath(bottomLeftArc, redPaint);
    canvas.drawPath(c, redPaint);
    canvas.drawPath(d, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
