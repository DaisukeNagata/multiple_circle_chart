import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/circle_progress_controller.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';

import 'overlapping_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EveryDaySoft_Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _fValue = 0.0;
  double _rValue = 0.0;
  double _speedValue = 0.0;
  double _circleSize = 0.0;
  double _circleLabelValue = 0.0;
  bool _circleColorFlg = true;
  bool _circleShaderFlg = true;
  bool _circleCombineFlg = true;
  final GlobalKey circleKey = GlobalKey();
  final GlobalKey globalKey = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();
  final GlobalKey _circleColorKey = GlobalKey();
  final GlobalKey _circleShaderFlgKey = GlobalKey();
  final GlobalKey _circleCombinedKey = GlobalKey();

  late CircleDataItem c = CircleDataItem(

      /// circleForwardFlg is forward or reverse.
      circleForwardFlg: true,

      /// CircleShader is an end type circle None has no knob.
      circleShader: CircleShader.circleNone,

      /// ComplementCircle is the tuning when the circle is changed to large or small.
      complementCircle: 0.05,

      /// circleSizeValue.
      circleSizeValue: _circleSize,

      /// circleStrokeWidth is the thickness of the circle.
      circleStrokeWidth: 30.0,

      /// circleShadowValue is The shadow range value
      circleShadowValue: 0.01,

      /// circleDuration is circle animation speed
      circleDuration: _speedValue.toInt(),

      /// circleColor is the color of the knob.
      circleColor: Colors.green,

      /// circleColor is the shadow color of the knob.
      circleShadowColor: Colors.black,

      /// circleRoundColor is The base color of circleRoundColor.
      circleRoundColor: Colors.grey,

      /// circleController is CircleProgressController.
      circleController: controller,

      /// circleColorList is Determines the gradient color.
      circleColorList: setColor,

      /// circleTextSizeList is get character coordinates.
      circleTextSizeList: []);

  late MultipleCircleSetProgress? circleSetProgress;
  double paddingValue = 30;
  double paddingValueTopAndBottom = 60;
  final CircleProgressController controller = CircleProgressController();
  final ScrollController _scrollController = ScrollController();

  /// In the double array, the last element and the next element first have the same color and become a gradation.
  final List<List<Color>> setColor = [
    [Colors.white, Colors.blue],
    [Colors.blue, Colors.orange],
    [Colors.orange, Colors.yellow],
    [Colors.yellow, Colors.purple],
    [Colors.purple, Colors.lime],
    [Colors.lime, Colors.limeAccent],
    [Colors.limeAccent, Colors.pink],
    [Colors.pink, Colors.brown],
    [Colors.brown, Colors.white],
    [Colors.white, Colors.green],
    [Colors.green, Colors.deepOrangeAccent],
    [Colors.deepOrangeAccent, Colors.lightBlueAccent],
  ];

  @override
  void initState() {
    super.initState();

    counterStream();
  }

  @override
  Widget build(BuildContext context) {
    circleSet();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const OverLappingBar();
              }));
            },
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          _scrollController.animateTo(
            _scrollController.offset == 0
                ? _scrollController.position.maxScrollExtent
                : 0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: paddingValueTopAndBottom)),
              stack(),
              textSets(),
              sliderSets(),
              setRow(),
              Padding(padding: EdgeInsets.only(top: paddingValue)),
            ],
          ),
        ),
      ),
    );
  }

  counterStream() {
    /// Show animation values.
    controller.counterStream.listen((event) {
      setState(() {
        var e = 0.0;
        if (event != 0.0) {
          e = event;
        }
        _circleLabelValue = (e * 100);
      });
    });
  }

  circleSet() {
    /// Determine the size of the circle.
    _circleSize = _circleSize == 0.0
        ? MediaQuery.of(context).size.width / 2
        : _circleSize;
    circleSetProgress =
        MultipleCircleSetProgress(circleKey: circleKey, circle: c);
  }

  Column textSets() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: paddingValue * 2)),
        Text("end$_fValue"),
        Text("start$_rValue"),
        Text("speed${c.circleDuration}"),
        Text("size${c.circleSizeValue}"),
      ],
    );
  }

  Column sliderSets() {
    return Column(
      children: [
        wSlider(RangeValues(_rValue, _fValue), setColor.length.toDouble(),
            keyValue: globalKey),
        sliderSet(_speedValue, 20000.0),
        sliderSet(c.circleSizeValue, MediaQuery.of(context).size.width),
        Padding(padding: EdgeInsets.only(top: paddingValue))
      ],
    );
  }

  Row setRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                setButton(true, _fValue, c.circleLabelValue ?? 0),
                setButton(false, c.circleCounterValue ?? 0,
                    c.circleCounterValue == 0 ? 0 : _rValue),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: paddingValue)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                switchSet(_circleColorKey),
                switchSet(_circleShaderFlgKey),
                switchSet(_circleCombinedKey),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Stack stack() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            _circleLabelValue.toStringAsFixed(1),
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: paddingValue)),
        SizedBox(
          width: c.circleSizeValue,
          height: c.circleSizeValue,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(360 / 360),
            child: circleSetProgress,
            key: circleKey,
          ),
        ),
      ],
    );
  }

  CupertinoSwitch switchSet(Key keyValue) {
    Padding(padding: EdgeInsets.only(left: paddingValue, right: paddingValue));
    if (keyValue == _circleColorKey) {
      return CupertinoSwitch(
        key: _circleColorKey,
        value: _circleColorFlg,
        onChanged: (flg) {
          _circleColorFlg = flg;

          /// Determine the type of knob
          c.circleShader = c.circleShader == CircleShader.circleNone
              ? CircleShader.butt
              : CircleShader.circleNone;

          /// Determine the knob color
          c.circleColor = c.circleColor == Colors.green
              ? Colors.green.withOpacity(0)
              : Colors.green;

          /// Determine the knob shadow color
          c.circleShadowColor = c.circleShadowColor == Colors.black
              ? Colors.black.withOpacity(0)
              : Colors.black;
        },
      );
    } else if (keyValue == _circleShaderFlgKey) {
      return CupertinoSwitch(
        key: _circleShaderFlgKey,
        value: _circleShaderFlg,
        onChanged: (flg) {
          /// Pie chart animation direction.
          _circleShaderFlg = flg;

          /// Determine the type of knob
          c.circleShader = c.circleShader == CircleShader.circleNone
              ? CircleShader.round
              : CircleShader.circleNone;
        },
      );
    } else {
      return CupertinoSwitch(
        key: _circleCombinedKey,
        value: _circleCombineFlg,
        onChanged: (flg) {
          setState(() {
            _circleColorFlg = flg;
            _circleCombineFlg = flg;
            _circleShaderFlg = flg;
            c.circleStrokeWidth = c.circleSizeValue / 3;
            c.circleTextMarginList = [const Size(15, 15)];

            c.circleCombinedTextSize = 12;
            _randomCircleList(Random().nextInt(7));

            /// Determine the type of knob
            c.circleShader = CircleShader.butt;

            /// Determine the knob color
            c.circleColor = Colors.green.withOpacity(0);

            /// Determine the knob shadow color
            c.circleShadowColor = Colors.black.withOpacity(0);

            if (flg) {
              setState(() {
                c.startValue = [];
                c.endValue = [];
                c.startValue = [];
                c.circleCombinedColorList = [];
                _resetCircle();
              });
            }
          });

          /// Determine the type of knob
          c.circleShader = c.circleShader == CircleShader.circleNone
              ? CircleShader.round
              : CircleShader.circleNone;
        },
      );
    }
  }

  _resetCircle() {
    setState(() {
      /// Determine the type of knob
      c.circleShader = CircleShader.butt;

      /// Determine the knob color
      c.circleColor = Colors.green;

      /// Determine the knob shadow color
      c.circleShadowColor = Colors.black;

      paddingValue = 30;
      c.circleStrokeWidth = 30;
      c.circlePointerValue = c.circleStrokeWidth / 2;
      c.circleSizeValue = 0;
      c.circleSizeValue = MediaQuery.of(context).size.width / 2;
    });
  }

  _randomCircleList(int index) {
    /// Pie chart animation direction.
    switch (index) {
      case 0:
        c.startValue = [0, 0.25, 0.45, 0.5, 0.7];
        c.endValue = [0.25, 0.2, 0.05, 0.2, 0.3];
        break;
      case 1:
        c.startValue = [0, 0.25, 0.35, 0.78, 0.841];
        c.endValue = [0.25, 0.1, 0.43, 0.061, 0.159];
        break;
      case 2:
        c.startValue = [0, 0.15, 0.57, 0.7, 0.83];
        c.endValue = [0.15, 0.42, 0.13, 0.13, 0.17];
        break;
      case 3:
        c.startValue = [0, 0.25, 0.53, 0.73, 0.83];
        c.endValue = [0.25, 0.3, 0.22, 0.1, 0.17];
        break;
      case 4:
        c.startValue = [0, 0.25, 0.35, 0.45, 0.84];
        c.endValue = [0.25, 0.1, 0.1, 0.39, 0.16];
        break;
      case 5:
        c.startValue = [0, 0.15, 0.55, 0.65, 0.85];
        c.endValue = [0.15, 0.4, 0.1, 0.2, 0.15];
        break;
      case 6:
        c.startValue = [0, 0.5, 0.7, 0.9, 0.95];
        c.endValue = [0.5, 0.2, 0.2, 0.05, 0.05];
        break;
    }

    /// unwrap compatible
    c.circleTextMarginList = c.circleTextMarginList ?? [const Size(15, 15)];
    for (var i = 0; i <= (c.startValue?.length ?? 0); i++) {
      c.circleTextMarginList!.insert(i, const Size(15, 15));
    }

    c.circleTextList = [
      "${c.startValue?[0] ?? ""}${"%"}\n${c.endValue?[0] ?? ""}${"%"}\nExample",
      "${c.startValue?[1] ?? ""}${"%"}\n${c.endValue?[1] ?? ""}${"%"}\nExample",
      "${c.startValue?[2] ?? ""}${"%"}\n${c.endValue?[2] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
      "${c.startValue?[3] ?? ""}${"%"}\n${c.endValue?[3] ?? ""}${"%"}\nExample",
      "${c.startValue?[4] ?? ""}${"%"}\n${c.endValue?[4] ?? ""}${"%"}\nExample\nExample\nExample\nExample\nExample\nExample",
    ];
    c.circleCombinedColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white
    ];

    /// Select your favorite element
    c.circleCombinedColorList = [
      Colors.blue,
      Colors.black,
      Colors.green,
      Colors.grey,
      Colors.orange
    ];
  }

  RangeSlider wSlider(RangeValues values, max, {Key? keyValue}) {
    return RangeSlider(
      key: keyValue,
      values: values,
      max: max,
      divisions: 1000,
      labels: RangeLabels(
        values.start.round().toString(),
        values.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          if (_rValue != values.start) {
            _rValue = values.start;
          } else if (_fValue != values.end) {
            _fValue = values.end;
          }
        });
      },
    );
  }

  Slider sliderSet(double value, max, {Key? keyValue}) {
    Padding(padding: EdgeInsets.only(top: paddingValue));
    return Slider(
      key: keyValue,
      value: value,
      min: 0,
      max: max,
      divisions: 1000,
      onChanged: (double value) {
        setState(() {
          if (max == MediaQuery.of(context).size.width) {
            c.circleSizeValue = value;
            if (!_circleCombineFlg) {
              c.circleStrokeWidth = value / 3;
            }
          } else if (max == 20000) {
            _speedValue = value;
            c.circleDuration = _speedValue.toInt();
          }
        });
      },
    );
  }

  /// Set the animation value, speed, forward direction, and reverse direction in the library.
  OutlinedButton setButton(
      bool forwardFlg, double counterValue, double circleLabelValue) {
    Padding(padding: EdgeInsets.only(top: paddingValue));
    return OutlinedButton(
      onPressed: () {
        c.circleForwardFlg = forwardFlg;
        c.circleCounterValue = counterValue;
        c.circleLabelSpeedValue = circleLabelValue;
        c.circleLabelValue = circleLabelValue;
        controller
            .setProgress([c.circleCounterValue ?? 0, c.circleLabelValue ?? 0]);
      },
      child: const Icon(Icons.play_circle),
    );
  }
}
