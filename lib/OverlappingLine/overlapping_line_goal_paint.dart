import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_goal_model.dart';

/// Logic to set a target line.
class OverlappingLineGoalPaint extends CustomPainter {
  final double boxSize;
  final int wLines;
  final Size sizeSet;
  final OverlappingGoalModel goalModel;

  OverlappingLineGoalPaint({
    required this.boxSize,
    required this.wLines,
    required this.sizeSet,
    required this.goalModel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double goalStartX = 1;
    double sizeSetWidthMargin = 0;
    final paint = Paint()
      ..color = goalModel.goalLineColor
      ..strokeWidth = goalModel.goalLineWidth;
    sizeSetWidthMargin == 0 ? goalStartX : sizeSetWidthMargin;

    ///　Loop that assigns and judges values up to the specified value.
    while (goalStartX < sizeSet.width) {
      canvas.drawLine(
        Offset(
          goalStartX,
          boxSize * (wLines - goalModel.goalLineValue),
        ),
        Offset(
          goalStartX + goalModel.goalDashWidth + sizeSetWidthMargin,
          boxSize * (wLines - goalModel.goalLineValue),
        ),
        paint,
      );
      goalStartX += goalModel.goalLineWidth +
          goalModel.goalDashSpace +
          sizeSetWidthMargin;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
