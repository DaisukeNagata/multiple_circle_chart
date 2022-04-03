import 'dart:async';

class CircleProgressController {
  StreamController controller = StreamController();
  StreamController counter = StreamController();

  Stream get stream => controller.stream;

  Stream get counterStream => counter.stream;

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
