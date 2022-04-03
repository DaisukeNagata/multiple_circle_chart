import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/circle_data_item.dart';
import 'package:multiple_circle_chart/circle_progress_controller.dart';
import 'package:multiple_circle_chart/multiple_circle_set_progress.dart';

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

  late CircleDataItem c = CircleDataItem(
    /// circleForwardFlg is forward or reverse.
    true,

    /// CircleShader is an end type circle None has no knob.
    CircleShader.circleNone,

    /// ComplementCircle is the tuning when the circle is changed to large or small.
    0.05,

    /// circleSizeValue.
    _circleSize,

    /// CircleLabelValue is reverse.
    0.0,

    /// circleLabelSpeedValue is speed.
    0.0,

    /// circleCounterValue is forward.
    0.0,

    /// circleSpeedCounterValue is speed.
    0.0,

    /// circleStrokeWidth is the thickness of the circle.
    30.0,

    /// circleShadowValue is The shadow range value
    0.01,

    /// circlePointerValue is The size of the knob.
    15,

    /// circleDuration is circle animation speed
    _speedValue.toInt(),

    /// circleColor is the color of the knob.
    Colors.green,

    /// circleColor is the shadow color of the knob.
    Colors.black,

    /// circleRoundColor is The base color of circleRoundColor.
    Colors.grey,

    /// circleController is CircleProgressController.
    controller,

    /// circleColorList is Determines the gradient color.
    setColor,
  );
  late MultipleCircleSetProgress? circleSetProgress;
  double paddingValue = 20;
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
    controller.counterStream.listen((event) {
      setState(() {
        var e = 0.0;
        if (event != 0.0) {
          e = (event as double);
        }
        _circleLabelValue = (e * 100);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int index = setColor.length;
    double count = index * 1.0;
    _circleSize = _circleSize == 0.0
        ? MediaQuery.of(context).size.width / 2
        : _circleSize;
    circleSetProgress = MultipleCircleSetProgress(circle: c);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              const Padding(padding: EdgeInsets.only(top: 20)),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _circleLabelValue.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  SizedBox(
                    width: c.circleSizeValue,
                    height: c.circleSizeValue,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(360 / 360),
                      child: circleSetProgress,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text("end$_forwardValue"),
              Text("start$_reverseValue"),
              Text("speed${c.circleDuration}"),
              Text("size${c.circleSizeValue}"),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Slider(
                value: _forwardValue,
                min: 0,
                max: count,
                divisions: 1000,
                onChanged: (double value) {
                  setState(() {
                    _forwardValue = value;
                  });
                },
              ),
              Slider(
                value: _reverseValue,
                min: 0,
                max: count,
                divisions: 1000,
                onChanged: (double value) {
                  setState(() {
                    _reverseValue = value;
                  });
                },
              ),
              Slider(
                value: _speedValue,
                min: 0,
                max: 20000,
                divisions: 1000,
                onChangeEnd: (double value) {
                  setState(() {
                    c.circleDuration = _speedValue.toInt();
                  });
                },
                onChanged: (double value) {
                  setState(() {
                    _speedValue = value.roundToDouble();
                  });
                },
              ),
              Slider(
                value: c.circleSizeValue,
                min: 0,
                max: MediaQuery.of(context).size.width,
                divisions: 1000,
                onChanged: (double value) {
                  setState(() {
                    c.circleSizeValue = value;
                  });
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  setButton(true, _forwardValue, c.circleLabelValue),
                  CupertinoSwitch(
                    value: _circleColorFlg,
                    onChanged: (flg) {
                      c.circleShader = c.circleShader == CircleShader.circleNone
                          ? CircleShader.butt
                          : CircleShader.circleNone;
                      _circleColorFlg = flg;
                      c.circleColor = c.circleColor == Colors.green
                          ? Colors.green.withOpacity(0)
                          : Colors.green;
                      c.circleShadowColor = c.circleShadowColor == Colors.black
                          ? Colors.black.withOpacity(0)
                          : Colors.black;
                    },
                  ),
                  CupertinoSwitch(
                    value: _circleShaderFlg,
                    onChanged: (flg) {
                      _circleShaderFlg = flg;
                      c.circleShader = c.circleShader == CircleShader.circleNone
                          ? CircleShader.round
                          : CircleShader.circleNone;
                    },
                  ),
                  setButton(false, c.circleCounterValue,
                      c.circleCounterValue == 0 ? 0 : _reverseValue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton setButton(
      circleForwardFlg, circleCounterValue, circleLabelValue) {
    return FloatingActionButton(
      onPressed: () {
        _scrollController.jumpTo(0.0);
        c.circleForwardFlg = circleForwardFlg;
        c.circleCounterValue = circleCounterValue;
        c.circleLabelSpeedValue = circleLabelValue;
        c.circleLabelValue = circleLabelValue;
        controller.setProgress([c.circleCounterValue, c.circleLabelValue]);
      },
      child: const Icon(Icons.play_circle),
    );
  }
}
