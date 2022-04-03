import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'circle_data_item.dart';
import 'dart:math' as math;
import 'dart:math';

class InnermostCircle extends CustomPainter {
  final AnimationController _controller;
  final Animation<double> _animation;
  final double _baseAnimationValue;
  final CircleDataItem _data;
  final double _rotate = 270;

  InnermostCircle(
      this._controller, this._animation, this._baseAnimationValue, this._data);

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.restore();

    List<Color> shaderColor;

    double sizeSet = size.width / 2;

    double time = double.parse(_baseAnimationValue.toString());

    int baseAnimationValueIndex =
        _baseAnimationValue.floor() == _data.circleColorList.length
            ? _baseAnimationValue.floor() - 1
            : _baseAnimationValue.floor();

    int circleLabelValue =
        _data.circleLabelValue.floor() == _data.circleColorList.length
            ? _data.circleLabelSpeedValue.floor() - 1
            : _data.circleLabelSpeedValue.floor();

    double circleValue = _data.circleForwardFlg
        ? _data.circleCounterValue - _data.circleCounterValue.floor()
        : _data.circleLabelSpeedValue - _data.circleLabelSpeedValue.floor();

    Offset center = Offset(sizeSet, sizeSet);

    if (_controller.status == AnimationStatus.dismissed ||
        _controller.status == AnimationStatus.completed ||
        time != 0.0 && time <= _data.circleLabelValue) {
      _controller.stop();
    }
    canvas.rotate(degToRad(_rotate));

    canvas.translate(-size.width, 0);

    _data.circleForwardFlg
        ? shaderColor = _data.circleColorList[baseAnimationValueIndex]
        : shaderColor = _data.circleColorList[_controller.isAnimating
            ? baseAnimationValueIndex
            : circleLabelValue];

    double animationValue = _baseAnimationValue - _baseAnimationValue.floor();

    Paint circlePainter = Paint()
      ..strokeWidth = _data.circleStrokeWidth
      ..style = PaintingStyle.fill
      ..color = _data.circleColor
      ..strokeCap = StrokeCap.round;

    if (_data.circleShader == CircleShader.round) {
      if (_data.circleDuration == 0 || !_controller.isAnimating) {
        circlePainter.shader = SweepGradient(
                colors: circleValue == 0
                    ? [
                        shaderColor.first.withOpacity(0),
                        shaderColor.last.withOpacity(0)
                      ]
                    : circleValue > _data.complementCircle
                        ? [shaderColor.first, shaderColor.last]
                        : [shaderColor.first, shaderColor.last.withOpacity(0)])
            .createShader(
                Rect.fromCircle(center: size.center(Offset.zero), radius: 0));
      } else {
        circlePainter.shader = SweepGradient(
                colors: animationValue > _data.complementCircle
                    ? [shaderColor.first, shaderColor.last]
                    : circleValue == 0
                        ? [
                            shaderColor.first.withOpacity(0),
                            shaderColor.last.withOpacity(0)
                          ]
                        : [shaderColor.first, shaderColor.last.withOpacity(0)])
            .createShader(
                Rect.fromCircle(center: size.center(Offset.zero), radius: 0));
      }
    }

    Paint shadowPainter = Paint()
      ..strokeWidth = _data.circleStrokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.square
      ..color = _data.circleShader == CircleShader.circleNone
          ? _data.circleShadowColor
          : _data.circleShadowColor.withAlpha(0);

    double piCircle = 0.0;

    piCircle = time <= _data.circleLabelValue
        ? (pi * 2) * _data.circleLabelValue
        : piCircle = (pi * 2) * _animation.value;

    Offset circleOffset = Offset(
      sizeSet * math.cos(piCircle) + center.dx,
      sizeSet * math.sin(piCircle) + center.dy,
    );

    Offset shadowOffset = Offset(
      sizeSet * math.cos(piCircle + _data.circleShadowValue) + center.dx,
      sizeSet * math.sin(piCircle + _data.circleShadowValue) + center.dy,
    );

    if (_data.circleShader == CircleShader.circleNone) {
      canvas.drawCircle(shadowOffset, _data.circlePointerValue, shadowPainter);
    }

    // Minimum size when using round
    canvas.drawCircle(circleOffset, _data.circlePointerValue, circlePainter);

    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
