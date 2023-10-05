import 'dart:math';

import 'package:flutter/material.dart';

class SpeedoMeterPainter extends CustomPainter {
  int speed = 0;
  int speedTextValue = 0;
  List<Offset> list = [];
  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final radius = min(width, height) / 2;

    // SpeedoMeter Dial
    final dialPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final dialOffset = Offset(width / 2, height / 2);

    // Draw Dial
    canvas.drawCircle(dialOffset, radius, dialPaint);

    // Main Tick Parameter
    final mainTickLength = radius * 0.15;
    final secondaryTickLength = mainTickLength / 2;
    final startOffset = Offset(0, radius);
    final mainTickEndOffset = Offset(0, radius - mainTickLength);
    final secondaryTickEndOffset = Offset(0, radius - secondaryTickLength);
    final mainTickPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = radius * 0.02;
    final secondaryTickPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = radius * 0.01;

    // Rotation Angles
    const rotationAngle = (2 * pi) / 120;
    const initialRotationAngle = rotationAngle * 20;

    // Text Painter Parameters
    final textGap = mainTickLength + radius * 0.1;
    final textPainterOffset = Offset(0 - 5, radius - textGap);

    // Save Canvas State
    canvas.save();
    canvas.translate(radius, radius);
    canvas.rotate(initialRotationAngle);

    for (var i = 0; i < 81; i++) {
      if (i % 5 == 0) {
        canvas.drawLine(startOffset, mainTickEndOffset, mainTickPaint);
        TextPainter()
          ..textDirection = TextDirection.ltr
          ..text = TextSpan(
            text: speedTextValue.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
          ..layout()
          ..paint(canvas, textPainterOffset);
        speedTextValue += 10;
      } else {
        canvas.drawLine(
            startOffset, secondaryTickEndOffset, secondaryTickPaint);
      }
      canvas.rotate(rotationAngle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(SpeedoMeterPainter oldDelegate) =>
      speed != oldDelegate.speed;

  @override
  bool shouldRebuildSemantics(SpeedoMeterPainter oldDelegate) => true;
}
