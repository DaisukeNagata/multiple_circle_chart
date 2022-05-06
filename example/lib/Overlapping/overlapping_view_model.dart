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

enum OverLapType { graphWidth, slider, graph }

class OverLappingViewModel {
  OverLappingModel model = OverLappingModel();

  Column buttonColumn(OverLapCallBack call, OverLappingBarState vsync) {
    return Column(
      children: [
        sliderSet(OverLapType.slider, call, 2, model.scale, vsync),
        sliderSet(OverLapType.graphWidth, call, 30, model.sizeHeight, vsync),
        buttonSet(call, vsync),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
      ],
    );
  }

  ElevatedButton buttonSet(OverLapCallBack call, OverLappingBarState vsync) {
    return ElevatedButton(
      onPressed: () {
        _buttonSetState(call, vsync);
      },
      child: const Text('click here'),
    );
  }

  Slider sliderSet(OverLapType type, OverLapCallBack call, double max,
      double value, OverLappingBarState vsync,
      {Key? keyValue}) {
    return Slider(
      key: keyValue,
      value: value,
      min: 0,
      max: max,
      label: value.toString(),
      divisions: 1000,
      onChanged: (double value) {
        if (type == OverLapType.slider) {
          call(OverLapType.slider, value: value);
        } else if (type == OverLapType.graphWidth) {
          call(OverLapType.graphWidth, value: value);
        }
      },
      onChangeEnd: (_) {
        if (type == OverLapType.slider) {
          call(OverLapType.graph, vsync: vsync);
        } else if (type == OverLapType.graphWidth) {
          call(OverLapType.graphWidth, value: value);
        }
      },
    );
  }

  ///　Graph coordinate construction.
  Row rowSet(
      OverlappingProgressIndicator? indicator, double width, GlobalKey key) {
    return Row(
      children: [
        SizedBox(
            height: model.sizeHeight, width: width, child: indicator, key: key),
        Padding(padding: EdgeInsets.only(top: model.boxSize * model.scale)),
      ],
    );
  }

  ///　build graph animation.
  animationInitState(BuildContext c, double width) {
    model.boxSize = ((width) / model.graphCount).floorToDouble();
    for (var i = 0; i <= model.globalKeyList.length - 1; i++) {
      if (i == 0) {
        model.indicatorList[i] = _indicatorSet(c, model.globalKeyList[i], width,
            _sePainter(model.indicatorList[i], width, false, true), i * 0.1);
      } else if (i == model.globalKeyList.length - 1) {
        model.indicatorList[i] = _indicatorSet(c, model.globalKeyList[i], width,
            _sePainter(model.indicatorList[i], width, true, true), 1);
      } else {
        model.indicatorList[i] = _indicatorSet(c, model.globalKeyList[i], width,
            _sePainter(model.indicatorList[i], width, false, false), i * 0.1);
      }
    }
  }

  OverlappingGraphText _graphText(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 10,
    );
    return OverlappingGraphText(
        textStyle: textStyle,
        boxSize: (model.boxSize * model.scale),
        wLines: (value ~/ model.boxSize),
        valueListX: model.valueListX,
        valueListY: model.valueListY,
        sizeSet: Size(value, value),
        graphCount: model.graphCount,
        graphValue: model.sizeHeight / 2,
        radData: model.radData);
  }

  OverlappingGridPainter _gridPainter(
      double value, bool baseLine, bool checkLine) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 5,
    );
    return OverlappingGridPainter(
        textStyle: textStyle,
        boxSize: (model.boxSize * model.scale),
        wLines: (value ~/ model.boxSize),
        strokeWidth: 1,
        sizeSet: Size(value, value),
        colorSet: Colors.orange,
        graphValue: model.sizeHeight / 2,
        radData: model.radData,
        checkLine: checkLine,
        baseLine: baseLine);
  }

  _setP(OverlappingProgressIndicator? indicator, String tex, double value,
      int index, double value2) {
    Offset offset = model.radData == RadData.horizontal
        ? const Offset(0, 0)
        : const Offset(0, -15);
    return indicator?.setPainter(
        offset, tex, value, value2, model.colorList[index],
        textColor: Colors.white);
  }

  ///　details of graph characters, ruled lines, and animation amount.
  CustomPaint _sePainter(OverlappingProgressIndicator? p, double value,
      bool baseLine, bool checkLine) {
    double v = (model.graph / model.graphCount);
    return CustomPaint(
      painter: baseLine ? _graphText(value) : null,
      child: CustomPaint(
        painter: _gridPainter(value, baseLine, checkLine),
        child: CustomPaint(
          painter: _setP(p, "", -1, 0, 0),
          child: CustomPaint(
            painter: _setP(p, "1", 0 / v, 0, v),
            child: CustomPaint(
              painter: _setP(p, "2", 1 / v, 1, v),
              child: CustomPaint(
                painter: _setP(p, "3", 2 / v, 2, v),
                child: CustomPaint(
                  painter: _setP(p, "4", 3 / v, 3, v),
                  child: CustomPaint(
                    painter: _setP(p, "5", 4 / v, 4, v),
                    child: CustomPaint(
                      painter: _setP(p, "6", 5 / v, 5, v),
                      child: CustomPaint(
                        painter: _setP(p, "7", 6 / v, 6, v),
                        child: CustomPaint(
                          painter: _setP(p, "8", 7 / v, 7, v),
                          child: CustomPaint(
                            painter: _setP(p, "9", 8 / v, 8, v),
                            child: CustomPaint(
                              painter: _setP(p, "10", 9 / v, 9, v),
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
    model.radData = model.radData == RadData.vertical
        ? RadData.horizontal
        : RadData.vertical;
    model.animationController = AnimationController(
      vsync: vsync,
      upperBound: 1,
    )..addListener(() {
        call(OverLapType.graph);
      });
    model.animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future(() {
          model.animationController?.reset();
          model.animationController?.stop();
        });
      }
    });
    model.animationController?.duration = const Duration(milliseconds: 1500);
    model.animationController?.forward();
  }

  ///　Building a graph.
  OverlappingProgressIndicator _indicatorSet(BuildContext context,
      GlobalKey key, double w, CustomPaint setPaint, double index) {
    return OverlappingProgressIndicator(
        radData: model.radData,
        globalKey: key,
        contextSize: Size(w, model.sizeHeight),
        graphCount: model.graphCount,
        con: context,
        streamController: StreamController(),
        setPaint: setPaint,
        boxSize: model.boxSize * model.scale,
        foldHeight: (model.fold.appBar?.preferredSize.height ?? 0),
        animationValue: (model.animationController?.value ?? 0) * index,
        dialogData: model.diaLogData);
  }
}
