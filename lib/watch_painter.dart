import 'dart:math';

import 'package:flutter/material.dart';

class WatchPainter extends CustomPainter {
  static const tickWidthDecider = 0.01;
  static const minuteTickHeightDecider = 0.05;
  static const hourTickHeightDecider = 0.1;
  static const numberOfTicks = 60;
  bool isHour = false;

  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final radius = min(width, height) / 2;

    // Watch Dial Parameters
    final centerOffset = Offset(width / 2, height / 2);
    final watchDialPaint = Paint()
      ..color = Colors.black38
      ..style = PaintingStyle.fill;

    // Draw Watch Dial
    canvas.drawCircle(centerOffset, radius, watchDialPaint);

    // Watch Ticks
    final tickWidth = radius * tickWidthDecider;
    final hourTickHeight = radius * hourTickHeightDecider;
    final minuteTickHeight = radius * minuteTickHeightDecider;
    const rotateAngle = (2 * pi) / numberOfTicks;
    final tickPaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = tickWidth;

    // Line Parameters
    final lineStartOffset = Offset(0, radius);
    final hourLineEndOffset = Offset(0, radius - hourTickHeight);
    final minuteLineEndOffset = Offset(0, radius - minuteTickHeight);

    // Setting canvas start point
    canvas.save();
    canvas.translate(radius, radius);

    // Draw Ticks on Watch Dial
    for (var i = 0; i < numberOfTicks; i++) {
      i % 5 == 0
          ? canvas.drawLine(lineStartOffset, hourLineEndOffset, tickPaint)
          : canvas.drawLine(lineStartOffset, minuteLineEndOffset, tickPaint);
      canvas.rotate(rotateAngle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(WatchPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WatchPainter oldDelegate) => true;
}
