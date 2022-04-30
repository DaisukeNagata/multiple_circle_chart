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
  GlobalKey lastGlobalKey = GlobalKey();
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  GlobalKey globalKey4 = GlobalKey();
  RadData radData = RadData.vertical;
  int graphCount = 0;
  double _boxSize = 0;
  double scale = 1.26;
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

  Slider sliderSet(
      OverLapCallBack call, OverLappingBarState vsync, double value,
      {Key? keyValue}) {
    // Padding(padding: EdgeInsets.only(top: viewModel.pad));
    return Slider(
      key: keyValue,
      value: scale,
      min: 0,
      max: 2,
      label: value.toString(),
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
        Padding(
            padding: EdgeInsets.only(top: (_boxSize * scale), left: margin30)),
        SizedBox(height: _sizeHeight, width: width, child: indicator, key: key),
      ],
    );
  }

  ///　build graph animation.
  animationInitState(BuildContext context, double width) {
    _boxSize = ((width - margin10) / 10).floorToDouble();
    indicator = _indicatorSet(context, globalKey, width,
        _setGridTextPainter(indicator, width, false, true), 0.7);
    indicator2 = _indicatorSet(context, globalKey2, width,
        _setGridTextPainter(indicator2, width, false, false), 0.8);
    indicator3 = _indicatorSet(context, globalKey3, width,
        _setGridTextPainter(indicator3, width, false, false), 1);
    indicator4 = _indicatorSet(context, globalKey4, width,
        _setGridTextPainter(indicator4, width, false, false), 0.4);
    lastIndicator = _indicatorSet(context, lastGlobalKey, width,
        _setGridTextPainter(lastIndicator, width, true, true), 0.5);
  }

  OverlappingGraphText _graphText(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 10,
    );
    return OverlappingGraphText(
        textStyle: textStyle,
        boxSize: _boxSize,
        offsetX: -margin15,
        offsetY: margin10,
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
      color: Colors.white,
      fontSize: 5,
    );
    return OverlappingGridPainter(
        textStyle: textStyle,
        boxSize: _boxSize,
        strokeWidth: 1,
        sizeSet: Size(value, value),
        colorSet: Colors.orange,
        graphValue: _sizeHeight / 2,
        radData: radData,
        checkLine: checkLine,
        baseLine: baseLine);
  }

  _setP(OverlappingProgressIndicator? indicator, String tex, double value,
      int index, double value2) {
    return indicator?.setPainter(tex, value, index, value2, model.colorList);
  }

  ///　details of graph characters, ruled lines, and animation amount.
  CustomPaint _setGridTextPainter(OverlappingProgressIndicator? p, double value,
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
        radDataRadDataVertical: const Offset(20, 20),
        radDataRadDataHorizontal: const Offset(1, 20),
        dataVerticalSize: const Size(120, 120),
        dataHorizontalSize: const Size(120, 120),
        globalKey: key,
        contextSize: Size(w, _sizeHeight),
        con: context,
        streamController: StreamController(),
        setPaint: setPaint,
        animationValue: (animationController?.value ?? 0) * index);
  }
}
