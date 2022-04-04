import 'dart:async';
import 'package:flutter/material.dart';

import 'overlapping_data.dart';
import 'overlapping_indicator.dart';
import 'overlapping_info_dialog.dart';
import 'overlapping_painter.dart';

class OverlappingProgressIndicator<T> extends OverlappingIndicator {
  OverlappingProgressIndicator(
      {Key? key,
      RadData radData = RadData.horizontal,
      Offset? radDataRadDataVertical,
      Offset? radDataRadDataHorizontal,
      Size? dataVerticalSize,
      Size? dataHorizontalSize,
      GlobalKey? globalKey,
      String? textValue,
      TextSpan? textSpan,
      double? value,
      this.minHeight,
      Size? contextSize,
      CustomPaint? setPaint,
      required BuildContext con,
      required StreamController stream})
      : assert(minHeight == null || minHeight > 0),
        super(
            key: key,
            radData: radData,
            globalKey: globalKey,
            dataVerticalOffset: radDataRadDataVertical,
            dataHorizontalOffset: radDataRadDataHorizontal,
            dataVerticalSize: dataVerticalSize,
            dataHorizontalSize: dataHorizontalSize,
            textSpan: textSpan,
            value: value,
            contextSize: contextSize,
            setPaint: setPaint,
            con: con,
            stream: stream);

  OverlappingPainter? setPainter(String textValue, count, scale, colorList,
      {CircleData circleData = CircleData.none,
      Color? textColor = Colors.white}) {
    Offset rV = dataVerticalOffset ?? const Offset(0, 0);
    Offset rH = dataHorizontalOffset ?? const Offset(0, 0);
    Offset offset = radData == RadData.vertical
        ? Offset(rV.dx, -rV.dy)
        : Offset(rH.dx, rH.dy);

    double w = contextSize?.width.roundToDouble() ?? 0.0;

    final textSpan = TextSpan(children: <TextSpan>[
      TextSpan(
          text: textValue.substring(0, textValue.length),
          style: TextStyle(color: textColor)),
    ]);

    if (count >= 0) {
      return OverlappingPainter(
          circleData: circleData,
          radData: radData,
          backgroundColor: colorList[count],
          offsetValue: offset,
          textSpan: textSpan,
          value: ((value ?? 0.0)) - (count * 0.1 * scale),
          contextSize:
              Size((w * count * 0.1) * scale, contextSize?.height ?? 0.0),
          controller: stream);
    } else {
      return OverlappingPainter(
          circleData: circleData,
          radData: radData,
          backgroundColor: Colors.grey,
          offsetValue: offset,
          textSpan: textSpan,
          value: null,
          contextSize: const Size(0, 0),
          controller: stream);
    }
  }

  controllerStream() {
    stream.stream.listen((event) {
      var stData = event as List<T>;
      var stDataFirst = stData.first as Offset;
      var stDataLast = stData.last as OverlappingPainter;
      showMyDialog(con, stDataFirst, stDataLast);
    });
  }

  Future<void> showMyDialog(BuildContext context, Offset dataPosition,
      OverlappingPainter painter) async {
    RenderBox box = globalKey?.currentContext?.findRenderObject() as RenderBox;
    double value = dataVerticalSize?.height ?? 0;
    double dx = dataPosition.dx;
    Size hSize = dataHorizontalSize ?? const Size(0, 0);
    Offset offset = box.localToGlobal(Offset.zero);
    Offset size2 = box.localToGlobal(dataVerticalOffset ?? Offset(0, 0));

    return showDialog<void>(
      barrierColor: painter.backgroundColor.withOpacity(0),
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return OverlappingInfoDialog(
          elevation: 0,
          rect: RadData.horizontal == radData
              ? Rect.fromLTWH(offset.dx, offset.dy, box.size.width, value)
              : Rect.fromLTWH(offset.dx, size2.dy - dx, value, hSize.height),
          content: SingleChildScrollView(
              child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text("size:${dx.toStringAsFixed(1)}"),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')),
            ],
          )),
        );
      },
    );
  }

  final double? minHeight;

  Widget buildSemanticsWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    String? expandedSemanticsValue = semanticsValue;
    if (value != null) {
      expandedSemanticsValue ??= '${(value! * 100).round()}%';
    }
    controllerStream();
    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }

  @override
  State<OverlappingProgressIndicator> createState() =>
      _LinearProgressIndicatorState2();
}

class _LinearProgressIndicatorState2 extends State<OverlappingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, double animationValue,
      TextDirection textDirection) {
    final ProgressIndicatorThemeData indicatorTheme =
        ProgressIndicatorTheme.of(context);
    final double minHeight =
        widget.minHeight ?? indicatorTheme.linearMinHeight ?? 4.0;

    return widget.buildSemanticsWrapper(
      context: context,
      child: Container(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: minHeight,
          ),
          child: widget.setPaint),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);

    if (widget.value != null) {
      return _buildIndicator(context, _controller.value, textDirection);
    }

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return _buildIndicator(context, _controller.value, textDirection);
      },
    );
  }
}
