library multiple_circle_chart;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'circle_data_item.dart';
import 'dart:math';

class InnerCircle extends CustomPainter {
  final AnimationController _controller;
  Animation<double> _animation;
  final double _baseAnimationValue;
  final CircleDataItem _data;
  final double _startAngle = 0;
  final double _rotate = 270;

  InnerCircle(
      this._controller, this._animation, this._baseAnimationValue, this._data);

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorSet;
    double time = double.parse(_baseAnimationValue.toString());
    double value =
        (_data.circleCounterValue - _data.circleCounterValue.floor());
    double reverseValue =
        (_data.circleLabelSpeedValue - _data.circleLabelSpeedValue.floor());
    int baseAnimationValueIndex =
        _baseAnimationValue.floor() == _data.circleColorList.length
            ? _baseAnimationValue.floor() - 1
            : _baseAnimationValue.floor();
    int circleLabelValue =
        _data.circleLabelValue.floor() == _data.circleColorList.length
            ? _data.circleLabelValue.floor() - 1
            : _data.circleLabelValue.floor();

    _animation = Tween(
            begin: -_baseAnimationValue.floor().toDouble(),
            end: _data.circleCounterValue - _baseAnimationValue.floor())
        .animate(_controller);
    if (_controller.status == AnimationStatus.dismissed ||
        time != 0.0 && time <= _data.circleLabelValue) {
      _controller.stop();
    }

    canvas.restore();

    _data.circleForwardFlg
        ? colorSet = _data.circleColorList[baseAnimationValueIndex]
        : colorSet = _data.circleColorList[_controller.isAnimating
            ? baseAnimationValueIndex
            : circleLabelValue];

    Paint paint = Paint()
      ..strokeWidth = _data.circleStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..shader = SweepGradient(colors: colorSet).createShader(
          Rect.fromCircle(center: size.center(Offset.zero), radius: 0));
    canvas.rotate(degToRad(_rotate));
    canvas.translate(-size.width, 0);

    if (_controller.status == AnimationStatus.completed) {
      canvas.drawArc(
          Rect.fromCircle(
              center: size.center(Offset.zero), radius: size.width / 2),
          _startAngle,
          (pi * 2 * value),
          false,
          paint);
    } else {
      canvas.drawArc(
          Rect.fromCircle(
              center: size.center(Offset.zero), radius: size.width / 2),
          _startAngle,
          _controller.isAnimating
              ? (pi * 2) * _animation.value
              : ((pi * 2) * reverseValue),
          false,
          paint);
    }
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
