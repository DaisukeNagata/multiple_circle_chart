import 'dart:ui';

class OverlappingGoalModel {
  const OverlappingGoalModel({
    required this.goalDashWidth,
    required this.goalDashSpace,
    required this.goalLineWidth,
    required this.goalLineValue,
    required this.goalLineColor,
  });

  final double goalDashWidth, goalDashSpace, goalLineValue, goalLineWidth;
  final Color goalLineColor;
}
