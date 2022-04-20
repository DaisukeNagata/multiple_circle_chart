import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/circle_progress_controller.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';

import 'main_set_color_model.dart';

class MainCircleDataModel {
  double speedValue = 0.0;
  double circleSize = 0.0;
  double fValue = 0.0;
  double rValue = 0.0;
  double circleLabelValue = 0.0;
  double padValue = 30;
  final double padTopBottom = 60;
  final ScrollController scrollController = ScrollController();
  bool circleColorFlg = true;
  bool circleShaderFlg = true;
  bool circleCombineFlg = true;
  final GlobalKey circleKey = GlobalKey();
  final GlobalKey globalKey = GlobalKey();
  final GlobalKey circleColorKey = GlobalKey();
  final GlobalKey circleShaderFlgKey = GlobalKey();
  final GlobalKey circleCombinedKey = GlobalKey();
  late MultipleCircleSetProgress? circleSetProgress;
  late final MainSetColorModel setColorModel = MainSetColorModel();
  final CircleProgressController controller = CircleProgressController();

  late CircleDataItem circleData = CircleDataItem(

      /// circleForwardFlg is forward or reverse.
      circleForwardFlg: true,

      /// CircleShader is an end type circle None has no knob.
      circleShader: CircleShader.circleNone,

      /// ComplementCircle is the tuning when the circle is changed to large or small.
      complementCircle: 0.05,

      /// circleSizeValue.
      circleSizeValue: circleSize,

      /// circleStrokeWidth is the thickness of the circle.
      circleStrokeWidth: 30.0,

      /// circleShadowValue is The shadow range value
      circleShadowValue: 0.01,

      /// circleDuration is circle animation speed
      circleDuration: speedValue.toInt(),

      /// circleColor is the color of the knob.
      circleColor: Colors.green,

      /// circleColor is the shadow color of the knob.
      circleShadowColor: Colors.black,

      /// circleRoundColor is The base color of circleRoundColor.
      circleRoundColor: Colors.grey,

      /// circleController is CircleProgressController.
      circleController: controller,

      /// circleColorList is Determines the gradient color.
      circleColorList: setColorModel.setColor,

      /// circleTextSizeList is get character coordinates.
      circleTextSizeList: []);
}
