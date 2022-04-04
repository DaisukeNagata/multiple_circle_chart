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
    this.value,
    this.radData,
    this.setPaint,
    required this.textSpan,
    required this.con,
    required this.stream,
  }) : super(key: key);
  final GlobalKey? globalKey;
  final Offset? dataVerticalOffset;
  final Offset? dataHorizontalOffset;
  final Size? dataVerticalSize;
  final Size? dataHorizontalSize;
  final String? semanticsLabel;
  final String? semanticsValue;
  final Size? contextSize;
  final double? value;
  final CircleData? circleData;
  final RadData? radData;
  final CustomPaint? setPaint;
  final TextSpan? textSpan;
  final BuildContext con;
  final StreamController stream;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value,
        showName: false, ifNull: '<indeterminate>'));
  }
}
