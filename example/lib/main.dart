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
  double _forwardValue = 0.0;
  double _reverseValue = 0.0;
  double _speedValue = 0.0;
  double _circleSize = 0.0;
  double _circleLabelValue = 0.0;
  bool _circleColorFlg = true;
  bool _circleShaderFlg = true;
  bool _circleCombineFlg = true;
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
      circleColorList: setColor);

  late MultipleCircleSetProgress? circleSetProgress;
  final double paddingValue = 30;
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
          _scrollController.jumpTo(0.0);
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: paddingValue)),
              stack(),
              textSets(),
              sliderSets(),
              setRow(),
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
    circleSetProgress = MultipleCircleSetProgress(circle: c);
  }

  Column textSets() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: paddingValue)),
        Text("end$_forwardValue"),
        Text("start$_reverseValue"),
        Text("speed${c.circleDuration}"),
        Text("size${c.circleSizeValue}"),
      ],
    );
  }

  Column sliderSets() {
    return Column(
      children: [
        sliderSet(_forwardValue, setColor.length.toDouble(),
            keyValue: globalKey),
        sliderSet(_reverseValue, setColor.length.toDouble(),
            keyValue: globalKey2),
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
                Padding(padding: EdgeInsets.only(top: paddingValue)),
                setButton(true, _forwardValue, c.circleLabelValue ?? 0),
                Padding(padding: EdgeInsets.only(top: paddingValue)),
                setButton(false, c.circleCounterValue ?? 0,
                    c.circleCounterValue == 0 ? 0 : _reverseValue),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: paddingValue)),
            Padding(padding: EdgeInsets.only(top: paddingValue)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                switchSet(_circleColorKey),
                Padding(
                    padding: EdgeInsets.only(
                        left: paddingValue, right: paddingValue)),
                switchSet(_circleShaderFlgKey),
                Padding(
                    padding: EdgeInsets.only(
                        left: paddingValue, right: paddingValue)),
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
          ),
        ),
      ],
    );
  }

  CupertinoSwitch switchSet(Key keyValue) {
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
            _circleCombineFlg = flg;
            c.circleStrokeWidth = 60;
            c.circlePointerValue = c.circleStrokeWidth / 2;

            /// Pie chart animation direction.

            // c.startValue = [0, 0.25, 0.45, 0.55, 0.7];
            // c.endValue = [0.25, 0.2, 0.1, 0.15, 0.3];

            // c.startValue = [0, 0.25, 0.35, 0.75, 0.811];
            // c.endValue = [0.25, 0.1, 0.4, 0.061, 0.189];

            c.startValue = [0, 0.25, 0.35, 0.75, 0.810];
            c.endValue = [0.25, 0.1, 0.4, 0.060, 0.19];
            c.circleCombinedTextSize = 11;
            c.circleTextList = [
              "0\nExample\nTestA",
              "0.25\nExample\nTestB",
              "0.35\nExample\nTestC",
              "0.75\nExample\nTestD",
              "0.825\nExample\nTestE"
            ];
            c.circleCombinedColor = [
              Colors.black,
              Colors.grey,
              Colors.red,
              Colors.yellow,
              Colors.blue
            ];

            /// Select your favorite element
            c.circleCombinedColorList = [
              Colors.blue,
              Colors.black,
              Colors.green,
              Colors.purple,
              Colors.black
            ];
            if (flg) {
              c.circleStrokeWidth = 30;
              c.circlePointerValue = c.circleStrokeWidth / 2;
              c.startValue = [];
              c.endValue = [];
              c.startValue = [];
              c.circleCombinedColorList = [];
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
          if (keyValue == globalKey) {
            _forwardValue = value;
          } else if (keyValue == globalKey2) {
            _reverseValue = value;
          } else if (max == MediaQuery.of(context).size.width) {
            c.circleSizeValue = value;
          } else if (max == 20000) {
            _speedValue = value;
            c.circleDuration = _speedValue.toInt();
          }
        });
      },
    );
  }

  /// Set the animation value, speed, forward direction, and reverse direction in the library.
  OutlinedButton setButton(bool circleForwardFlg, double circleCounterValue,
      double circleLabelValue) {
    return OutlinedButton(
      onPressed: () {
        _circleCombineFlg = true;
        c.circleStrokeWidth = 30;
        _scrollController.jumpTo(0.0);
        c.circleForwardFlg = circleForwardFlg;
        c.circleCounterValue = circleCounterValue;
        c.circleLabelSpeedValue = circleLabelValue;
        c.circleLabelValue = circleLabelValue;
        controller
            .setProgress([c.circleCounterValue ?? 0, c.circleLabelValue ?? 0]);
      },
      child: const Icon(Icons.play_circle),
    );
  }
}
