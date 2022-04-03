import 'dart:math';
import 'circle_data_item.dart';
import 'package:flutter/material.dart';

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

    int baseAnimationValueIndex = _baseAnimationValue.floor() - 1;

    int circleLabelValue =
        _data.circleLabelValue.floor() == _data.circleColorList.length
            ? _data.circleLabelValue.floor() - 1
            : _data.circleLabelValue.floor();

    double sizeSet = size.width / 2;

    double progressSet = pi * 2 * time;

    double translate = -size.width;

    List<Color> colorSet;

    canvas.rotate(degToRad(_rotate));

    canvas.translate(translate, 0);

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

    colorSet = _data.circleColorList[
        baseAnimationValueIndex <= 0 ? 0 : baseAnimationValueIndex];

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
