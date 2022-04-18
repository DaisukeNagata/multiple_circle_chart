import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'circle_data_item.dart';

/// CircleOuterFrame is a class that sets the first week of a pie chart.
class CircleGetData extends CustomPainter {
  final CircleDataItem _data;
  final circlePI = 360;
  final circleCheckData = 270;
  final circleComplement = 90;

  CircleGetData(this._data);

  @override
  void paint(Canvas canvas, Size size) {
    _data.circleTextIndex = 0;
  }

  angel(Size a, Size b) {
    var r = math.atan2(b.height - a.height, b.width - a.width);
    if (r < 0) {
      r = r + (2 * math.pi);
    }

    if ((r * circlePI / (2 * math.pi)) < circleCheckData) {
      var value = ((r * circlePI / (2 * math.pi)).floor() + circleComplement) /
          circlePI;
      for (var i = 0; i < (_data.startValue?.length ?? 0); i++) {
        if ((_data.startValue?[i] ?? 0) < value &&
            (_data.startValue?[i] ?? 0) + (_data.endValue?[i] ?? 0) > value) {
          _data.circleTextIndex = i;
          _data.circleController.circleIndex.sink
              .add(_data.circleTextList?[i] ?? "");
        }
      }
    } else {
      var value =
          ((r * circlePI / (2 * math.pi)).floor() - circleCheckData) / circlePI;
      for (var i = 0; i < (_data.startValue?.length ?? 0); i++) {
        if ((_data.startValue?[i] ?? 0) < value &&
            (_data.startValue?[i] ?? 0) + (_data.endValue?[i] ?? 0) > value) {
          _data.circleTextIndex = i;
          _data.circleController.circleIndex.sink
              .add(_data.circleTextList?[i] ?? "");
        }
      }
    }
  }

  var hitTestFlg = true;

  /// It reacts twice.
  @override
  bool hitTest(Offset position) {
    if (hitTestFlg) {
      double value = _data.circleSizeValue / 2;
      angel(Size.zero, Size(value, value));
      hitTestFlg = false;
    } else {
      hitTestFlg = true;
    }
    return true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
