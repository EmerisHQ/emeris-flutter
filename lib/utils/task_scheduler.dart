import 'dart:async';

class TaskScheduler {
  Future<void> schedule(Duration duration, FutureOr Function() task) async {
    await Future.delayed(duration);
    return await task();
  }
}
