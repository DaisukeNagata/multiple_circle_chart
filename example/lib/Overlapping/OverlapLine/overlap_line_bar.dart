import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
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
    return Row(
      children: [bbb()],
    );
  }

  Stack bbb() {
    return Stack(
      children: [
        CustomPaint(
          painter: OverlappingTriPaint(moveToCount: 7, strokeWidth: 2),
          size: Size(MediaQuery.of(context).size.width / 7,
              MediaQuery.of(context).size.width / 7),
        ),
        CustomPaint(
          child: CustomPaint(
            painter: _gridPainter(MediaQuery.of(context).size.width),
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

  // OverlappingGraphText _graphText(double value) {
  //   TextStyle textStyle = const TextStyle(
  //     inherit: true,
  //     fontSize: 10,
  //   );
  //   return OverlappingGraphText(
  //       textStyle: textStyle,
  //       boxSize: MediaQuery.of(context).size.width / 7,
  //       wLines: (MediaQuery.of(context).size.width/7).toInt(),
  //       valueListX: valueListX,
  //       valueListY: valueListY,
  //       sizeSet: Size(value, value),
  //       graphCount: 7,
  //       graphValue: 10 / 2,
  //       radData: RadData.vertical);
  // }

  OverlappingLineGridPainter _gridPainter(double value) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 5,
    );
    return OverlappingLineGridPainter(
        textStyle: textStyle,
        boxSize: MediaQuery.of(context).size.width / 7,
        wLines: 7,
        strokeWidth: 1,
        sizeSet: Size(value, value),
        colorSet: Colors.greenAccent,
        radData: RadData.vertical);
  }
}
