import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlapSmooth/overlapping_line_smooth_painter.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_grid_painter.dart';

class OverLapSmoothBar extends StatelessWidget {
  const OverLapSmoothBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('EveryDaySoft_Example'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: const OverLapSmoothPage(),
      ),
    );
  }
}

class OverLapSmoothPage extends StatefulWidget {
  const OverLapSmoothPage({Key? key}) : super(key: key);

  @override
  State<OverLapSmoothPage> createState() => _OverLapSmoothState();
}

class _OverLapSmoothState extends State<OverLapSmoothPage> {
  @override
  Widget build(BuildContext context) {
    var _count = 8.0;
    var _originX = 10.0;
    var _height = 200.0;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            painter: gridPainter(
              MediaQuery.of(context).size.width - _originX * 2,
              _count.toInt(),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: OverLappingLineSmoothPainter(
              originX: _originX,
              height: _height,
              width:
                  (MediaQuery.of(context).size.width - _originX * 2) / _count,
              data: [
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
                (_height +
                    _originX -
                    ((_height / _count) * Random().nextInt(8))),
              ],
              paintSet: Paint()
                ..color = Colors.red
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3.0,
            ),
          ),
        ),
      ],
    );
  }

  OverlappingLineGridPainter gridPainter(double value, int count) {
    TextStyle textStyle = const TextStyle(
      inherit: true,
      fontSize: 5,
    );

    return OverlappingLineGridPainter(
      textStyle: textStyle,
      boxSize: 25.0,
      wLines: count,
      strokeWidth: 1,
      sizeSet: Size(value, value),
      colorSet: Colors.greenAccent,
      radData: RadData.vertical,
    );
  }
}
