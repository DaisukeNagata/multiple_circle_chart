import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_graph_text.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_grid_painter.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_tripaint.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        bbb(),
      ],
    );
  }

  Stack bbb() {
    return Stack(
      children: [
        Padding(padding: EdgeInsets.only(left: 30, top: 50)),
        CustomPaint(
          painter: OverlappingTriPaint(),
          size: Size(50, 50),
        ),
        CustomPaint(
          child: CustomPaint(
            painter: _gridPainter(MediaQuery.of(context).size.width / 1.2),
          ),
        )
      ],
    );
  }

  List<String> valueListY = [
    "",
    "月",
    "火",
    "水",
    "木",
    "金",
    "土",
    "日",
  ];

  List<String> valueListX = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];

  OverlappingGraphText _graphText(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 10,
    );
    return OverlappingGraphText(
        textStyle: textStyle,
        boxSize: (50 * 1),
        wLines: 7,
        valueListX: valueListX,
        valueListY: valueListY,
        sizeSet: Size(value, value),
        graphCount: 7,
        graphValue: 10 / 2,
        radData: RadData.vertical);
  }

  OverlappingLineGridPainter _gridPainter(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 5,
    );
    return OverlappingLineGridPainter(
        textStyle: textStyle,
        boxSize: (50 * 1),
        wLines: 7,
        strokeWidth: 1,
        sizeSet: Size(value, value),
        colorSet: Colors.greenAccent,
        radData: RadData.vertical);
  }
}
