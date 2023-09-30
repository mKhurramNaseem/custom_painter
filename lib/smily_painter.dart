import 'dart:math';

import 'package:flutter/material.dart';

class SmileyPainter extends CustomPainter {
  final Color? faceColor;
  final double smileStrength;
  final double eyeBallRadiusDecider;

  SmileyPainter({this.faceColor = Colors.yellow, this.smileStrength = 0.25 , this.eyeBallRadiusDecider = 0.5,});
  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final radius = min(width, height) / 2;
    final displacementFromCenter = radius * 0.35;
    final smileControl = radius * smileStrength;
    final mouthLengthDisplacement = radius * 0.38;
    // final mouthWidth = radius * 0.9;
    // final mouthHeight = radius * 0.7;

    // Face Parameters
    final facePaint = Paint()
      ..color = faceColor == null ? Colors.yellow : faceColor!
      ..style = PaintingStyle.fill
      ;
    final faceOffset = Offset(width / 2, height / 2);

    // Eyes Common Parameters
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final eyeRadius = radius * 0.2;

    // Left Eye Parameters
    final leftEyeOffset = Offset(faceOffset.dx - displacementFromCenter,
        faceOffset.dy - displacementFromCenter);

    // Right Eye Parameters
    final rightEyeOffset = Offset(faceOffset.dx + displacementFromCenter,
        faceOffset.dy - displacementFromCenter);

    // EyeBalls Common Parameters
    final eyeBallPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    final eyeBallRadius = eyeRadius * eyeBallRadiusDecider;

    // Mouth Parameters
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    // final mouthOffset =
    //     Offset(faceOffset.dx, faceOffset.dy + moutDisplacementFromCenter);
    final mouthStartPoint = Offset(
      faceOffset.dx - mouthLengthDisplacement,
      faceOffset.dy + mouthLengthDisplacement,
    );
    final mouthEndPoint = Offset(faceOffset.dx + mouthLengthDisplacement,
        faceOffset.dy + mouthLengthDisplacement);

    final mouthControlPoint = Offset(
        (mouthEndPoint.dx + mouthStartPoint.dx) / 2,
        mouthStartPoint.dy + smileControl);

    // Mouth Parameters

    // Draw Face
    canvas.drawCircle(faceOffset, radius, facePaint);

    // Draw Left Eye
    canvas.drawCircle(leftEyeOffset, eyeRadius, eyePaint);

    // Draw Right Eye
    canvas.drawCircle(rightEyeOffset, eyeRadius, eyePaint);

    // Draw Left Eye Ball
    canvas.drawCircle(leftEyeOffset, eyeBallRadius, eyeBallPaint);

    // Draw Right Eye Ball
    canvas.drawCircle(rightEyeOffset, eyeBallRadius, eyeBallPaint);

    // // Draw Mouth
    // canvas.drawArc(
    //     Rect.fromCenter(
    //       center: mouthOffset,
    //       width: mouthWidth,
    //       height: mouthHeight,
    //     ),
    //     degreeToRad(0),
    //     degreeToRad(180),
    //     false,
    //     mouthPaint);

    // canvas.drawLine(mouthStartPoint, mouthEndPoint, mouthPaint);
    // Draw Mouth Through Quadratic Bezier
    canvas.drawPath(
        Path()
          ..moveTo(
            mouthStartPoint.dx,
            mouthStartPoint.dy,
          )
          ..quadraticBezierTo(
            mouthControlPoint.dx,
            mouthControlPoint.dy,
            mouthEndPoint.dx,
            mouthEndPoint.dy,
          ),
        mouthPaint);
  }

  @override
  bool shouldRepaint(SmileyPainter oldDelegate) =>
      oldDelegate.faceColor != faceColor;

  @override
  bool shouldRebuildSemantics(SmileyPainter oldDelegate) =>
      oldDelegate.faceColor != faceColor;

  double degreeToRad(double degree) {
    return pi / 180 * degree;
  }
}
