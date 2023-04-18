import 'package:flutter/material.dart';

class WaterDropPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  WaterDropPainter({this.color = Colors.blue, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width / 2, 0);
    path.cubicTo(size.width * 0.8, 0, size.width, size.height * 0.4, size.width,
        size.height * 0.6);
    path.cubicTo(size.width, size.height * 0.8, size.width * 0.8, size.height,
        size.width / 2, size.height);
    path.cubicTo(size.width * 0.2, size.height, 0, size.height * 0.8, 0,
        size.height * 0.6);
    path.cubicTo(0, size.height * 0.4, size.width * 0.2, 0, size.width / 2, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
