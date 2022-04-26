import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_graph_text.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_grid_painter.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_progress_indicator.dart';

import 'overLapping_model.dart';
import 'overlapping_bar.dart';

typedef OverLapCallBack = Function(OverLapType type);

abstract class OverLapCallBackLogic {
  OverLapCallBack? callback(OverLapType type);
}

enum OverLapType {
  animationControllerInit,
  buttonSet,
}

class OverLappingViewModel {
  OveriLappingModel model = OveriLappingModel();
  late AnimationController? animationController;
  OverlappingProgressIndicator? indicator;
  OverlappingProgressIndicator? indicator2;
  OverlappingProgressIndicator? indicator3;
  OverlappingProgressIndicator? indicator4;
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  GlobalKey globalKey4 = GlobalKey();
  RadData radData = RadData.vertical;
  int graphCount = 0;

  /// details of animation amount.
  CustomPaint setGridPainter(
      OverlappingProgressIndicator? indicator, double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 5,
    );
    return CustomPaint(
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
    );
  }

  ///　details of graph characters, ruled lines, and animation amount.
  CustomPaint setGridTextPainter(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 5,
    );
    return CustomPaint(
      painter: OverlappingGridPainter(textStyle, 40, 1, -25, 20,
          Size(value, value), Colors.orange, 7.5, radData),
      child: CustomPaint(
        painter: OverlappingGraphText(textStyle, 40, 1, -25, 20,
            Size(value, value), graphCount, Colors.orange, radData),
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

  ///　Building a graph.
  OverlappingProgressIndicator indicatorSet(BuildContext context, GlobalKey key,
      double w, CustomPaint setPaint, double index) {
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
        animationValue: (animationController?.value ?? 0) / index);
  }

  ElevatedButton buttonSet(OverLapCallBack call) {
    return ElevatedButton(
      onPressed: () {
        call(OverLapType.buttonSet);
      },
      child: const Text('click here'),
    );
  }

  /// button action　judgment of orientation.
  buttonSetState(OverLapCallBack call, OverLappingBarState vsync) {
    radData =
        radData == RadData.vertical ? RadData.horizontal : RadData.vertical;
    animationControllerInit(call, vsync);
  }

  /// animation a graph.
  animationControllerInit(OverLapCallBack call, OverLappingBarState vsync) {
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

  ///　build graph animation.
  animationInitState(BuildContext context, double width) {
    indicator2 = indicatorSet(
        context, globalKey2, width, setGridPainter(indicator2, width), 1.8);
    indicator3 = indicatorSet(
        context, globalKey3, width, setGridPainter(indicator3, width), 1.6);
    indicator4 = indicatorSet(
        context, globalKey4, width, setGridPainter(indicator4, width), 1);
    indicator =
        indicatorSet(context, globalKey, width, setGridTextPainter(width), 1.2);
  }
}
