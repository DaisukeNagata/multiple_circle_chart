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
    required this.circleStrokeWidth,
    required this.circleShadowValue,
    required this.circleDuration,
    required this.circleColor,
    required this.circleShadowColor,
    required this.circleRoundColor,
    required this.circleController,
    required this.circleColorList,
    double? circleCounterValue,
    double? circlePointerValue,
    double? circleLabelValue,
    double? circleLabelSpeedValue,
    double? circleSpeedCounterValue,
    double? circleCombinedTextSize,
    Size? graphTextSize,
    List<Size>? circleTextSizeList,
    List<Color>? circleCombinedColor,
    List<Color>? circleCombinedColorList,
    List<double>? startValue,
    List<double>? endValue,
    List<String>? circleListText,
  });

  bool circleForwardFlg;
  CircleShader circleShader;
  double complementCircle;
  double circleSizeValue;
  double? circleLabelValue;
  double? circleLabelSpeedValue;
  double? circleCounterValue;
  double? circleSpeedCounterValue;
  double circleStrokeWidth;
  double circleShadowValue;
  double? circlePointerValue;
  int circleDuration;
  Color circleColor;
  Color circleShadowColor;
  Color circleRoundColor;
  List<List<Color>> circleColorList = [
    [],
  ];
  CircleProgressController circleController = CircleProgressController();
  double? circleCombinedTextSize;
  List<Size>? graphTextSizeList;
  List<Color>? circleCombinedColor;
  List<Color>? circleCombinedColorList = [];
  List<double>? startValue = [];
  List<double>? endValue = [];
  List<String>? circleTextList = [];
}
