import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'overlapping_data.dart';

/// Abstract model class
abstract class OverlappingIndicator extends StatefulWidget {
  const OverlappingIndicator({
    Key? key,
    this.globalKey,
    this.dataVerticalOffset,
    this.dataHorizontalOffset,
    this.dataVerticalSize,
    this.dataHorizontalSize,
    this.semanticsLabel,
    this.semanticsValue,
    this.contextSize,
    this.circleData,
    this.animationValue,
    this.radData,
    this.setPaint,
    required this.textSpan,
    required this.con,
    required this.streamController,
  }) : super(key: key);
  final GlobalKey? globalKey;
  final Offset? dataVerticalOffset;
  final Offset? dataHorizontalOffset;
  final Size? dataVerticalSize;
  final Size? dataHorizontalSize;
  final String? semanticsLabel;
  final String? semanticsValue;
  final Size? contextSize;
  final double? animationValue;
  final CircleData? circleData;
  final RadData? radData;
  final CustomPaint? setPaint;
  final TextSpan? textSpan;
  final BuildContext con;
  final StreamController<Offset> streamController;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', animationValue,
        showName: false, ifNull: '<indeterminate>'));
  }
}
