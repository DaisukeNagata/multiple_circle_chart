import 'dart:math';
import 'circle_data_item.dart';
import 'package:flutter/material.dart';

/// CircleOuterFrame is a class that sets the first week of a pie chart.
class CircleOuterFrame extends CustomPainter {
  final AnimationController _controller;
  final double _baseAnimationValue;
  final CircleDataItem _data;
  final double _startAngle = 0;
  final double _rotate = 270;

  CircleOuterFrame(this._controller, this._baseAnimationValue, this._data);

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.restore();

    double time = double.parse(_baseAnimationValue.toString());

    /// Treat as an element of the color array.
    int baseAnimationValueIndex = _baseAnimationValue.floor() - 1;

    /// Element calculation during teleportation in reverse order.
    int circleLabelValue =
        _data.circleLabelValue.floor() == _data.circleColorList.length
            ? _data.circleLabelValue.floor() - 1
            : _data.circleLabelValue.floor();

    /// Size when drawing an arc.
    double sizeSet = size.width / 2;

    /// Animation calculated value
    double progressSet = pi * 2 * time;

    /// Calculation that circle needs to rotate.
    double translate = -size.width;

    List<Color> colorSet;

    /// Circle rotation calculation.
    canvas.rotate(degToRad(_rotate));

    ///　Move calculation
    canvas.translate(translate, 0);

    /// Stop value in animated state and notify value.
    if (_controller.status == AnimationStatus.dismissed ||
        time != 0.0 && time <= _data.circleLabelValue) {
      _controller.stop();

      _data.circleController.setCounter(_data.circleLabelValue);
    } else {
      _baseAnimationValue == 0
          ? _data.circleController.setCounter(_data.circleLabelValue)
          : _data.circleController.setCounter(_baseAnimationValue);
    }

    canvas.restore();

    ///　Calculation of shaderColor.
    colorSet = _data.circleColorList[
        baseAnimationValueIndex <= 0 ? 0 : baseAnimationValueIndex];

    /// Element calculation during teleportation in reverse order.
    if (!_controller.isAnimating && !_data.circleForwardFlg) {
      colorSet = _data.circleColorList[circleLabelValue >= 1
          ? _data.circleLabelValue.floor() == _data.circleColorList.length
              ? circleLabelValue
              : circleLabelValue - 1
          : circleLabelValue];
    }

    Paint paint = Paint()
      ..strokeWidth = _data.circleStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..shader = SweepGradient(colors: colorSet).createShader(Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2));

    /// Answer substitution and animation amount are set by animation speed.
    canvas.drawArc(
        Rect.fromCircle(center: size.center(Offset.zero), radius: sizeSet),
        _startAngle,
        time <= _data.circleLabelValue
            ? _data.circleLabelValue == 0
                ? 0
                : (pi * 2 * _data.circleLabelValue)
            : progressSet,
        false,
        paint);

    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
