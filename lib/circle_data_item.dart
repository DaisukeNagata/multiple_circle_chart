library multiple_circle_chart;

import 'package:flutter/material.dart';
import 'circle_progress_controller.dart';

enum CircleShader { butt, round, circleNone }

class CircleDataItem {
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

  CircleDataItem(
      this.circleForwardFlg,
      this.circleShader,
      this.complementCircle,
      this.circleSizeValue,
      this.circleLabelValue,
      this.circleLabelSpeedValue,
      this.circleCounterValue,
      this.circleSpeedCounterValue,
      this.circleStrokeWidth,
      this.circleShadowValue,
      this.circlePointerValue,
      this.circleDuration,
      this.circleColor,
      this.circleShadowColor,
      this.circleRoundColor,
      this.circleController,
      this.circleColorList);
}
