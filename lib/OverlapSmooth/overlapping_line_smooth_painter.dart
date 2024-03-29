import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///　parabola graph design
///　Calculate the area of ​​path.
///  Stores the region of path in an array with X and Y axes.
class OverLappingLineSmoothPainter extends CustomPainter {
  OverLappingLineSmoothPainter({
    required this.originX,
    required this.height,
    required this.width,
    required this.circleValue,
    required this.paintSet,
    required this.data,
    required this.controller,
    required this.arcFlg,
  });

  final double originX;
  final double height;
  final double width;
  final double circleValue;
  final Paint paintSet;
  final List<double> data;
  final AnimationController controller;
  final bool arcFlg;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = paintSet;

    ///　The value of the graph position is set in data.
    Path path = Path()..moveTo(originX, data[0]);
    var paintCircle = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;
    var i = 0;

    /// I'm trying to set a non-null value in where.
    data.where((double? value) => value != null).toList().forEach((value) {
      var beforeValue = (i <= 1 ? 0 : i - 1);
      var x = originX + width * beforeValue;
      var y = data[beforeValue];
      var x2 = arcFlg
          ? originX + width * (i.isEven ? i : beforeValue)
          : originX + width * i;
      var y2 = arcFlg ? data[(i.isEven ? i : beforeValue)] : value;
      var nowValue = i;

      ///　Calculate future values.
      var afterValue =
          (nowValue >= data.length - 1 ? data.length - 1 : nowValue + 1);

      /// Calculate the curve values.
      path.cubicTo(
        x,

        /// same
        value == data[beforeValue]
            ? y

            ///v
            : value > data[beforeValue] && value > data[afterValue]
                ? y + originX / value

                ///^
                : value < data[beforeValue] && value < data[afterValue]
                    ? y + originX / value
                    : y,

        ///v
        x2,

        /// same
        value == data[beforeValue]
            ? y2

            ///V
            : value > data[beforeValue] && value > data[afterValue]
                ? y2 + originX / value

                ///^
                : value < data[beforeValue] && value < data[afterValue]
                    ? y2 + originX / value
                    : y2,
        x2,
        y2,
      );

      ///　A calculated value is given after the animation is completed.
      if (controller.isCompleted) {
        canvas.drawCircle(Offset(x2, y2), circleValue, paintCircle);
      }
      i++;
    });
    canvas.drawCircle(
      _calculate(controller.value, path),
      circleValue,
      paintCircle,
    );

    var metricsIterator = path.computeMetrics().iterator;

    ///　Draw path dynamically.
    if (metricsIterator.moveNext()) {
      Path pathArc = Path();
      var metric = metricsIterator.current;
      final pathSegment =
          metric.extractPath(0.0, metric.length * controller.value);
      pathArc.addPath(pathSegment, Offset.zero);
      canvas.drawPath(pathArc, paint);
    }
  }

  ///　Get the value of path.
  Offset _calculate(double value, Path path) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos?.position ?? const Offset(0, 0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
