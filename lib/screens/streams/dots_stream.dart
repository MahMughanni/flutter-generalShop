import 'dart:async';

import 'package:flutter_generalshop/contracts/contracts.dart';

class DotsStream implements Disposable {
  StreamController<int> _dotsStreamController =
      StreamController<int>.broadcast();

  Stream<int> get dots => _dotsStreamController.stream;

  StreamSink<int> get dotsSink => _dotsStreamController.sink;

  int currentDot;

  DotsStream() {
    _dotsStreamController.add(currentDot);
    _dotsStreamController.stream.listen(_indexChange);
  }

  void _indexChange(int index) {
    currentDot = index;
    _dotsStreamController.add(currentDot);
  }

  @override
  void dispose() {
    _dotsStreamController.close();
  }
}
