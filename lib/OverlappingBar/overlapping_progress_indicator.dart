import 'dart:async';

import 'package:flutter/material.dart';

import '../Multiple/multiple_info_dialog.dart';
import 'overlapping_data.dart';
import 'overlapping_indicator.dart';
import 'overlapping_painter.dart';

///　OverlappingProgressIndicator is a class that calculates UI other than graphs.
class OverlappingProgressIndicator extends OverlappingIndicator {
  const OverlappingProgressIndicator(
      {Key? key,
      RadData radData = RadData.horizontal,
      Offset? radDataRadDataVertical,
      Offset? radDataRadDataHorizontal,
      Size? dataVerticalSize,
      Size? dataHorizontalSize,
      Size? contextSize,
      this.minHeight,
      GlobalKey? globalKey,
      String? textValue,
      double? animationValue,
      TextSpan? textSpan,
      CustomPaint? setPaint,
      required BuildContext con,
      required StreamController<Offset> streamController})
      : assert(minHeight == null || minHeight > 0),
        super(
            key: key,
            radData: radData,
            globalKey: globalKey,
            dataVerticalOffset: radDataRadDataVertical,
            dataHorizontalOffset: radDataRadDataHorizontal,
            dataVerticalSize: dataVerticalSize,
            dataHorizontalSize: dataHorizontalSize,
            animationValue: animationValue,
            textSpan: textSpan,
            contextSize: contextSize,
            setPaint: setPaint,
            con: con,
            streamController: streamController);

  /// Calculations for painting TextSpan.
  OverlappingPainter? setPainter(String textValue, double value, int index,
      double scale, List<Color> colorList,
      {CircleData circleData = CircleData.none,
      Color? textColor = Colors.white}) {
    ///　Coordinates to display text
    Offset rV = dataVerticalOffset ?? const Offset(0, 0);
    Offset rH = dataHorizontalOffset ?? const Offset(0, 0);
    Offset offset = radData == RadData.vertical
        ? Offset(rV.dx, -rV.dy)
        : Offset(rH.dx, rH.dy);

    double w = contextSize?.width.roundToDouble() ?? 0.0;

    /// Show graph values
    final textSpan = TextSpan(children: <TextSpan>[
      TextSpan(
          text: textValue.substring(0, textValue.length),
          style: TextStyle(color: textColor)),
    ]);

    if (value >= 0) {
      /// Calling overlapping graphs.
      return OverlappingPainter(
          circleData: circleData,
          radData: radData,
          backgroundColor: colorList[index],
          offsetValue: offset,
          textSpan: textSpan,
          value: (animationValue ?? 0.0) - (value * 0.1 * scale),
          contextSize:
              Size(w * (value * 0.1 * scale), contextSize?.height ?? 0.0),
          controller: streamController);
    } else {
      return OverlappingPainter(
          circleData: circleData,
          radData: radData,
          backgroundColor: Colors.grey,
          offsetValue: offset,
          textSpan: textSpan,
          value: null,
          contextSize: const Size(0, 0),
          controller: streamController);
    }
  }

  /// bind the tap location.
  controllerStream() {
    streamController.stream.listen((event) {
      Offset offsetData = event;
      Offset stDataFirst = offsetData;
      showMyDialog(con, stDataFirst);
    });
  }

  /// Method to calculate alert.
  Future<void> showMyDialog(BuildContext context, Offset dataPosition) async {
    RenderBox box = globalKey?.currentContext?.findRenderObject() as RenderBox;
    double value = dataVerticalSize?.height ?? 0;
    double dx = dataPosition.dx;
    Size hSize = dataHorizontalSize ?? const Size(0, 0);
    Offset offset = box.localToGlobal(Offset.zero);
    Offset horizontalOffset =
        box.localToGlobal(dataVerticalOffset ?? const Offset(0, 0));

    return showDialog<void>(
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return MultipleInfoDialog(
          /// Make the background transparent.
          elevation: 0,

          /// The orientation determines the dialog coordinates.
          rect: RadData.horizontal == radData
              ? Rect.fromLTWH(offset.dx, offset.dy, box.size.width, value)
              : Rect.fromLTWH(
                  offset.dx, horizontalOffset.dy - dx, value, hSize.height),
          content: SingleChildScrollView(
              child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),

              /// Characters to be changed
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
    if (animationValue != null) {
      expandedSemanticsValue ??= '${(animationValue! * 100).round()}%';
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
      _OverlappingProgressState();
}

class _OverlappingProgressState extends State<OverlappingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );
    if (widget.animationValue == null) {
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

    if (widget.animationValue != null) {
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
