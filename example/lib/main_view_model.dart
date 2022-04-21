import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';

import 'main.dart';
import 'main_circle_data_model.dart';

class MainViewModel {
  late final MainCircleDataModel dataViewModel = MainCircleDataModel();

  wSLiderState(RangeValues values) {
    if (dataViewModel.rValue != values.start) {
      dataViewModel.rValue = values.start;
    } else if (dataViewModel.fValue != values.end) {
      dataViewModel.fValue = values.end;
    }
  }

  combineState(BuildContext context, double max, double value) {
    if (max == MediaQuery.of(context).size.width) {
      dataViewModel.circleData.circleSizeValue = value;
      if (!dataViewModel.circleCombineFlg) {
        dataViewModel.circleData.circleStrokeWidth = value / 3;
      }
    } else if (max == 20000) {
      dataViewModel.speedValue = value;
      dataViewModel.circleData.circleDuration =
          dataViewModel.speedValue.toInt();
    }
  }

  scrollAnimation() {
    dataViewModel.scrollController.animateTo(
      dataViewModel.scrollController.offset == 0
          ? dataViewModel.scrollController.position.maxScrollExtent
          : 0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  circleSet(BuildContext context) {
    /// Determine the size of the circle.
    dataViewModel.circleSize = dataViewModel.circleSize == 0.0
        ? MediaQuery.of(context).size.width / 2
        : dataViewModel.circleSize;
    dataViewModel.circleSetProgress = MultipleCircleSetProgress(
        circleKey: dataViewModel.circleKey, circle: dataViewModel.circleData);
  }

  switchSetRow(MyHomePageState m, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        switchSet(m, context, dataViewModel.circleColorKey),
        switchSet(m, context, dataViewModel.circleShaderFlgKey),
        switchSet(m, context, dataViewModel.circleCombinedKey),
      ],
    );
  }

  Column sliderSets(MyHomePageState m, BuildContext con) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: dataViewModel.padTopBottom)),
        wSlider(m, con, RangeValues(dataViewModel.rValue, dataViewModel.fValue),
            dataViewModel.setColorModel.setColor.length.toDouble(),
            keyValue: dataViewModel.globalKey),
        sliderSet(m, con, dataViewModel.speedValue, 20000.0),
        sliderSet(m, con, dataViewModel.circleData.circleSizeValue,
            MediaQuery.of(con).size.width),
        Padding(padding: EdgeInsets.only(top: dataViewModel.padValue))
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
                setButton(true, dataViewModel.fValue,
                    dataViewModel.circleData.circleLabelValue ?? 0),
                setButton(
                    false,
                    dataViewModel.circleData.circleCounterValue ?? 0,
                    dataViewModel.circleData.circleCounterValue == 0
                        ? 0
                        : dataViewModel.rValue),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: dataViewModel.padValue)),
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
            dataViewModel.circleLabelValue.toStringAsFixed(1),
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: dataViewModel.padValue)),
        SizedBox(
          width: dataViewModel.circleData.circleSizeValue,
          height: dataViewModel.circleData.circleSizeValue,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(360 / 360),
            child: dataViewModel.circleSetProgress,
            key: dataViewModel.circleKey,
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
        values.start.toString(),
        values.end.toString(),
      ),
      onChanged: (RangeValues values) {
        m.wSlider(values);
      },
    );
  }

  Slider sliderSet(MyHomePageState m, BuildContext con, double value, max,
      {Key? keyValue}) {
    Padding(padding: EdgeInsets.only(top: dataViewModel.padValue));
    return Slider(
      key: keyValue,
      value: value,
      min: 0,
      max: max,
      label: value.toString(),
      divisions: 1000,
      onChanged: (double value) {
        m.sliderSet(max, value);
      },
    );
  }

  OutlinedButton setButton(
      bool forwardFlg, double counterValue, double circleLabelValue) {
    Padding(padding: EdgeInsets.only(top: dataViewModel.padValue));
    return OutlinedButton(
      onPressed: () {
        dataViewModel.circleData.circleForwardFlg = forwardFlg;
        dataViewModel.circleData.circleCounterValue = counterValue;
        dataViewModel.circleData.circleLabelSpeedValue = circleLabelValue;
        dataViewModel.circleData.circleLabelValue = circleLabelValue;
        dataViewModel.controller.setProgress([
          dataViewModel.circleData.circleCounterValue ?? 0,
          dataViewModel.circleData.circleLabelValue ?? 0
        ]);
      },
      child: const Icon(Icons.play_circle),
    );
  }

  CupertinoSwitch switchSet(MyHomePageState m, BuildContext con, Key keyValue) {
    Padding(
        padding: EdgeInsets.only(
            left: dataViewModel.padValue, right: dataViewModel.padValue));
    if (keyValue == dataViewModel.circleColorKey) {
      return CupertinoSwitch(
        key: dataViewModel.circleColorKey,
        value: dataViewModel.circleColorFlg,
        onChanged: (flg) {
          m.circlecircleColorState(flg);
        },
      );
    } else if (keyValue == dataViewModel.circleShaderFlgKey) {
      return CupertinoSwitch(
        key: dataViewModel.circleShaderFlgKey,
        value: dataViewModel.circleShaderFlg,
        onChanged: (flg) {
          m.circleShaderFlgState(flg);
        },
      );
    } else {
      return CupertinoSwitch(
        key: dataViewModel.circleCombinedKey,
        value: dataViewModel.circleCombineFlg,
        onChanged: (flg) {
          m.combinedState(flg);
        },
      );
    }
  }

  circleCombinedMethod(BuildContext context, bool flg) {
    dataViewModel.circleColorFlg = flg;
    dataViewModel.circleCombineFlg = flg;
    dataViewModel.circleShaderFlg = flg;
    circleSet(context);
    dataViewModel.circleData.circleTapValue = 1.0;
    dataViewModel.circleData.circleStrokeWidth =
        dataViewModel.circleData.circleSizeValue / 3;
    dataViewModel.circleData.circleTextMarginList = [const Size(15, 15)];

    dataViewModel.circleData.circleCombinedTextSize = 12;

    /// Determine the type of knob
    dataViewModel.circleData.circleShader = CircleShader.butt;

    /// Determine the knob color
    dataViewModel.circleData.circleColor = Colors.green.withOpacity(0);

    /// Determine the knob shadow color
    dataViewModel.circleData.circleShadowColor = Colors.black.withOpacity(0);

    if (flg) {
      dataViewModel.circleData.startValue = [];
      dataViewModel.circleData.endValue = [];
      dataViewModel.circleData.startValue = [];
      dataViewModel.circleData.circleCombinedColorList = [];
      _resetCircle(context);
    } else {
      _randomCircleList(Random().nextInt(7));
    }

    /// Determine the type of knob
    dataViewModel.circleData.circleShader =
        dataViewModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.round
            : CircleShader.circleNone;
  }

  circleColorMethod(BuildContext context, bool flg) {
    circleSet(context);
    dataViewModel.circleColorFlg = flg;

    /// Determine the type of knob
    dataViewModel.circleData.circleShader =
        dataViewModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.butt
            : CircleShader.circleNone;

    /// Determine the knob color
    dataViewModel.circleData.circleColor =
        dataViewModel.circleData.circleColor == Colors.green
            ? Colors.green.withOpacity(0)
            : Colors.green;

    /// Determine the knob shadow color
    dataViewModel.circleData.circleShadowColor =
        dataViewModel.circleData.circleShadowColor == Colors.black
            ? Colors.black.withOpacity(0)
            : Colors.black;
  }

  circleShaderFlgMethod(BuildContext context, bool flg) {
    circleSet(context);

    /// Pie chart animation direction.
    dataViewModel.circleShaderFlg = flg;

    /// Determine the type of knob
    dataViewModel.circleData.circleShader =
        dataViewModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.round
            : CircleShader.circleNone;
  }

  _resetCircle(BuildContext context) {
    /// Determine the type of knob
    dataViewModel.circleData.circleShader = CircleShader.butt;

    /// Determine the knob color
    dataViewModel.circleData.circleColor = Colors.green;

    /// Determine the knob shadow color
    dataViewModel.circleData.circleShadowColor = Colors.black;

    dataViewModel.padValue = 30;
    dataViewModel.circleData.circleStrokeWidth = 30;
    dataViewModel.circleData.circlePointerValue =
        dataViewModel.circleData.circleStrokeWidth / 2;
    dataViewModel.circleData.circleSizeValue = 0;
    dataViewModel.circleData.circleSizeValue =
        MediaQuery.of(context).size.width / 2;
  }

  _randomCircleList(int index) {
    /// Pie chart animation direction.
    switch (index) {
      case 0:
        dataViewModel.circleData.startValue = [0, 0.25, 0.45, 0.5, 0.7];
        dataViewModel.circleData.endValue = [0.25, 0.2, 0.05, 0.2, 0.3];
        break;
      case 1:
        dataViewModel.circleData.startValue = [0, 0.25, 0.35, 0.78, 0.841];
        dataViewModel.circleData.endValue = [0.25, 0.1, 0.43, 0.061, 0.159];
        break;
      case 2:
        dataViewModel.circleData.startValue = [0, 0.15, 0.57, 0.7, 0.83];
        dataViewModel.circleData.endValue = [0.15, 0.42, 0.13, 0.13, 0.17];
        break;
      case 3:
        dataViewModel.circleData.startValue = [0, 0.25, 0.55, 0.77, 0.87];
        dataViewModel.circleData.endValue = [0.25, 0.3, 0.22, 0.1, 0.13];
        break;
      case 4:
        dataViewModel.circleData.startValue = [0, 0.25, 0.35, 0.45, 0.84];
        dataViewModel.circleData.endValue = [0.25, 0.1, 0.1, 0.39, 0.16];
        break;
      case 5:
        dataViewModel.circleData.startValue = [0, 0.15, 0.55, 0.65, 0.85];
        dataViewModel.circleData.endValue = [0.15, 0.4, 0.1, 0.2, 0.15];
        break;
      case 6:
        dataViewModel.circleData.startValue = [0, 0.5, 0.7, 0.9, 0.95];
        dataViewModel.circleData.endValue = [0.5, 0.2, 0.2, 0.05, 0.05];
        break;
    }

    /// unwrap compatible
    dataViewModel.circleData.circleTextMarginList =
        dataViewModel.circleData.circleTextMarginList ?? [const Size(15, 15)];
    for (var i = 0;
        i <= (dataViewModel.circleData.startValue?.length ?? 0);
        i++) {
      dataViewModel.circleData.circleTextMarginList!
          .insert(i, const Size(15, 15));
    }

    dataViewModel.circleData.circleTextList = [
      "${dataViewModel.circleData.startValue?[0] ?? ""}${"%"}\n${dataViewModel.circleData.endValue?[0] ?? ""}${"%"}\nExample",
      "${dataViewModel.circleData.startValue?[1] ?? ""}${"%"}\n${dataViewModel.circleData.endValue?[1] ?? ""}${"%"}\nExample",
      "${dataViewModel.circleData.startValue?[2] ?? ""}${"%"}\n${dataViewModel.circleData.endValue?[2] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
      "${dataViewModel.circleData.startValue?[3] ?? ""}${"%"}\n${dataViewModel.circleData.endValue?[3] ?? ""}${"%"}\nExample",
      "${dataViewModel.circleData.startValue?[4] ?? ""}${"%"}\n${dataViewModel.circleData.endValue?[4] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
    ];

    dataViewModel.circleData.circleCombinedColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white
    ];

    /// Select your favorite element
    dataViewModel.circleData.circleCombinedColorList = [
      Colors.blue,
      Colors.black,
      Colors.green,
      Colors.grey,
      Colors.orange
    ];
  }
}
