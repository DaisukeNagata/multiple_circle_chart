import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_progress_indicator.dart';

class OverLappingBar extends StatelessWidget {
  const OverLappingBar({Key? key}) : super(key: key);

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
        body: const OverLappingWidget(),
      ),
    );
  }
}

class OverLappingWidget extends StatefulWidget {
  const OverLappingWidget({Key? key}) : super(key: key);

  @override
  _OverLappingBarState createState() => _OverLappingBarState();
}

class _OverLappingBarState extends State<OverLappingWidget>
    with TickerProviderStateMixin {
  List<Color> colorList = [
    Colors.green.shade50,
    Colors.green.shade100,
    Colors.green.shade200,
    Colors.green.shade300,
  ];

  List<Color> colorList2 = [
    Colors.green.shade500,
    Colors.green.shade600,
    Colors.green.shade700,
    Colors.green.shade800,
    Colors.green.shade900
  ];
  late AnimationController? _animationController;
  OverlappingProgressIndicator? indicator;
  OverlappingProgressIndicator? indicator2;
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  RadData _radData = RadData.vertical;

  CustomPaint setPaint() {
    return CustomPaint(
      painter: indicator?.setPainter("", -1, 0, colorList,
          circleData: CircleData.allCircle, textColor: Colors.grey),
      child: CustomPaint(
        painter: indicator?.setPainter("0", 0, 3, colorList,
            circleData: CircleData.allCircle),
        child: CustomPaint(
          painter: indicator?.setPainter("1", 1, 3, colorList),
          child: CustomPaint(
            painter: indicator?.setPainter("2", 2, 3, colorList),
          ),
        ),
      ),
    );
  }

  CustomPaint setPaint2() {
    return CustomPaint(
      painter: indicator2?.setPainter("", -1, 0, colorList2,
          circleData: CircleData.allCircle, textColor: Colors.grey),
      child: CustomPaint(
        painter: indicator2?.setPainter("0", 0, 2.5, colorList2,
            circleData: CircleData.allCircle),
        child: CustomPaint(
          painter: indicator2?.setPainter("1", 1, 2.5, colorList2),
          child: CustomPaint(
            painter: indicator2?.setPainter("2", 2, 2.5, colorList2),
            child: CustomPaint(
              painter: indicator2?.setPainter("3", 3, 2.5, colorList2),
            ),
          ),
        ),
      ),
    );
  }

  _animationControllerInit() {
    var rand = Random();
    rand.nextInt(1);
    _animationController = AnimationController(
      vsync: this,
      upperBound: 1,
    )..addListener(() {
        setState(() {
          indicator = indicatorSet(
              globalKey, MediaQuery.of(context).size.width / 1.2, setPaint());
          indicator2 = indicatorSet(
              globalKey2, MediaQuery.of(context).size.width / 1.2, setPaint2());
        });
      });
    _animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future(() {
          _animationController?.reset();
          _animationController?.stop();
        });
      }
    });
    _animationController?.duration = const Duration(milliseconds: 1500);
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Transform.rotate(
            angle: (indicator?.radData == RadData.horizontal ? 360 : -90) *
                pi /
                180,
            child: Column(
              children: [
                indicatorRowSet(indicator),
                indicatorRowSet(indicator2),
              ],
            )),
        buttonSet(),
      ],
    );
  }

  OverlappingProgressIndicator indicatorSet(
      GlobalKey key, double w, CustomPaint setPaint) {
    return OverlappingProgressIndicator(
        radData: _radData,
        radDataRadDataVertical: const Offset(20, 20),
        radDataRadDataHorizontal: const Offset(1, 20),
        dataVerticalSize: const Size(120, 120),
        dataHorizontalSize: const Size(150, 120),
        globalKey: key,
        contextSize: Size(w, 15),
        con: context,
        stream: StreamController(),
        setPaint: setPaint,
        animationValue: _animationController?.value);
  }

  Row indicatorRowSet(OverlappingProgressIndicator? indicator) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(top: 100, left: 30)),
        SizedBox(
            height: 15,
            width: MediaQuery.of(context).size.width / 1.2,
            child: indicator),
      ],
    );
  }

  ElevatedButton buttonSet() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _radData = _radData == RadData.vertical
              ? RadData.horizontal
              : RadData.vertical;
          _animationControllerInit();
        });
      },
      child: const Text('click here'),
    );
  }
}
