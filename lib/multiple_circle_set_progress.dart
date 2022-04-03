import 'package:flutter/material.dart';
import 'circle_base_circumference.dart';
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

            var a = widget.circle.circleLabelSpeedValue /
                widget.circle.circleCounterValue;

            _innerController.forward(from: a);

            _controller.forward(from: a);
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
                RepaintBoundary(
                  child: CustomPaint(
                    size: constraintsSize,
                    painter: CircleBaseCircumference([
                      widget.circle.circleRoundColor,
                      widget.circle.circleRoundColor
                    ], widget.circle.circleStrokeWidth),
                    child: RepaintBoundary(
                      child: CustomPaint(
                        size: constraintsSize,
                        painter: CircleOuterFrame(_innerController,
                            _baseAnimation.value, widget.circle),
                        child: RepaintBoundary(
                          child: CustomPaint(
                            size: constraintsSize,
                            painter: InnerCircle(_innerController, _animation,
                                _baseAnimation.value, widget.circle),
                            child: widget.circle.circleShader ==
                                        CircleShader.round ||
                                    widget.circle.circleShader ==
                                        CircleShader.circleNone
                                ? RepaintBoundary(
                                    child: CustomPaint(
                                        size: constraintsSize,
                                        painter: InnermostCircle(
                                            _controller,
                                            _animation,
                                            _baseAnimation.value,
                                            widget.circle)),
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
