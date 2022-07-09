import 'package:flutter/widgets.dart';

class OverLappingLineSmoothPainter extends CustomPainter {
  OverLappingLineSmoothPainter({
    required this.originX,
    required this.height,
    required this.width,
    required this.paintSet,
    required this.data,
    required this.controller,
    required this.count,
  });

  final double originX;
  final double height;
  final double width;
  final Paint paintSet;
  final List<double> data;
  final AnimationController controller;
  final int count;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = paintSet;
    Path path = Path();
    path.moveTo(originX, data[0]);
    var c = count == 0 ? 1 : count - 1;
    var value = 16;
    for (var i = 0; i <= c; i++) {
      var beforeValue = (i == 0 ? 0 : i - 1);
      var nowValue = i;
      var afterValue =
          (nowValue >= data.length - 1 ? data.length - 1 : nowValue + 1);
      var w = (width * beforeValue + originX);
      var w2 = (width * nowValue + originX);
      path.cubicTo(
        w,

        /// same
        data[nowValue] == data[beforeValue]
            ? data[beforeValue]

            ///v
            : data[nowValue] > data[beforeValue] &&
                    data[nowValue] > data[afterValue]
                ? data[beforeValue] + originX / value

                ///^
                : data[nowValue] < data[beforeValue] &&
                        data[nowValue] < data[afterValue]
                    ? data[beforeValue] - originX / value
                    : data[beforeValue],

        ///v
        w2,

        /// same
        data[nowValue] == data[beforeValue]
            ? data[nowValue]

            ///V
            : data[nowValue] > data[beforeValue] &&
                    data[nowValue] > data[afterValue]
                ? data[nowValue] + originX / value

                ///^
                : data[nowValue] < data[beforeValue] &&
                        data[nowValue] < data[afterValue]
                    ? data[nowValue] - originX / value
                    : data[nowValue],
        w2,
        data[nowValue],
      );
    }
    canvas.drawPath(path, paint);

    var x = originX + width * c;
    var y = data[count == 0 ? 1 : count - 1];
    var x2 = originX + width * count;
    var y2 = data[count];
    var drawLineX = 0.0;
    var drawLineY = 0.0;

    if (x >= x2) {
      drawLineX = x + ((x - x2) * controller.value);
    } else {
      drawLineX = x + ((x2 - x) * controller.value);
    }

    if (y == y2) {
      drawLineY = y2;
    } else if (y >= y2) {
      drawLineY = y - ((y - y2) * controller.value);
    } else {
      drawLineY = y + ((y2 - y) * controller.value);
    }
    canvas.drawLine(Offset(x, y), Offset(drawLineX, drawLineY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
