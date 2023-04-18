import 'package:flutter/material.dart';

class WaveLine extends CustomPainter {
  double amplitude;
  Color color;
  WaveLine({required this.amplitude, this.color = Colors.black});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.cubicTo(size.width / 15, -amplitude, (size.width * 2) / 15, -amplitude,
        (size.width * 3) / 15, 0);
    path.cubicTo((size.width * 4) / 15, amplitude, (size.width * 5) / 15,
        amplitude, (size.width * 6) / 15, 0);
    path.cubicTo((size.width * 7) / 15, -amplitude, (size.width * 8) / 15,
        -amplitude, (size.width * 9) / 15, 0);
    path.cubicTo((size.width * 10) / 15, amplitude, (size.width * 11) / 15,
        amplitude, (size.width * 12) / 15, 0);
    path.cubicTo((size.width * 13) / 15, -amplitude, (size.width * 14) / 15,
        -amplitude, (size.width * 15) / 15, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WaveLine oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(WaveLine oldDelegate) => false;
}
