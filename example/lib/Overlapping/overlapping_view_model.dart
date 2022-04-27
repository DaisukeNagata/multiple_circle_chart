import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_graph_text.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_grid_painter.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_progress_indicator.dart';

import 'overlapping_bar.dart';
import 'overlapping_model.dart';

typedef OverLapCallBack = Function(OverLapType type);

abstract class OverLapCallBackLogic {
  OverLapCallBack? callback(OverLapType type);
}

enum OverLapType {
  animationControllerInit,
}

class OverLappingViewModel {
  OverLappingModel model = OverLappingModel();
  late AnimationController? animationController;
  OverlappingProgressIndicator? lastIndicator;
  OverlappingProgressIndicator? indicator;
  OverlappingProgressIndicator? indicator2;
  OverlappingProgressIndicator? indicator3;
  GlobalKey lastGlobalKey = GlobalKey();
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  RadData radData = RadData.vertical;
  int graphCount = 0;

  ElevatedButton buttonSet(OverLapCallBack call, OverLappingBarState vsync) {
    return ElevatedButton(
      onPressed: () {
        _buttonSetState(call, vsync);
      },
      child: const Text('click here'),
    );
  }

  ///　Graph coordinate construction.
  Row indicatorRowSet(
      OverlappingProgressIndicator? indicator, double width, GlobalKey key) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(top: 80, left: 30)),
        SizedBox(height: 15, width: width, child: indicator, key: key),
      ],
    );
  }

  ///　build graph animation.
  animationInitState(BuildContext context, double width) {
    indicator = _indicatorSet(context, globalKey, width,
        _setGridTextPainter(indicator, width, false), 0.8);
    indicator2 = _indicatorSet(context, globalKey2, width,
        _setGridTextPainter(indicator2, width, false), 0.6);
    indicator3 = _indicatorSet(context, globalKey3, width,
        _setGridTextPainter(indicator3, width, false), 1);
    lastIndicator = _indicatorSet(context, lastGlobalKey, width,
        _setGridTextPainter(lastIndicator, width, true), 0.5);
  }

  ///　details of graph characters, ruled lines, and animation amount.
  CustomPaint _setGridTextPainter(
      OverlappingProgressIndicator? indicator, double value, bool flg) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 5,
    );
    return CustomPaint(
      painter: flg
          ? OverlappingGraphText(textStyle, 40, 1, -25, 20, Size(value, value),
              graphCount, 7.5, Colors.orange, radData)
          : null,
      child: CustomPaint(
        painter: OverlappingGridPainter(textStyle, 40, 1, -25, 20,
            Size(value, value), Colors.orange, 7.5, radData),
        child: CustomPaint(
          painter: indicator?.setPainter("", -1, 0, model.colorList,
              circleData: CircleData.allCircle, textColor: Colors.grey),
          child: CustomPaint(
            painter: indicator?.setPainter("0", 0, 3, model.colorList,
                circleData: CircleData.allCircle),
            child: CustomPaint(
              painter: indicator?.setPainter("1", 1, 3, model.colorList),
              child: CustomPaint(
                painter: indicator?.setPainter("2", 2, 3, model.colorList),
                child: CustomPaint(
                  painter: indicator?.setPainter("3", 3, 3, model.colorList),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// button action　judgment of orientation.
  _buttonSetState(OverLapCallBack call, OverLappingBarState vsync) {
    radData =
        radData == RadData.vertical ? RadData.horizontal : RadData.vertical;
    animationController = AnimationController(
      vsync: vsync,
      upperBound: 1,
    )..addListener(() {
        call(OverLapType.animationControllerInit);
      });
    animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future(() {
          animationController?.reset();
          animationController?.stop();
        });
      }
    });
    animationController?.duration = const Duration(milliseconds: 1500);
    animationController?.forward();
  }

  ///　Building a graph.
  OverlappingProgressIndicator _indicatorSet(BuildContext context,
      GlobalKey key, double w, CustomPaint setPaint, double index) {
    return OverlappingProgressIndicator(
        radData: radData,
        radDataRadDataVertical: const Offset(20, 20),
        radDataRadDataHorizontal: const Offset(1, 20),
        dataVerticalSize: const Size(120, 120),
        dataHorizontalSize: const Size(120, 120),
        globalKey: key,
        contextSize: Size(w, 15),
        con: context,
        streamController: StreamController(),
        setPaint: setPaint,
        animationValue: (animationController?.value ?? 0) * index);
  }
}
