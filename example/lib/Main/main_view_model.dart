import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';

import 'main_circle_data_model.dart';

typedef DesignTypeCallBack = Function(DesignType type,
    {double? max, double? value, RangeValues? values, bool? flg});

abstract class CallBackLogic {
  DesignTypeCallBack? callback(type,
      {double? max, double? value, RangeValues? values, bool? flg});
}

enum DesignType {
  wSliderState,
  combineState,
  knobState,
  knobRoundState,
  circleDesignState
}

class MainViewModel {
  late final MainCircleDataModel viewModel = MainCircleDataModel();

  wSliderState(RangeValues? values) {
    RangeValues valuesSet = values ?? const RangeValues(0, 0);
    if (viewModel.rValue != valuesSet.start) {
      viewModel.rValue = valuesSet.start;
    } else if (viewModel.fValue != values?.end) {
      viewModel.fValue = valuesSet.end;
    }
  }

  combineState(double deviceWidth, double? max, double? value) {
    if (max == deviceWidth) {
      viewModel.circleData.circleSizeValue = (value ?? 0);
      if (!viewModel.circleCombineFlg) {
        viewModel.circleData.circleStrokeWidth = (value ?? 0) / 3;
      }
    } else if (max == 20000) {
      viewModel.speedValue = value ?? 0;
      viewModel.circleData.circleDuration = viewModel.speedValue.toInt();
    }
  }

  scrollAnimation() {
    viewModel.scrollController.animateTo(
      viewModel.scrollController.offset == 0
          ? viewModel.scrollController.position.maxScrollExtent
          : 0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  circleSet(double deviceWidth) {
    /// Determine the size of the circle.
    viewModel.circleSize =
        viewModel.circleSize == 0.0 ? deviceWidth / 2 : viewModel.circleSize;
    viewModel.circleSetProgress = MultipleCircleSetProgress(
        circleKey: viewModel.circleKey, circle: viewModel.circleData);
  }

  switchSetRow(DesignTypeCallBack call) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        switchSet(call, viewModel.circleColorKey),
        switchSet(call, viewModel.circleShaderFlgKey),
        switchSet(call, viewModel.circleCombinedKey),
      ],
    );
  }

  Column sliderSets(DesignTypeCallBack call, double deviceWidth) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: viewModel.topBottom)),
        wSlider(call, RangeValues(viewModel.rValue, viewModel.fValue),
            viewModel.setColorModel.setColor.length.toDouble(),
            keyValue: viewModel.globalKey),
        sliderSet(call, viewModel.speedValue, 20000.0),
        sliderSet(call, viewModel.circleData.circleSizeValue, deviceWidth),
        Padding(padding: EdgeInsets.only(top: viewModel.pad))
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
                setButton(true, viewModel.fValue,
                    viewModel.circleData.circleLabelValue ?? 0),
                setButton(
                    false,
                    viewModel.circleData.circleCounterValue ?? 0,
                    viewModel.circleData.circleCounterValue == 0
                        ? 0
                        : viewModel.rValue),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: viewModel.pad)),
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
            viewModel.circleLabelValue.toStringAsFixed(1),
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: viewModel.pad)),
        SizedBox(
          width: viewModel.circleData.circleSizeValue,
          height: viewModel.circleData.circleSizeValue,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(360 / 360),
            child: viewModel.circleSetProgress,
            key: viewModel.circleKey,
          ),
        ),
      ],
    );
  }

  RangeSlider wSlider(DesignTypeCallBack call, RangeValues values, max,
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
        call(DesignType.wSliderState, values: values);
      },
    );
  }

  Slider sliderSet(DesignTypeCallBack call, double value, max,
      {Key? keyValue}) {
    Padding(padding: EdgeInsets.only(top: viewModel.pad));
    return Slider(
      key: keyValue,
      value: value,
      min: 0,
      max: max,
      label: value.toString(),
      divisions: 1000,
      onChanged: (double value) {
        call(DesignType.combineState, max: max, value: value);
      },
    );
  }

  OutlinedButton setButton(
      bool forwardFlg, double counterValue, double circleLabelValue) {
    Padding(padding: EdgeInsets.only(top: viewModel.pad));
    return OutlinedButton(
      onPressed: () {
        viewModel.circleData.circleForwardFlg = forwardFlg;
        viewModel.circleData.circleCounterValue = counterValue;
        viewModel.circleData.circleLabelSpeedValue = circleLabelValue;
        viewModel.circleData.circleLabelValue = circleLabelValue;
        viewModel.controller.setProgress([
          viewModel.circleData.circleCounterValue ?? 0,
          viewModel.circleData.circleLabelValue ?? 0
        ]);
      },
      child: const Icon(Icons.play_circle),
    );
  }

  CupertinoSwitch switchSet(DesignTypeCallBack call, Key keyValue) {
    Padding(
        padding: EdgeInsets.only(left: viewModel.pad, right: viewModel.pad));
    if (keyValue == viewModel.circleColorKey) {
      return CupertinoSwitch(
        key: viewModel.circleColorKey,
        value: viewModel.circleColorFlg,
        onChanged: (flg) {
          if (viewModel.circleCombineFlg) {
            call(DesignType.knobState, flg: flg);
          }
        },
      );
    } else if (keyValue == viewModel.circleShaderFlgKey) {
      return CupertinoSwitch(
        key: viewModel.circleShaderFlgKey,
        value: viewModel.circleShaderFlg,
        onChanged: (flg) {
          if (viewModel.circleCombineFlg) {
            call(DesignType.knobRoundState, flg: flg);
          }
        },
      );
    } else {
      return CupertinoSwitch(
        key: viewModel.circleCombinedKey,
        value: viewModel.circleCombineFlg,
        onChanged: (flg) {
          call(DesignType.circleDesignState, flg: flg);
        },
      );
    }
  }

  /// Switch Button Logic
  circleDesignState(double deviceWidth, bool flg) {
    viewModel.circleColorFlg = flg;
    viewModel.circleCombineFlg = flg;
    viewModel.circleShaderFlg = flg;
    circleSet(deviceWidth);
    viewModel.circleData.circleTapValue = 1.0;
    viewModel.circleData.circleStrokeWidth =
        viewModel.circleData.circleSizeValue / 3;
    viewModel.circleData.circleTextMarginList = [const Size(15, 15)];

    viewModel.circleData.circleCombinedTextSize = 12;

    /// Determine the type of knob
    viewModel.circleData.circleShader = CircleShader.butt;

    /// Determine the knob color
    viewModel.circleData.circleColor = Colors.green.withOpacity(0);

    /// Determine the knob shadow color
    viewModel.circleData.circleShadowColor = Colors.black.withOpacity(0);

    if (flg) {
      viewModel.circleData.startValue = [];
      viewModel.circleData.endValue = [];
      viewModel.circleData.startValue = [];
      viewModel.circleData.circleCombinedColorList = [];
      _resetCircle(deviceWidth);
    } else {
      _randomCircleList(Random().nextInt(7));
    }

    /// Determine the type of knob
    viewModel.circleData.circleShader =
        viewModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.round
            : CircleShader.circleNone;
  }

  /// Switch Button Logic
  knobState(double deviceWidth, bool? flg) {
    circleSet(deviceWidth);
    viewModel.circleColorFlg = flg ?? false;

    /// Determine the type of knob
    viewModel.circleData.circleShader =
        viewModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.butt
            : CircleShader.circleNone;

    /// Determine the knob color
    viewModel.circleData.circleColor =
        viewModel.circleData.circleColor == Colors.green
            ? Colors.green.withOpacity(0)
            : Colors.green;

    /// Determine the knob shadow color
    viewModel.circleData.circleShadowColor =
        viewModel.circleData.circleShadowColor == Colors.black
            ? Colors.black.withOpacity(0)
            : Colors.black;
  }

  /// Switch Button Logic
  knobRoundState(double deviceWidth, bool? flg) {
    circleSet(deviceWidth);

    /// Pie chart animation direction.
    viewModel.circleShaderFlg = flg ?? false;

    /// Determine the type of knob
    viewModel.circleData.circleShader =
        viewModel.circleData.circleShader == CircleShader.circleNone
            ? CircleShader.round
            : CircleShader.circleNone;
  }

  _resetCircle(double deviceWidth) {
    /// Determine the type of knob
    viewModel.circleData.circleShader = CircleShader.butt;

    /// Determine the knob color
    viewModel.circleData.circleColor = Colors.green;

    /// Determine the knob shadow color
    viewModel.circleData.circleShadowColor = Colors.black;

    viewModel.pad = 30;
    viewModel.circleData.circleStrokeWidth = 30;
    viewModel.circleData.circlePointerValue =
        viewModel.circleData.circleStrokeWidth / 2;
    viewModel.circleData.circleSizeValue = 0;
    viewModel.circleData.circleSizeValue = deviceWidth / 2;
  }

  _randomCircleList(int index) {
    /// Pie chart animation direction.
    switch (index) {
      case 0:
        viewModel.circleData.startValue = [0, 0.25, 0.45, 0.5, 0.7];
        viewModel.circleData.endValue = [0.25, 0.2, 0.05, 0.2, 0.3];
        break;
      case 1:
        viewModel.circleData.startValue = [0, 0.25, 0.35, 0.78, 0.841];
        viewModel.circleData.endValue = [0.25, 0.1, 0.43, 0.061, 0.159];
        break;
      case 2:
        viewModel.circleData.startValue = [0, 0.15, 0.57, 0.7, 0.83];
        viewModel.circleData.endValue = [0.15, 0.42, 0.13, 0.13, 0.17];
        break;
      case 3:
        viewModel.circleData.startValue = [0, 0.25, 0.55, 0.77, 0.87];
        viewModel.circleData.endValue = [0.25, 0.3, 0.22, 0.1, 0.13];
        break;
      case 4:
        viewModel.circleData.startValue = [0, 0.25, 0.35, 0.45, 0.84];
        viewModel.circleData.endValue = [0.25, 0.1, 0.1, 0.39, 0.16];
        break;
      case 5:
        viewModel.circleData.startValue = [0, 0.15, 0.55, 0.65, 0.85];
        viewModel.circleData.endValue = [0.15, 0.4, 0.1, 0.2, 0.15];
        break;
      case 6:
        viewModel.circleData.startValue = [0, 0.5, 0.7, 0.9, 0.95];
        viewModel.circleData.endValue = [0.5, 0.2, 0.2, 0.05, 0.05];
        break;
    }

    /// unwrap compatible
    viewModel.circleData.circleTextMarginList =
        viewModel.circleData.circleTextMarginList ?? [const Size(15, 15)];
    for (var i = 0; i <= (viewModel.circleData.startValue?.length ?? 0); i++) {
      viewModel.circleData.circleTextMarginList!.insert(i, const Size(15, 15));
    }

    viewModel.circleData.circleTextList = [
      "${viewModel.circleData.startValue?[0] ?? ""}${"%"}\n${viewModel.circleData.endValue?[0] ?? ""}${"%"}\nExample",
      "${viewModel.circleData.startValue?[1] ?? ""}${"%"}\n${viewModel.circleData.endValue?[1] ?? ""}${"%"}\nExample",
      "${viewModel.circleData.startValue?[2] ?? ""}${"%"}\n${viewModel.circleData.endValue?[2] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
      "${viewModel.circleData.startValue?[3] ?? ""}${"%"}\n${viewModel.circleData.endValue?[3] ?? ""}${"%"}\nExample",
      "${viewModel.circleData.startValue?[4] ?? ""}${"%"}\n${viewModel.circleData.endValue?[4] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
    ];

    viewModel.circleData.circleCombinedColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white
    ];

    /// Select your favorite element
    viewModel.circleData.circleCombinedColorList = [
      Colors.blue,
      Colors.black,
      Colors.green,
      Colors.grey,
      Colors.orange
    ];
  }
}
