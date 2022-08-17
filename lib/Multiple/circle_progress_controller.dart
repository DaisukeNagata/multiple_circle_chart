import 'dart:async';

class CircleProgressController {
  StreamController<List<double>> controller = StreamController<List<double>>();
  StreamController<double> counter = StreamController<double>();
  StreamController<List<dynamic>> circleIndex =
      StreamController<List<dynamic>>();

  /// Set the start and end positions.
  Stream<List<double>> get stream => controller.stream;

  /// Display value in circle
  Stream<double> get counterStream => counter.stream;

  void setProgress(List<double> progress) {
    controller.sink.add(progress);
  }

  void setCounter(double value) {
    counter.sink.add(value);
  }

  closed() {
    controller.close();
  }

  counterClosed() {
    counter.close();
  }

  void setIndex(List<dynamic> index) {
    circleIndex.sink.add(index);
  }

  indexClosed() {
    circleIndex.close();
  }
}
