import 'package:duit_kernel/duit_kernel.dart';

import 'index.dart';

abstract class Distributor {
  Future<TaskResult> distributeTask(
    List<Worker> workers, {
    required TaskHandler fn,
    dynamic payload,
  });
}

final class RoundRobinDistributor extends Distributor {
  int currentIndex = 0;
  int? _ln;

  @override
  Future<TaskResult> distributeTask(
    List<Worker> workers, {
    required TaskHandler fn,
    dynamic payload,
  }) async {
    _ln ??= workers.length;

    if (_ln! - 1 == currentIndex) {
      final worker = workers[currentIndex].sendTaskToIsolate(fn, payload);
      currentIndex = 0;
      return await worker;
    }
    final worker = workers[currentIndex].sendTaskToIsolate(fn, payload);
    currentIndex++;
    return await worker;
  }
}
