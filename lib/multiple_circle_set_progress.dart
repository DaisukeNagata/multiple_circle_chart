import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/circle_text_painter.dart';

import 'circle_base_circumference.dart';
import 'circle_combined_chart.dart';
import 'circle_data_item.dart';
import 'circle_inner_frame.dart';
import 'circle_innermost_frame.dart';
import 'circle_outer_frame.dart';

/// It is a class that overlaps the initialization of the speed setting controller and the circle.
class MultipleCircleSetProgress extends StatefulWidget {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  const MultipleCircleSetProgress({Key? key, required this.circle})
      : super(key: key);

  final CircleDataItem circle;

  @override
  State<MultipleCircleSetProgress> createState() =>
      _MultipleCircleSetProgressState();
}

class _MultipleCircleSetProgressState extends State<MultipleCircleSetProgress>
    with TickerProviderStateMixin {
  late AnimationController _innerController;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _baseAnimation;

  @override
  void initState() {
    super.initState();

    /// When issuing a stream, select the direction of the speed setting and play it.
    widget.circle.circleController.stream.listen((event) async {
      List<double> eventSet = event;
      switch (widget.circle.circleForwardFlg) {

        /// Positive direction.
        case true:

          /// Judging the change in speed.
          if (_innerController.isAnimating &&
              widget.circle.circleSpeedCounterValue == eventSet.first &&
              widget.circle.circleLabelSpeedValue == eventSet.last) {
            _innerController.forward();
            _controller.forward();
          } else {
            /// Redefining speed.
            widget.circle.circleSpeedCounterValue = eventSet.first;
            _baseAnimation = Tween(begin: 0.0, end: eventSet.first)
                .animate(_innerController);

            _animation = Tween(begin: -1.0, end: eventSet.first - 1.0)
                .animate(_controller);

            _innerController.duration =
                Duration(milliseconds: widget.circle.circleDuration);

            _controller.duration =
                Duration(milliseconds: widget.circle.circleDuration);

            widget.circle.circleLabelValue = 0;

            ///　Calculation of starting point
            double speed = (widget.circle.circleLabelSpeedValue ?? 0) /
                (widget.circle.circleCounterValue ?? 0);

            _innerController.forward(from: speed);

            _controller.forward(from: speed);
          }
          break;

        /// Reverse direction
        case false:
          _innerController.duration =
              Duration(milliseconds: widget.circle.circleDuration);

          _controller.duration =
              Duration(milliseconds: widget.circle.circleDuration);

          _innerController.reverse();

          _controller.reverse();
      }
    });

    durationAnimation(0, 0.0, 0.0, 0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final constraintsSize = Size(constraints.maxWidth, constraints.maxHeight);
      return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext ctx, Widget? child) {
            return Stack(
              children: [
                /// Base circle.
                RepaintBoundary(
                  child: CustomPaint(
                    size: constraintsSize,
                    painter: CircleBaseCircumference([
                      widget.circle.circleRoundColor,
                      widget.circle.circleRoundColor
                    ], widget.circle.circleStrokeWidth),

                    /// 1st week yen.
                    child: RepaintBoundary(
                      child: CustomPaint(
                        size: constraintsSize,
                        painter: (widget.circle.startValue?.length ?? 0) > 0
                            ? CircleCombinedChart(widget.circle)
                            : CircleOuterFrame(_innerController,
                                _baseAnimation.value, widget.circle),

                        /// Yen after the first week
                        child: RepaintBoundary(
                          child: CustomPaint(
                            size: constraintsSize,
                            painter: CircleInnerFrame(
                                _innerController,
                                _animation,
                                _baseAnimation.value,
                                widget.circle),
                            child: widget.circle.circleShader ==
                                        CircleShader.round ||
                                    widget.circle.circleShader ==
                                        CircleShader.circleNone
                                ? RepaintBoundary(
                                    ///　The purpose of complementing the top price.
                                    child: CustomPaint(
                                      size: constraintsSize,
                                      painter: CircleInnermostFrame(
                                          _controller,
                                          _animation,
                                          _baseAnimation.value,
                                          widget.circle),
                                      child: RepaintBoundary(
                                        child: CustomPaint(
                                          size: constraintsSize,
                                          painter:
                                              CircleTextPainter(widget.circle),
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    });
  }

  /// Initialization registration as a method
  void durationAnimation(
      int duration1, double begin, double end, double begin2, double end2) {
    widget.circle.circlePointerValue = widget.circle.circleStrokeWidth / 2;
    _innerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration1),
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration1),
    );

    _baseAnimation = Tween(begin: begin, end: end).animate(_innerController);

    _animation = Tween(begin: begin2, end: end2).animate(_innerController);
  }
}
