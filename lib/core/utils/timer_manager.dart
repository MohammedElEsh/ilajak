import 'dart:async';

class TimerManager {
  Timer? _timer;
  final StreamController<int> _controller = StreamController<int>.broadcast();

  Stream<int> get tick => _controller.stream;

  void start(int seconds) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick >= seconds) {
        timer.cancel();
      }
      _controller.add(seconds - timer.tick);
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
