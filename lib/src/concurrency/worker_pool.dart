import 'dart:async';

import 'package:flutter/foundation.dart';

import 'distributor.dart';
import 'index.dart';

final class WorkerPool {
  static final WorkerPool _instance = WorkerPool._internal();
  late final Distributor _distributor;
  final Finalizer<WorkerPool> _workerPoolFinalizer =
      Finalizer((wp) => wp.close());

  factory WorkerPool() {
    return _instance;
  }

  WorkerPool._internal();

  bool initialized = false;
  final _workers = <DuitWorker>[];

  Future<void> init(TaskDistributionPolicy policy) async {
    if (!initialized) {
      for (var i = 0; i < 4; i++) {
        try {
          _workers.add(await DuitWorker.spawn());
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      initialized = true;

      _distributor = switch (policy) {
        TaskDistributionPolicy.sequential => SequentialDistributor(),
        //TODO: implement rr and lc distributors
        TaskDistributionPolicy.roundRobin ||
        TaskDistributionPolicy.leastConnection =>
          throw UnimplementedError(),
      };

      _workerPoolFinalizer.attach(this, this);
    } else {
      debugPrint("WorkerPool already initialized");
    }
  }

  Future<Object?> run(Task task) async {
    return await _distributor.distributeTask(_workers, task);
  }

  void close() {
    for (var worker in _workers) {
      worker.close();
    }
  }
}
