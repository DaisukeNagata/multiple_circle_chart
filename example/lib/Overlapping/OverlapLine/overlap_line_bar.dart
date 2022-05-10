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
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: w2 + 10, left: w / 2),
          child: CustomPaint(
            painter: _graphText(w2),
          ),
        ),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(top: w2 / 2, left: w / 2)),
            stackLineLogic(w2),
          ],
        ),
      ],
    );
  }

  Stack stackLineLogic(double w2) {
    return Stack(
      children: [
        CustomPaint(
          painter: OverlappingLinePaint(moveToCountList: [
            wLines - 3,
            wLines - 2,
            wLines - 5,
            wLines - 3,
            wLines - 2,
            wLines - 1,
            wLines - 2,
            wLines - 7
          ], strokeWidth: 4, paintColor: Colors.red),
          size: Size(MediaQuery.of(context).size.width / count,
              MediaQuery.of(context).size.width / count),
        ),
        CustomPaint(
          child: CustomPaint(
            painter: _gridPainter(w2),
          ),
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
    "B",
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
        boxSize: value / wLines,
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
        boxSize: value / wLines,
        wLines: wLines,
        strokeWidth: 1,
        sizeSet: Size(value, value),
        colorSet: Colors.greenAccent,
        radData: RadData.vertical);
  }
}
