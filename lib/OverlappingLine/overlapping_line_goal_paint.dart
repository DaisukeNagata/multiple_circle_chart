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
    ///　This is because it does not overlap with the ruled line.
    double goalStartX = 1;
    final paint = Paint()
      ..color = goalModel.goalLineColor
      ..strokeWidth = goalModel.goalLineWidth;

    ///　Loop that assigns and judges values up to the specified value.
    while (goalStartX + goalModel.goalDashWidth < sizeSet.width) {
      canvas.drawLine(
        /// wLines is the highest value in the chart area.
        Offset(
          goalStartX,
          boxSize * (wLines - goalModel.goalLineValue),
        ),

        /// Move to the X axis.
        Offset(
          goalStartX + goalModel.goalDashWidth,
          boxSize * (wLines - goalModel.goalLineValue),
        ),
        paint,
      );

      ///　Each element increments the x-axis value.
      goalStartX += goalModel.goalLineWidth + goalModel.goalDashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
