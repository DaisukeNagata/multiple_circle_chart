import 'dart:math';

class OverlapLineModel {
  static int wLines = 7;
  List<int> indexList = [
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8)
  ];
  List<int> indexList2 = [
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8),
    wLines - Random().nextInt(8)
  ];
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
}
