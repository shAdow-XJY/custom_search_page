import 'dart:async';

typedef DebounceCallback = void Function();

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void debounce(DebounceCallback callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }
}
