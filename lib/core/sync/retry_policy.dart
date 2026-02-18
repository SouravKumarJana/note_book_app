import 'dart:async';

class RetryPolicy {
  final int maxRetries;
  final Duration baseDelay;

  RetryPolicy({
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 2),
  });

  Future<T> execute<T>(Future<T> Function() task) async {
    int attempt = 0;

    while (true) {
      try {
        return await task();
      } catch (e) {
        attempt++;

        if (attempt >= maxRetries) rethrow;

        final delay = baseDelay * attempt;
        await Future.delayed(delay);
      }
    }
  }
}
