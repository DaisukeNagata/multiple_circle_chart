import 'dart:math';

import 'package:example/OverlapLine/overlap_line_model.dart';
import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_graph_text.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_goal_model.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_goal_paint.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_grid_painter.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_paint.dart';

class OverlapViewModel {
  OverlapLineModel model = OverlapLineModel();

  indexListLogic() {
    model.indexList = [
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8)
    ];
    model.indexList2 = [
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8),
      OverlapLineModel.wLines - Random().nextInt(8)
    ];
  }

  Stack stackLineLogic(
      double w, double w2, Color paintColor, List<int> indexList) {
    return Stack(
      children: [
        CustomPaint(
          child: CustomPaint(
            painter: gridPainter(w2),
          ),
        ),
        CustomPaint(
          painter: OverlappingLinePaint(
              moveToCountList: indexList,
              strokeWidth: 3,
              scale: 1,
              paintColor: paintColor,
              circlePaintFlg: true),
          size: Size(w, w),
        ),
      ],
    );
  }

  OverlappingGraphText graphText(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 10,
    );
    return OverlappingGraphText(
        textStyle: textStyle,
        boxSize: (value / OverlapLineModel.wLines),
        wLines: OverlapLineModel.wLines,
        valueListX: model.valueListX,
        valueListY: model.valueListY,
        sizeSet: Size(value, value),
        graphCount: OverlapLineModel.wLines,
        graphValue: 10 / 2,
        radData: RadData.horizontal);
  }

  OverlapinrLineGoalPaint goalPainter(double value) {
    return OverlapinrLineGoalPaint(
        boxSize: (value / OverlapLineModel.wLines),
        wLines: OverlapLineModel.wLines,
        sizeSet: Size(value, value),
        goalModel: OverlappingGoalModel(
          goalDashWidth: 5,
          goalDashSpace: 10,
          goalLineWidth: 2,
          goalLineValue: (OverlapLineModel.wLines - Random().nextDouble() * 7),
          goalLineColor: Colors.white,
        ));
  }

  OverlappingLineGridPainter gridPainter(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 5,
    );

    return OverlappingLineGridPainter(
        textStyle: textStyle,
        boxSize: (value / OverlapLineModel.wLines),
        wLines: OverlapLineModel.wLines,
        strokeWidth: 1,
        sizeSet: Size(value, value),
        colorSet: Colors.greenAccent,
        radData: RadData.vertical);
  }
}
