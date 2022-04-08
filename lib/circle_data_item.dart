import 'package:flutter/material.dart';

import 'circle_progress_controller.dart';

/// Define pie chart Type.
enum CircleShader { butt, round, circleNone }

/// Pie chart Model class.
class CircleDataItem {
  CircleDataItem({
    required this.circleForwardFlg,
    required this.circleShader,
    required this.complementCircle,
    required this.circleSizeValue,
    required this.circleLabelValue,
    required this.circleLabelSpeedValue,
    required this.circleCounterValue,
    required this.circleSpeedCounterValue,
    required this.circleStrokeWidth,
    required this.circleShadowValue,
    required this.circlePointerValue,
    required this.circleDuration,
    required this.circleColor,
    required this.circleShadowColor,
    required this.circleRoundColor,
    required this.circleController,
    required this.circleColorList,
    Color? this.circleCombinedColor,
    List<Color>? circleCombinedColorList,
    List<double>? startValue,
    List<double>? endValue,
    List<String>? cicleListText,
  });

  bool circleForwardFlg;
  CircleShader circleShader;
  double complementCircle;
  double circleSizeValue;
  double circleLabelValue;
  double circleLabelSpeedValue;
  double circleCounterValue;
  double circleSpeedCounterValue;
  double circleStrokeWidth;
  double circleShadowValue;
  double circlePointerValue;
  int circleDuration;
  Color circleColor;
  Color circleShadowColor;
  Color circleRoundColor;
  List<List<Color>> circleColorList = [
    [],
  ];
  CircleProgressController circleController = CircleProgressController();
  Color? circleCombinedColor;
  List<Color>? circleCombinedColorList = [];
  List<double>? startValue = [];
  List<double>? endValue = [];
  List<String>? cicleListText = [];
}
