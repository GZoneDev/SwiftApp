import 'dart:async';

abstract interface class TimerService {
  Future<void> wait(int seconds);
  Future<void> stop();
  Stream<int> get stream;
  bool get isWaiting;
}
