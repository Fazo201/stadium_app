import 'package:flutter/material.dart';

class CurrentLocationIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.blue.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 6;

    final Offset circleCenter = Offset(size.width / 2, size.height / 2);
    final double circleRadius = size.width / 3;

    // Рисуем круг
    canvas.drawCircle(circleCenter, circleRadius, circlePaint);

    // Рисуем обводку круга
    canvas.drawCircle(circleCenter, circleRadius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
