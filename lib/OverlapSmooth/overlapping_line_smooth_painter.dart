import 'dart:ui';

import 'package:flutter/widgets.dart';

class OverLappingLineSmoothPainter extends CustomPainter {
  OverLappingLineSmoothPainter({
    required this.originX,
    required this.height,
    required this.width,
    required this.paintSet,
    required this.data,
    required this.controller,
    required this.arcFlg,
  });

  final double originX;
  final double height;
  final double width;
  final Paint paintSet;
  final List<double> data;
  final AnimationController controller;
  final bool arcFlg;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = paintSet;
    Path path = Path();
    path.moveTo(originX, data[0]);
    var value = data.length;
    for (var i = 0; i < data.length; i++) {
      var beforeValue = (i <= 1 ? 0 : i - 1);
      var x = originX + width * beforeValue;
      var y = data[beforeValue];
      var x2 = arcFlg
          ? originX + width * (i % 2 == 0 ? i : beforeValue)
          : originX + width * i;
      var y2 = arcFlg ? data[(i % 2 == 0 ? i : beforeValue)] : data[i];
      var nowValue = i;
      var afterValue =
          (nowValue >= data.length - 1 ? data.length - 1 : nowValue + 1);
      path.cubicTo(
        x,

        /// same
        data[nowValue] == data[beforeValue]
            ? y

            ///v
            : data[nowValue] > data[beforeValue] &&
                    data[nowValue] > data[afterValue]
                ? y + originX / value

                ///^
                : data[nowValue] < data[beforeValue] &&
                        data[nowValue] < data[afterValue]
                    ? y - originX / value
                    : y,

        ///v
        x2,

        /// same
        data[nowValue] == data[beforeValue]
            ? y2

            ///V
            : data[nowValue] > data[beforeValue] &&
                    data[nowValue] > data[afterValue]
                ? y2 + originX / value

                ///^
                : data[nowValue] < data[beforeValue] &&
                        data[nowValue] < data[afterValue]
                    ? y2 - originX / value
                    : y2,
        x2,
        y2,
      );
    }
    canvas.drawCircle(_calculate(controller.value, path), 2, paint);

    var metricsIterator = path.computeMetrics().iterator;
    if (metricsIterator.moveNext()) {
      Path pathArc = Path();
      var metric = metricsIterator.current;
      final pathSegment =
          metric.extractPath(0.0, metric.length * controller.value);
      pathArc.addPath(pathSegment, Offset.zero);
      canvas.drawPath(pathArc, paint);
    }
  }

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
