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
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey _circleColorKey = GlobalKey();
  GlobalKey _circleShaderFlgKey = GlobalKey();

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
  final double paddingValue = 20;
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
              Padding(padding: EdgeInsets.only(top: paddingValue)),
              Text("end$_forwardValue"),
              Text("start$_reverseValue"),
              Text("speed${c.circleDuration}"),
              Text("size${c.circleSizeValue}"),
              sliderSet(_forwardValue, setColor.length.toDouble(),
                  keyValue: globalKey),
              sliderSet(_reverseValue, setColor.length.toDouble(),
                  keyValue: globalKey2),
              sliderSet(_speedValue, 20000.0),
              sliderSet(c.circleSizeValue, MediaQuery.of(context).size.width),
              Padding(padding: EdgeInsets.only(top: paddingValue)),
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
          e = (event as double);
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

  Row setRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        setButton(true, _forwardValue, c.circleLabelValue),
        switchSet(_circleColorKey),
        switchSet(_circleShaderFlgKey),
        setButton(false, c.circleCounterValue,
            c.circleCounterValue == 0 ? 0 : _reverseValue),
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
    } else {
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
