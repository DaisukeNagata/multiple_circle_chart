import 'dart:async';

class CircleProgressController {
  StreamController<List<double>> controller = StreamController<List<double>>();
  StreamController<double> counter = StreamController<double>();

  Stream<List<double>> get stream => controller.stream;

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
}
