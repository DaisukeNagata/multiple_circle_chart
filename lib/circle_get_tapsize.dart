import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'circle_data_item.dart';

/// CircleOuterFrame is a class that sets the first week of a pie chart.
class CircleGetTapSize extends CustomPainter {
  final CircleDataItem _data;
  final circlePI = 360;
  final circleCheckData = 270;
  final circleComplement = 90;
  CircleGetTapSize(this._data);

  @override
  void paint(Canvas canvas, Size size) {}

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
          debugPrint(value.toString());
          debugPrint(i.toString());
        }
      }
    } else {
      var value =
          ((r * circlePI / (2 * math.pi)).floor() - circleCheckData) / circlePI;
      for (var i = 0; i < (_data.startValue?.length ?? 0); i++) {
        if ((_data.startValue?[i] ?? 0) < value &&
            (_data.startValue?[i] ?? 0) + (_data.endValue?[i] ?? 0) > value) {
          debugPrint(value.toString());
          debugPrint(i.toString());
        }
      }
    }
  }

  var count = -1;

  /// It reacts twice.
  @override
  bool hitTest(Offset position) {
    switch (count) {
      case -1:
        angel(
            Size.zero,
            Size(position.dx - _data.circleSizeValue / 2,
                position.dy - _data.circleSizeValue / 2));
        break;
      case 2:
        count = 0;
        angel(
            Size.zero,
            Size(position.dx - _data.circleSizeValue / 2,
                position.dy - _data.circleSizeValue / 2));
        break;
    }
    count += 1;
    return true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
