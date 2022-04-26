import 'dart:async';
import 'dart:math';

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
  int grapthCount = 0;

  CustomPaint setPaint4(double width) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 5,
    );
    return CustomPaint(
      painter: OverlappingGridPainter(
          textStyle, 40, 1, -25, 20, Size(width, 400), Colors.orange, radData),
      child: CustomPaint(
        painter: indicator4?.setPainter("", -1, 0, model.colorList,
            circleData: CircleData.allCircle, textColor: Colors.grey),
        child: CustomPaint(
          painter: indicator4?.setPainter("0", 0, 3, model.colorList,
              circleData: CircleData.allCircle),
          child: CustomPaint(
            painter: indicator4?.setPainter("1", 1, 3, model.colorList),
            child: CustomPaint(
              painter: indicator4?.setPainter("2", 2, 3, model.colorList),
              child: CustomPaint(
                painter: indicator4?.setPainter("3", 3, 3, model.colorList),
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomPaint setPaint3(double width) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 5,
    );
    return CustomPaint(
      painter: OverlappingGridPainter(
          textStyle, 40, 1, -25, 20, Size(width, 400), Colors.orange, radData),
      child: CustomPaint(
        painter: indicator3?.setPainter("", -1, 0, model.colorList,
            circleData: CircleData.allCircle, textColor: Colors.grey),
        child: CustomPaint(
          painter: indicator3?.setPainter("0", 0, 3, model.colorList,
              circleData: CircleData.allCircle),
          child: CustomPaint(
            painter: indicator3?.setPainter("1", 1, 3, model.colorList),
            child: CustomPaint(
              painter: indicator3?.setPainter("2", 2, 3, model.colorList),
            ),
          ),
        ),
      ),
    );
  }

  CustomPaint setPaint2(double width) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 5,
    );
    return CustomPaint(
      painter: OverlappingGridPainter(
          textStyle, 40, 1, -25, 20, Size(width, 400), Colors.orange, radData),
      child: CustomPaint(
        painter: indicator2?.setPainter("", -1, 0, model.colorList,
            circleData: CircleData.allCircle, textColor: Colors.grey),
        child: CustomPaint(
          painter: indicator2?.setPainter("0", 0, 3, model.colorList,
              circleData: CircleData.allCircle),
          child: CustomPaint(
            painter: indicator2?.setPainter("1", 1, 3, model.colorList),
            child: CustomPaint(
              painter: indicator2?.setPainter("2", 2, 3, model.colorList),
            ),
          ),
        ),
      ),
    );
  }

  CustomPaint setPaint(double width) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 5,
    );
    return CustomPaint(
      painter: OverlappingGridPainter(
          textStyle, 40, 1, -25, 20, Size(width, 400), Colors.orange, radData),
      child: CustomPaint(
        painter: OverlappingGraphText(textStyle, 40, 1, -25, 20,
            Size(width, 400), grapthCount, Colors.orange, radData),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<int> cou = [];
  Row indicatorRowSet(
      OverlappingProgressIndicator? indicator, double width, int index) {
    cou.add(index);
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(top: 80, left: 30)),
        SizedBox(height: 15, width: width, child: indicator),
      ],
    );
  }

  OverlappingProgressIndicator indicatorSet(BuildContext context, GlobalKey key,
      double w, CustomPaint setPaint, double index) {
    return OverlappingProgressIndicator(
        radData: radData,
        radDataRadDataVertical: const Offset(20, 20),
        radDataRadDataHorizontal: const Offset(1, 20),
        dataVerticalSize: const Size(120, 120),
        dataHorizontalSize: const Size(150, 120),
        globalKey: key,
        contextSize: Size(w, 15),
        con: context,
        // stream: StreamController(),
        setPaint: setPaint,
        animationValue: (animationController?.value ?? 0) / index);
  }

  ElevatedButton buttonSet(OverLapCallBack call) {
    return ElevatedButton(
      onPressed: () {
        // cou  = [];
        call(OverLapType.buttonSet);
      },
      child: const Text('click here'),
    );
  }

  buttonSetState(OverLapCallBack call, OverLappingBarState vsync) {
    radData =
        radData == RadData.vertical ? RadData.horizontal : RadData.vertical;
    animationControllerInit(call, vsync);
  }

  var rng = new Random();
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

  var cc = 0;
  var cc2 = 0;
  animationInitState(BuildContext context, double width) {
    indicator2 =
        indicatorSet(context, globalKey2, width, setPaint2(width), 1.8);
    indicator3 =
        indicatorSet(context, globalKey3, width, setPaint3(width), 1.1);
    indicator4 = indicatorSet(context, globalKey4, width, setPaint4(width), 1);
    indicator = indicatorSet(context, globalKey, width, setPaint(width), 1.2);
  }
}