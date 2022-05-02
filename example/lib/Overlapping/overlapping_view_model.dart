import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_graph_text.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_grid_painter.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_progress_indicator.dart';

import 'overlapping_bar.dart';
import 'overlapping_model.dart';

typedef OverLapCallBack = Function(OverLapType,
    {OverLappingBarState? vsync, double? value});

abstract class OverLapCallBackLogic {
  OverLapCallBack? callback(type, {OverLappingBarState? vsync, double? value});
}

enum OverLapType { slider, graph }

class OverLappingViewModel {
  OverLappingModel model = OverLappingModel();
  late AnimationController? animationController;
  OverlappingProgressIndicator? lastIndicator;
  OverlappingProgressIndicator? indicator;
  OverlappingProgressIndicator? indicator2;
  OverlappingProgressIndicator? indicator3;
  OverlappingProgressIndicator? indicator4;
  OverlappingProgressIndicator? indicator5;
  OverlappingProgressIndicator? indicator6;

  OverlappingProgressIndicator? indicator7;
  OverlappingProgressIndicator? indicator8;
  OverlappingProgressIndicator? indicator9;
  GlobalKey lastGlobalKey = GlobalKey();
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  GlobalKey globalKey4 = GlobalKey();
  GlobalKey globalKey5 = GlobalKey();
  GlobalKey globalKey6 = GlobalKey();

  GlobalKey globalKey7 = GlobalKey();
  GlobalKey globalKey8 = GlobalKey();
  GlobalKey globalKey9 = GlobalKey();
  RadData radData = RadData.vertical;
  int graphCount = 0;
  double boxSize = 0;
  double scale = 1;
  Scaffold fold = const Scaffold();
  final double margin10 = 10;
  final double margin15 = 15;
  final double margin30 = 30;
  final int graph = 10;
  final double _sizeHeight = 10;

  ElevatedButton buttonSet(OverLapCallBack call, OverLappingBarState vsync) {
    return ElevatedButton(
      onPressed: () {
        _buttonSetState(call, vsync);
      },
      child: const Text('click here'),
    );
  }

  Slider sliderSet(OverLapCallBack call, OverLappingBarState vsync,
      {Key? keyValue}) {
    return Slider(
      key: keyValue,
      value: scale,
      min: 0,
      max: 2,
      label: scale.toString(),
      divisions: 1000,
      onChanged: (double value) {
        call(OverLapType.slider, value: value);
      },
      onChangeEnd: (_) {
        call(OverLapType.graph, vsync: vsync);
      },
    );
  }

  ///　Graph coordinate construction.
  Row indicatorRowSet(
      OverlappingProgressIndicator? indicator, double width, GlobalKey key) {
    return Row(
      children: [
        SizedBox(height: _sizeHeight, width: width, child: indicator, key: key),
        Padding(padding: EdgeInsets.only(top: boxSize * scale)),
      ],
    );
  }

  ///　build graph animation.
  animationInitState(BuildContext c, double width) {
    boxSize = ((width - margin10) / 10).floorToDouble();
    indicator = _indicatorSet(
        c, globalKey, width, _sePainter(indicator, width, false, true), 0.7);
    indicator2 = _indicatorSet(
        c, globalKey2, width, _sePainter(indicator2, width, false, false), 0.8);
    indicator3 = _indicatorSet(
        c, globalKey3, width, _sePainter(indicator3, width, false, false), 1);
    indicator4 = _indicatorSet(
        c, globalKey4, width, _sePainter(indicator4, width, false, false), 0.4);

    indicator5 = _indicatorSet(
        c, globalKey5, width, _sePainter(indicator5, width, false, false), 0.7);
    indicator6 = _indicatorSet(
        c, globalKey6, width, _sePainter(indicator6, width, false, false), 0.8);

    indicator7 = _indicatorSet(
        c, globalKey7, width, _sePainter(indicator7, width, false, false), 0.4);

    indicator8 = _indicatorSet(
        c, globalKey8, width, _sePainter(indicator8, width, false, false), 0.7);
    indicator9 = _indicatorSet(
        c, globalKey9, width, _sePainter(indicator9, width, false, false), 0.8);

    lastIndicator = _indicatorSet(c, lastGlobalKey, width,
        _sePainter(lastIndicator, width, true, true), 0.5);
  }

  OverlappingGraphText _graphText(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 10,
    );
    return OverlappingGraphText(
        textStyle: textStyle,
        boxSize: boxSize,
        offsetX: -margin15,
        offsetY: margin15,
        valueListX: model.valueListX,
        valueListY: model.valueListY,
        sizeSet: Size(value, value),
        graphCount: graphCount,
        graphValue: _sizeHeight / 2,
        radData: radData,
        scale: scale);
  }

  OverlappingGridPainter _gridPainter(
      double value, bool baseLine, bool checkLine) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 5,
    );
    return OverlappingGridPainter(
        textStyle: textStyle,
        boxSize: boxSize,
        strokeWidth: 1,
        scale: scale,
        sizeSet: Size(value, value),
        colorSet: Colors.orange,
        graphValue: _sizeHeight / 2,
        radData: radData,
        checkLine: checkLine,
        baseLine: baseLine);
  }

  _setP(OverlappingProgressIndicator? indicator, String tex, double value,
      int index, double value2) {
    return indicator?.setPainter(tex, value, index, value2, model.colorList,
        textColor: Colors.black);
  }

  ///　details of graph characters, ruled lines, and animation amount.
  CustomPaint _sePainter(OverlappingProgressIndicator? p, double value,
      bool baseLine, bool checkLine) {
    double v = (graph / graphCount);
    return CustomPaint(
      painter: baseLine ? _graphText(value) : null,
      child: CustomPaint(
        painter: _gridPainter(value, baseLine, checkLine),
        child: CustomPaint(
          painter: _setP(p, "", -1, 0, 0),
          child: CustomPaint(
            painter: _setP(p, "", 0 / v, 0, v),
            child: CustomPaint(
              painter: _setP(p, "1", 1 / v, 1, v),
              child: CustomPaint(
                painter: _setP(p, "2", 2 / v, 2, v),
                child: CustomPaint(
                  painter: _setP(p, "3", 3 / v, 3, v),
                  child: CustomPaint(
                    painter: _setP(p, "4", 4 / v, 4, v),
                    child: CustomPaint(
                      painter: _setP(p, "5", 5 / v, 5, v),
                      child: CustomPaint(
                        painter: _setP(p, "6", 6 / v, 6, v),
                        child: CustomPaint(
                          painter: _setP(p, "7", 7 / v, 7, v),
                          child: CustomPaint(
                            painter: _setP(p, "8", 8 / v, 8, v),
                            child: CustomPaint(
                              painter: _setP(p, "9", 9 / v, 9, v),
                              child: CustomPaint(
                                painter: _setP(p, "", 10 / v, 10, v),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
        call(OverLapType.graph);
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
        radDataRadDataVertical: Offset(_sizeHeight / 6, 0),
        radDataRadDataHorizontal: Offset(_sizeHeight / 2, 0),
        dataVerticalSize: const Size(120, 120),
        dataHorizontalSize: const Size(120, 120),
        globalKey: key,
        contextSize: Size(w, _sizeHeight),
        con: context,
        streamController: StreamController(),
        setPaint: setPaint,
        scale: scale,
        boxSize: boxSize,
        foldHeight: (fold.appBar?.preferredSize.height ?? 0),
        animationValue: (animationController?.value ?? 0) * index);
  }
}
