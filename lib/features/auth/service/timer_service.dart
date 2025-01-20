import 'dart:async';

abstract interface class ITimer {
  Future<void> wait(int seconds);
  Future<void> stop();
  Stream<int> get stream;
  bool get isWaiting;
}

class TimerService implements ITimer {
  StreamController<int>? _timerController;
  Timer? _timer;

  TimerService();

  Future<void> _startTimer(int remainingSeconds) async {
    _timerController = StreamController<int>.broadcast();

    _timerController!.add(remainingSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        _timerController!.add(--remainingSeconds);
      } else {
        timer.cancel();
        _timerController?.close();
      }
    });
  }

  @override
  Future<void> wait(int seconds) async {
    if (_timerController != null && !_timerController!.isClosed) {
      throw Exception('Timer is already running');
    }

    await _startTimer(seconds);
  }

  @override
  Future<void> stop() async {
    _timer?.cancel();
    _timerController?.close();
    _timerController = null;
  }

  @override
  Stream<int> get stream {
    if (_timerController == null) {
      throw Exception('Timer is not initialized');
    }
    return _timerController!.stream;
  }

  @override
  bool get isWaiting => _timerController != null && !_timerController!.isClosed;
}
