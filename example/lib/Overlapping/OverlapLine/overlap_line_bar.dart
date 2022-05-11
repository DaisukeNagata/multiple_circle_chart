import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_graph_text.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_grid_painter.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_paint.dart';

class OverLapLineBar extends StatelessWidget {
  const OverLapLineBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('EveryDaySoft_Example'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: const OverLappingWidget(),
      ),
    );
  }
}

class OverLappingWidget extends StatefulWidget {
  const OverLappingWidget({Key? key}) : super(key: key);

  @override
  OverLappingState createState() => OverLappingState();
}

class OverLappingState extends State<OverLappingWidget> {
  final int count = 10;
  final int wLines = 7;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).size.width / count) * wLines;
    double w2 = (MediaQuery.of(context).size.width / count) * wLines;
    List<int> indexList = [
      wLines - Random().nextInt(7),
      wLines - Random().nextInt(7),
      wLines - Random().nextInt(7),
      wLines - Random().nextInt(7),
      wLines - Random().nextInt(7),
      wLines - Random().nextInt(7),
      wLines - Random().nextInt(7),
      wLines - Random().nextInt(7)
    ];
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: w2, left: w / 2),
              child: CustomPaint(
                painter: _graphText(w2),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.width / count),
                  left: w / 2),
              child: stackLineLogic(w2, indexList),
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              indexList = indexList;
            });
          },
          child: const Text('click here'),
        )
      ],
    );
  }

  Stack stackLineLogic(double w, List<int> indexList) {
    return Stack(
      children: [
        CustomPaint(
          child: CustomPaint(
            painter: _gridPainter(w),
          ),
        ),
        CustomPaint(
          painter: OverlappingLinePaint(
              moveToCountList: indexList,
              strokeWidth: 3,
              paintColor: Colors.red),
          size: Size((MediaQuery.of(context).size.width / count),
              MediaQuery.of(context).size.width / count),
        ),
      ],
    );
  }

  List<String> valueListY = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];

  List<String> valueListX = [
    "",
    "A",
    "I",
    "C",
    "D",
    "E",
    "F",
    "G",
  ];

  OverlappingGraphText _graphText(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 10,
    );
    return OverlappingGraphText(
        textStyle: textStyle,
        boxSize: (value / wLines),
        wLines: wLines,
        valueListX: valueListX,
        valueListY: valueListY,
        sizeSet: Size(value, value),
        graphCount: wLines,
        graphValue: 10 / 2,
        radData: RadData.horizontal);
  }

  OverlappingLineGridPainter _gridPainter(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 5,
    );
    return OverlappingLineGridPainter(
        textStyle: textStyle,
        boxSize: (value / wLines),
        wLines: wLines,
        strokeWidth: 1,
        sizeSet: Size(value, value),
        colorSet: Colors.greenAccent,
        radData: RadData.vertical);
  }
}
