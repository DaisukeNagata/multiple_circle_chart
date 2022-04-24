import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_progress_indicator.dart';

import 'overLapping_model.dart';
import 'overlapping_bar.dart';

typedef OverLapCallBack = Function(OverLapType type,
    {RadData? radData, double? width});

abstract class OverLapCallBackLogic {
  OverLapCallBack? callback(OverLapType type,
      {RadData? radData, double? width});
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
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  RadData radData = RadData.vertical;

  CustomPaint setPaint() {
    return CustomPaint(
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
    );
  }

  CustomPaint setPaint2() {
    return CustomPaint(
      painter: indicator2?.setPainter("", -1, 0, model.colorList2,
          circleData: CircleData.allCircle, textColor: Colors.grey),
      child: CustomPaint(
        painter: indicator2?.setPainter("0", 0, 2.5, model.colorList2,
            circleData: CircleData.allCircle),
        child: CustomPaint(
          painter: indicator2?.setPainter("1", 1, 2.5, model.colorList2),
          child: CustomPaint(
            painter: indicator2?.setPainter("2", 2, 2.5, model.colorList2),
            child: CustomPaint(
              painter: indicator2?.setPainter("3", 3, 2.5, model.colorList2),
            ),
          ),
        ),
      ),
    );
  }

  Row indicatorRowSet(OverlappingProgressIndicator? indicator, double width) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(top: 100, left: 30)),
        SizedBox(height: 15, width: width, child: indicator),
      ],
    );
  }

  OverlappingProgressIndicator indicatorSet(
      BuildContext context, GlobalKey key, double w, CustomPaint setPaint) {
    return OverlappingProgressIndicator(
        radData: radData,
        radDataRadDataVertical: const Offset(20, 20),
        radDataRadDataHorizontal: const Offset(1, 20),
        dataVerticalSize: const Size(120, 120),
        dataHorizontalSize: const Size(150, 120),
        globalKey: key,
        contextSize: Size(w, 15),
        con: context,
        stream: StreamController(),
        setPaint: setPaint,
        animationValue: animationController?.value);
  }

  ElevatedButton buttonSet(OverLapCallBack call) {
    return ElevatedButton(
      onPressed: () {
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

  animationControllerInit(OverLapCallBack call, OverLappingBarState vsync) {
    var rand = Random();
    rand.nextInt(1);
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

  animationInitState(BuildContext context, double width) {
    indicator = indicatorSet(context, globalKey, width, setPaint());
    indicator2 = indicatorSet(context, globalKey2, width, setPaint2());
  }
}
