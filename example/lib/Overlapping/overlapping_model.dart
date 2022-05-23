import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_progress_indicator.dart';

class OverLappingModel {
  late AnimationController? animationController;
  OverlappingProgressIndicator? lastIndicator;
  OverlappingProgressIndicator? indicator;
  OverlappingProgressIndicator? indicator2;
  OverlappingProgressIndicator? indicator3;
  OverlappingProgressIndicator? indicator4;
  OverlappingProgressIndicator? indicator5;
  OverlappingProgressIndicator? indicator6;
  OverlappingProgressIndicator? indicator7;
  OverlappingProgressIndicator? indicator8;
  OverlappingProgressIndicator? indicator9;
  late List<OverlappingProgressIndicator?> indicatorList = [
    indicator,
    indicator2,
    indicator3,
    indicator4,
    indicator5,
    indicator6,
    indicator7,
    indicator8,
    indicator9,
    lastIndicator
  ];
  GlobalKey lastGlobalKey = GlobalKey();
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  GlobalKey globalKey4 = GlobalKey();
  GlobalKey globalKey5 = GlobalKey();
  GlobalKey globalKey6 = GlobalKey();
  GlobalKey globalKey7 = GlobalKey();
  GlobalKey globalKey8 = GlobalKey();
  GlobalKey globalKey9 = GlobalKey();
  late List<GlobalKey> globalKeyList = [
    globalKey,
    globalKey2,
    globalKey3,
    globalKey4,
    globalKey5,
    globalKey6,
    globalKey7,
    globalKey8,
    globalKey9,
    lastGlobalKey
  ];
  RadData radData = RadData.vertical;
  int graphCount = 0;
  double boxSize = 0;
  double scale = 1;
  double graphWidth = 1;
  Scaffold fold = const Scaffold();
  final double margin10 = 10;
  final double margin15 = 15;
  final double margin30 = 30;
  final int graph = 10;

  List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.purple,
    Colors.white,
    Colors.yellow,
    Colors.brown,
    Colors.pink,
    Colors.cyan,
    Colors.green,
    Colors.blueGrey,
  ];

  List<String> valueListY = [
    "",
    "J",
    "I",
    "H",
    "G",
    "F",
    "E",
    "D",
    "C",
    "B",
    "A",
  ];

  List<String> valueListX = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];

  List<String> diaLogData = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
}
