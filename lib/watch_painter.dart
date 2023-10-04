import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class WatchPainter extends CustomPainter {
  DateTime now;
  bool isDigits;
  WatchPainter({required this.now, this.isDigits = false});
  static const tickWidthDecider = 0.01;
  static const minuteTickHeightDecider = 0.05;
  static const hourTickHeightDecider = 0.1;
  static const numberOfTicks = 60;
  static const romans = [
    'XII',
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI',
  ];
  static const digits = [
    '12',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
  ];
  bool isHour = false;

  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final radius = min(width, height) / 2;

    // Watch Dial Parameters
    final centerOffset = Offset(width / 2, height / 2);
    final watchDialPaint = Paint()
      ..color = Colors.white
      ..shader = const RadialGradient(
        colors: [Colors.grey, Colors.blueGrey, Colors.grey],
        stops: [0.3, 0.7, 1.0],
      ).createShader(
        Rect.fromLTWH(0, 0, width, height),
      )
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
    // Hour Hand and minute Hand parameters
    final hourHandGap = radius * 0.6;
    final minuteHandGap = radius * 0.45;
    final secondsHandGap = radius * 0.3;
    final textGap = radius * 0.15;
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = radius * 0.02;
    final minuteHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = radius * 0.02;
    final secondsHandPaint = Paint()..color = Colors.red;

    // Line Parameters
    final lineStartOffset = Offset(0, -radius);
    final hourLineEndOffset = Offset(0, -radius + hourTickHeight);
    final minuteLineEndOffset = Offset(0, -radius + minuteTickHeight);

    canvas.drawCircle(
        centerOffset, radius * 0.03, Paint()..color = Colors.black);

    // Setting canvas start point
    canvas.save();
    canvas.translate(radius, radius);

    // Draw Ticks on Watch Dial
    for (var i = 0; i < numberOfTicks; i++) {
      i % 5 == 0 ? isHour = true : isHour = false;
      isHour
          ? canvas.drawLine(lineStartOffset, hourLineEndOffset, tickPaint)
          : canvas.drawLine(lineStartOffset, minuteLineEndOffset, tickPaint);
      if (isHour) {
        if (i / 5 == now.hour) {
          // canvas.drawPath(
          //     Path()
          //       ..moveTo(0, 0)
          //       ..lineTo(0, -radius + hourHandGap)
          //       ..close(),
          //     hourHandPaint);
          canvas.drawLine(const Offset(0, 0), Offset(0, -radius + hourHandGap),
              hourHandPaint);
        }
        TextPainter()
          ..textDirection = TextDirection.ltr
          ..text = TextSpan(
            text: isDigits ? romans[i ~/ 5] : digits[i ~/ 5],
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          )
          ..layout()
          ..paint(canvas, Offset(0 - 4, -radius + textGap));
      }
      if (i == now.minute) {
        canvas.drawLine(const Offset(0, 0), Offset(0, -radius + minuteHandGap),
            minuteHandPaint);
      }
      if (i == now.second) {
        canvas.drawLine(const Offset(0, 0), Offset(0, -radius + secondsHandGap),
            secondsHandPaint);
      }
      canvas.rotate(rotateAngle);
      // }
    }
    // else {
    // if (i == minute) {
    //   canvas.drawLine(
    //     const Offset(0, 0),
    //     Offset(0, -radius + minuteHourGap),
    //     minuteHandPaint,
    //   );
    // }
    // }

    // }
    canvas.restore();
  }

  @override
  bool shouldRepaint(WatchPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WatchPainter oldDelegate) => true;
}
