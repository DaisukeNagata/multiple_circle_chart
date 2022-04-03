import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/circle_progress_controller.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';


void main() {
  List<List<Color>> circleColorList = [
    [],
  ];
  late CircleDataItem c = CircleDataItem(
    true,
    // CircleShader
    CircleShader.circleNone,
    // complementCircle
    0.05,
    // circleSizeValue
    0.0,
    // circleSizeValue
    0.0,
    // circleCounterLabel
    0.0,
    // circleSpeedCounterValue
    0.0,
    // circleLabelSpeedValue
    0.0,
    // circleCounter
    30.0,
    // circleStrokeWidth
    0.01,
    // circleShadowRange
    15,
    // circlePointerValue
    0,
    // circleDuration
    Colors.green,
    // circleColor
    Colors.black,
    // circleShadowColor
    Colors.grey,
    /// CircleProgressController
    CircleProgressController(),
    /// List<<Color>>
    circleColorList,
  );
  test('adds one to input values', () {
    final circleSetProgress = MultipleCircleSetProgress(circle: c);
    expect(circleSetProgress.addOne(2), 3);
    expect(circleSetProgress.addOne(-7), -6);
    expect(circleSetProgress.addOne(0), 1);
  });
}
