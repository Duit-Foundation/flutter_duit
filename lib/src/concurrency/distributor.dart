import 'package:duit_kernel/duit_kernel.dart';

import 'index.dart';

abstract class Distributor {
  Future<Object?> distributeTask(List<DuitWorker> workers, Task task);
}

final class SequentialDistributor extends Distributor {
  int currentIndex = 0;
  int? _ln;

  @override
  Future<Object?> distributeTask(List<DuitWorker> workers, Task task) async {
    _ln ??= workers.length;

    if (_ln! - 1 == currentIndex) {
      currentIndex = 0;
      return await workers[currentIndex].sendTaskToIsolate(task);
    }
    final worker = workers[currentIndex];
    currentIndex++;
    return await worker.sendTaskToIsolate(task);
  }
}
