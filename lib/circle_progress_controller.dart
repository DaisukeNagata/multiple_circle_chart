import 'dart:async';

class CircleProgressController {
  StreamController<List<double>> controller = StreamController<List<double>>();
  StreamController<double> counter = StreamController<double>();
  StreamController<String> circleIndex = StreamController<String>();

  Stream<List<double>> get stream => controller.stream;

  Stream<double> get counterStream => counter.stream;

  Stream<String> get circleIndexStream => circleIndex.stream;

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

  void setIndex(String index) {
    circleIndex.sink.add(index);
  }

  indexClosed() {
    circleIndex.close();
  }
}
