import 'package:flutter/widgets.dart';

class OverLappingLineSmoothPainter extends CustomPainter {
  OverLappingLineSmoothPainter({
    required this.originX,
    required this.height,
    required this.width,
    required this.paintSet,
    required this.data,
  });

  final double originX;
  final double height;
  final double width;
  final Paint paintSet;
  final List<double> data;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = paintSet;

    Path path = Path();
    path.moveTo(originX, data[0]);
    var value = data.length;
    for (var i = 0; i < data.length; i++) {
      var beforeValue = (i == 0 ? 0 : i - 1);
      var nowValue = i;
      var afterValue =
          (nowValue >= data.length - 1 ? data.length - 1 : nowValue + 1);
      var w = (width * beforeValue + originX);
      var w2 = (width * nowValue + originX);
      path.cubicTo(
          i == 0
              ? w
              :

              /// decent
              data[nowValue] > data[beforeValue] &&
                      data[nowValue] > data[afterValue]
                  ? w + originX / value

                  /// rise
                  : data[nowValue] < data[beforeValue] &&
                          data[nowValue] < data[afterValue]
                      ? w + originX / value
                      : w,

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
          data[nowValue] > data[beforeValue] &&
                  data[nowValue] > data[afterValue]
              ? w2 + originX / value

              ///^
              : data[nowValue] < data[beforeValue] &&
                      data[nowValue] < data[afterValue]
                  ? w2 + originX / value
                  : w2,

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
          data[nowValue]);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
