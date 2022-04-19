import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';

import 'main.dart';
import 'main_circle_data_model.dart';

class MainViewModel {
  late final MainCircleDataModel mainCircleDataModel = MainCircleDataModel();

  circleSet(BuildContext context) {
    /// Determine the size of the circle.
    mainCircleDataModel.circleSize = mainCircleDataModel.circleSize == 0.0
        ? MediaQuery.of(context).size.width / 2
        : mainCircleDataModel.circleSize;
    mainCircleDataModel.circleSetProgress = MultipleCircleSetProgress(
        circleKey: mainCircleDataModel.circleKey,
        circle: mainCircleDataModel.circleData);
  }

  Widget switchSetRow(MyHomePageState m, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        switchSet(m, context, mainCircleDataModel.circleColorKey),
        switchSet(m, context, mainCircleDataModel.circleShaderFlgKey),
        switchSet(m, context, mainCircleDataModel.circleCombinedKey),
      ],
    );
  }

  Column textSets() {
    return Column(
      children: [
        Padding(
            padding:
                EdgeInsets.only(top: mainCircleDataModel.paddingValue * 2)),
        Text("end${mainCircleDataModel.fValue}"),
        Text("start${mainCircleDataModel.rValue}"),
        Text("speed${mainCircleDataModel.circleData.circleDuration}"),
        Text("size${mainCircleDataModel.circleData.circleSizeValue}"),
      ],
    );
  }

  Column sliderSets(MyHomePageState m, BuildContext con) {
    return Column(
      children: [
        wSlider(
            m,
            con,
            RangeValues(mainCircleDataModel.rValue, mainCircleDataModel.fValue),
            mainCircleDataModel.setColorModel.setColor.length.toDouble(),
            keyValue: mainCircleDataModel.globalKey),
        sliderSet(m, con, mainCircleDataModel.speedValue, 20000.0),
        sliderSet(m, con, mainCircleDataModel.circleSize,
            MediaQuery.of(con).size.width),
        Padding(padding: EdgeInsets.only(top: mainCircleDataModel.paddingValue))
      ],
    );
  }

  Row setRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                setButton(true, mainCircleDataModel.fValue,
                    mainCircleDataModel.circleData.circleLabelValue ?? 0),
                setButton(
                    false,
                    mainCircleDataModel.circleData.circleCounterValue ?? 0,
                    mainCircleDataModel.circleData.circleCounterValue == 0
                        ? 0
                        : mainCircleDataModel.rValue),
              ],
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: mainCircleDataModel.paddingValue)),
          ],
        ),
      ],
    );
  }

  Stack stack() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            mainCircleDataModel.circleLabelValue.toStringAsFixed(1),
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: mainCircleDataModel.paddingValue)),
        SizedBox(
          width: mainCircleDataModel.circleData.circleSizeValue,
          height: mainCircleDataModel.circleData.circleSizeValue,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(360 / 360),
            child: mainCircleDataModel.circleSetProgress,
            key: mainCircleDataModel.circleKey,
          ),
        ),
      ],
    );
  }

  RangeSlider wSlider(
      MyHomePageState m, BuildContext con, RangeValues values, max,
      {Key? keyValue}) {
    return RangeSlider(
      key: keyValue,
      values: values,
      max: max,
      divisions: 1000,
      labels: RangeLabels(
        values.start.round().toString(),
        values.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        m.wSlider(values);
      },
    );
  }

  Slider sliderSet(MyHomePageState m, BuildContext con, double value, max,
      {Key? keyValue}) {
    Padding(padding: EdgeInsets.only(top: mainCircleDataModel.paddingValue));
    return Slider(
      key: keyValue,
      value: value,
      min: 0,
      max: max,
      divisions: 1000,
      onChanged: (double value) {
        m.sliderSet(max, value, mainCircleDataModel.circleCombineFlg);
      },
    );
  }

  OutlinedButton setButton(
      bool forwardFlg, double counterValue, double circleLabelValue) {
    Padding(padding: EdgeInsets.only(top: mainCircleDataModel.paddingValue));
    return OutlinedButton(
      onPressed: () {
        mainCircleDataModel.circleData.circleForwardFlg = forwardFlg;
        mainCircleDataModel.circleData.circleCounterValue = counterValue;
        mainCircleDataModel.circleData.circleLabelSpeedValue = circleLabelValue;
        mainCircleDataModel.circleData.circleLabelValue = circleLabelValue;
        mainCircleDataModel.controller.setProgress([
          mainCircleDataModel.circleData.circleCounterValue ?? 0,
          mainCircleDataModel.circleData.circleLabelValue ?? 0
        ]);
      },
      child: const Icon(Icons.play_circle),
    );
  }

  CupertinoSwitch switchSet(MyHomePageState m, BuildContext con, Key keyValue) {
    Padding(
        padding: EdgeInsets.only(
            left: mainCircleDataModel.paddingValue,
            right: mainCircleDataModel.paddingValue));
    if (keyValue == mainCircleDataModel.circleColorKey) {
      return CupertinoSwitch(
        key: mainCircleDataModel.circleColorKey,
        value: mainCircleDataModel.circleColorFlg,
        onChanged: (flg) {
          _circleColorMethod(con, flg);
        },
      );
    } else if (keyValue == mainCircleDataModel.circleShaderFlgKey) {
      return CupertinoSwitch(
        key: mainCircleDataModel.circleShaderFlgKey,
        value: mainCircleDataModel.circleShaderFlg,
        onChanged: (flg) {
          _circleShaderFlgMethod(con, flg);
        },
      );
    } else {
      return CupertinoSwitch(
        key: mainCircleDataModel.circleCombinedKey,
        value: mainCircleDataModel.circleCombineFlg,
        onChanged: (flg) {
          m.combinedState(flg);
        },
      );
    }
  }

  _circleColorMethod(BuildContext context, bool flg) {
    mainCircleDataModel.circleColorFlg = flg;

    /// Determine the type of knob
    mainCircleDataModel.circleData.circleShader =
        mainCircleDataModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.butt
            : CircleShader.circleNone;

    /// Determine the knob color
    mainCircleDataModel.circleData.circleColor =
        mainCircleDataModel.circleData.circleColor == Colors.green
            ? Colors.green.withOpacity(0)
            : Colors.green;

    /// Determine the knob shadow color
    mainCircleDataModel.circleData.circleShadowColor =
        mainCircleDataModel.circleData.circleShadowColor == Colors.black
            ? Colors.black.withOpacity(0)
            : Colors.black;
  }

  _circleShaderFlgMethod(BuildContext context, bool flg) {
    /// Pie chart animation direction.
    mainCircleDataModel.circleShaderFlg = flg;

    /// Determine the type of knob
    mainCircleDataModel.circleData.circleShader =
        mainCircleDataModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.round
            : CircleShader.circleNone;
  }

  circleCombinedMethod(BuildContext context, bool flg) {
    mainCircleDataModel.circleColorFlg = flg;
    mainCircleDataModel.circleCombineFlg = flg;
    mainCircleDataModel.circleShaderFlg = flg;
    mainCircleDataModel.circleData.circleStrokeWidth =
        mainCircleDataModel.circleData.circleSizeValue / 3;
    mainCircleDataModel.circleData.circleTextMarginList = [const Size(15, 15)];

    mainCircleDataModel.circleData.circleCombinedTextSize = 12;

    /// Determine the type of knob
    mainCircleDataModel.circleData.circleShader = CircleShader.butt;

    /// Determine the knob color
    mainCircleDataModel.circleData.circleColor = Colors.green.withOpacity(0);

    /// Determine the knob shadow color
    mainCircleDataModel.circleData.circleShadowColor =
        Colors.black.withOpacity(0);

    if (flg) {
      mainCircleDataModel.circleData.startValue = [];
      mainCircleDataModel.circleData.endValue = [];
      mainCircleDataModel.circleData.startValue = [];
      mainCircleDataModel.circleData.circleCombinedColorList = [];
      _resetCircle(context);
    } else {
      _randomCircleList(Random().nextInt(7));
    }

    /// Determine the type of knob
    mainCircleDataModel.circleData.circleShader =
        mainCircleDataModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.round
            : CircleShader.circleNone;
  }

  _resetCircle(BuildContext context) {
    /// Determine the type of knob
    mainCircleDataModel.circleData.circleShader = CircleShader.butt;

    /// Determine the knob color
    mainCircleDataModel.circleData.circleColor = Colors.green;

    /// Determine the knob shadow color
    mainCircleDataModel.circleData.circleShadowColor = Colors.black;

    mainCircleDataModel.paddingValue = 30;
    mainCircleDataModel.circleData.circleStrokeWidth = 30;
    mainCircleDataModel.circleData.circlePointerValue =
        mainCircleDataModel.circleData.circleStrokeWidth / 2;
    mainCircleDataModel.circleData.circleSizeValue = 0;
    mainCircleDataModel.circleData.circleSizeValue =
        MediaQuery.of(context).size.width / 2;
  }

  _randomCircleList(int index) {
    /// Pie chart animation direction.
    switch (index) {
      case 0:
        mainCircleDataModel.circleData.startValue = [0, 0.25, 0.45, 0.5, 0.7];
        mainCircleDataModel.circleData.endValue = [0.25, 0.2, 0.05, 0.2, 0.3];
        break;
      case 1:
        mainCircleDataModel.circleData.startValue = [
          0,
          0.25,
          0.35,
          0.78,
          0.841
        ];
        mainCircleDataModel.circleData.endValue = [
          0.25,
          0.1,
          0.43,
          0.061,
          0.159
        ];
        break;
      case 2:
        mainCircleDataModel.circleData.startValue = [0, 0.15, 0.57, 0.7, 0.83];
        mainCircleDataModel.circleData.endValue = [
          0.15,
          0.42,
          0.13,
          0.13,
          0.17
        ];
        break;
      case 3:
        mainCircleDataModel.circleData.startValue = [0, 0.25, 0.53, 0.73, 0.83];
        mainCircleDataModel.circleData.endValue = [0.25, 0.3, 0.22, 0.1, 0.17];
        break;
      case 4:
        mainCircleDataModel.circleData.startValue = [0, 0.25, 0.35, 0.45, 0.84];
        mainCircleDataModel.circleData.endValue = [0.25, 0.1, 0.1, 0.39, 0.16];
        break;
      case 5:
        mainCircleDataModel.circleData.startValue = [0, 0.15, 0.55, 0.65, 0.85];
        mainCircleDataModel.circleData.endValue = [0.15, 0.4, 0.1, 0.2, 0.15];
        break;
      case 6:
        mainCircleDataModel.circleData.startValue = [0, 0.5, 0.7, 0.9, 0.95];
        mainCircleDataModel.circleData.endValue = [0.5, 0.2, 0.2, 0.05, 0.05];
        break;
    }

    /// unwrap compatible
    mainCircleDataModel.circleData.circleTextMarginList =
        mainCircleDataModel.circleData.circleTextMarginList ??
            [const Size(15, 15)];
    for (var i = 0;
        i <= (mainCircleDataModel.circleData.startValue?.length ?? 0);
        i++) {
      mainCircleDataModel.circleData.circleTextMarginList!
          .insert(i, const Size(15, 15));
    }

    mainCircleDataModel.circleData.circleTextList = [
      "${mainCircleDataModel.circleData.startValue?[0] ?? ""}${"%"}\n${mainCircleDataModel.circleData.endValue?[0] ?? ""}${"%"}\nExample",
      "${mainCircleDataModel.circleData.startValue?[1] ?? ""}${"%"}\n${mainCircleDataModel.circleData.endValue?[1] ?? ""}${"%"}\nExample",
      "${mainCircleDataModel.circleData.startValue?[2] ?? ""}${"%"}\n${mainCircleDataModel.circleData.endValue?[2] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
      "${mainCircleDataModel.circleData.startValue?[3] ?? ""}${"%"}\n${mainCircleDataModel.circleData.endValue?[3] ?? ""}${"%"}\nExample",
      "${mainCircleDataModel.circleData.startValue?[4] ?? ""}${"%"}\n${mainCircleDataModel.circleData.endValue?[4] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
    ];

    mainCircleDataModel.circleData.circleCombinedColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white
    ];

    /// Select your favorite element
    mainCircleDataModel.circleData.circleCombinedColorList = [
      Colors.blue,
      Colors.black,
      Colors.green,
      Colors.grey,
      Colors.orange
    ];
  }
}
