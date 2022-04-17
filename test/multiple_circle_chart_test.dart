import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/circle_progress_controller.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';

void main() {
  late CircleDataItem c = CircleDataItem(

      /// circleForwardFlg is forward or reverse.
      circleForwardFlg: true,

      /// CircleShader is an end type circle None has no knob.
      circleShader: CircleShader.circleNone,

      /// ComplementCircle is the tuning when the circle is changed to large or small.
      complementCircle: 0.05,

      /// circleSizeValue.
      circleSizeValue: 0.0,

      /// CircleLabelValue is reverse.
      circleLabelValue: 0.0,

      /// circleLabelSpeedValue is speed.
      circleLabelSpeedValue: 0.0,

      /// circleCounterValue is forward.
      circleCounterValue: 0.0,

      /// circleSpeedCounterValue is speed.
      circleSpeedCounterValue: 0.0,

      /// circleStrokeWidth is the thickness of the circle.
      circleStrokeWidth: 30.0,

      /// circleShadowValue is The shadow range value
      circleShadowValue: 0.01,

      /// circlePointerValue is The size of the knob.
      circlePointerValue: 15,

      /// circleDuration is circle animation speed
      circleDuration: 0,

      /// circleColor is the color of the knob.
      circleColor: Colors.green,

      /// circleColor is the shadow color of the knob.
      circleShadowColor: Colors.black,

      /// circleRoundColor is The base color of circleRoundColor.
      circleRoundColor: Colors.grey,

      /// circleController is CircleProgressController.
      circleController: CircleProgressController(),

      /// circleColorList is Determines the gradient color.
      circleColorList: [[]],
      circleTextSizeList: []);
  test('adds one to input values', () {
    final circleSetProgress = MultipleCircleSetProgress(circle: c);
    expect(circleSetProgress.addOne(2), 3);
    expect(circleSetProgress.addOne(-7), -6);
    expect(circleSetProgress.addOne(0), 1);
  });
}
