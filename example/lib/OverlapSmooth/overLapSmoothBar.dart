import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlapSmooth/overlapping_line_smooth_painter.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_line_grid_painter.dart';

class OverLapSmoothBar extends StatelessWidget {
  const OverLapSmoothBar({super.key});

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

class _OverLapSmoothState extends State<OverLapSmoothPage>
    with TickerProviderStateMixin {
  late AnimationController con;
  var _arcFlg = false;
  final _listCount = 16.0;
  final _originX = 10.0;
  final _height = 200.0;
  late List<double> data = [];


  @override
  void initState() {
    super.initState();
    con = AnimationController(vsync: this)
      ..duration = const Duration(milliseconds: 5000)
      ..addListener(() {
        setState(() {});
      })
      ..forward();
    for (var i = 0; i <= _listCount; i++) {
      data.add(
        _height + _originX - ((_height / _listCount) * Random().nextInt(16)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            painter: gridPainter(
              MediaQuery.of(context).size.width - _originX * 2,
              _listCount.toInt(),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: OverLappingLineSmoothPainter(
                  originX: _originX,
                  height: _height,
                  width: (MediaQuery.of(context).size.width - _originX * 2) /
                      _listCount,
                  data: data,
                  circleValue: 5,
                  paintSet: Paint()
                    ..color = Colors.red
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3.0,
                  controller: con,
                  arcFlg: _arcFlg,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _arcFlg = !_arcFlg;
                  data.clear();
                  if (_arcFlg) {
                    for (var i = 0; i <= _listCount; i++) {
                      data.add(
                        _height +
                            _originX -
                            ((_height / _listCount) *
                                (i.isEven ? 0 : Random().nextInt(16))),
                      );
                    }
                  } else {
                    for (var i = 0; i <= _listCount; i++) {
                      data.add(
                        _height +
                            _originX -
                            ((_height / _listCount) * Random().nextInt(16)),
                      );
                    }
                  }
                  con
                    ..reset()
                    ..forward();
                });
              },
              child: const Text('click here'),
            ),
          ],
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
      boxSize: 12.5,
      wLines: count,
      strokeWidth: 1,
      sizeSet: Size(value, value),
      colorSet: Colors.greenAccent,
      radData: RadData.vertical,
    );
  }
}
