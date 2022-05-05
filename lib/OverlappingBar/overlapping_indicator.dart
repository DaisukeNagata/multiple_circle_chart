import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'overlapping_data.dart';

/// Abstract model class
abstract class OverlappingIndicator extends StatefulWidget {
  const OverlappingIndicator(
      {Key? key,
      this.globalKey,
      this.semanticsLabel,
      this.semanticsValue,
      this.contextSize,
      this.graphCount,
      this.circleData,
      this.animationValue,
      this.radData,
      this.setPaint,
      this.scale,
      this.boxSize,
      this.navigationHeight,
      required this.textSpan,
      required this.con,
      required this.dialogData,
      required this.streamController})
      : super(key: key);
  final GlobalKey? globalKey;
  final String? semanticsLabel;
  final String? semanticsValue;
  final Size? contextSize;
  final int? graphCount;
  final double? animationValue;
  final CircleData? circleData;
  final RadData? radData;
  final CustomPaint? setPaint;
  final double? scale;
  final double? boxSize;
  final double? navigationHeight;
  final TextSpan? textSpan;
  final BuildContext con;
  final List<String> dialogData;
  final StreamController<List<dynamic>> streamController;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', animationValue,
        showName: false, ifNull: '<indeterminate>'));
  }
}
