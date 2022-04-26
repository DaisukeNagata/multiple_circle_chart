import 'dart:async';

class CircleProgressController {
  StreamController<List<double>> controller = StreamController<List<double>>();
  StreamController<double> counter = StreamController<double>();
  StreamController<List<dynamic>> circleIndex =
      StreamController<List<dynamic>>();

  Stream<List<double>> get stream => controller.stream;

  Stream<double> get counterStream => counter.stream;

  Stream<List<dynamic>> get circleIndexStream => circleIndex.stream;

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
