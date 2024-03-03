import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/foundation.dart';

import 'distributor.dart';
import 'index.dart';

final class DuitWorkerPoolConfiguration extends WorkerPoolConfiguration {
  final TaskDistributionPolicy policy;

  DuitWorkerPoolConfiguration({
    required super.workerCount,
    required this.policy,
  });
}

final class DuitWorkerPool implements WorkerPool {
  late final Distributor _distributor;
  @override
  bool initialized = false;
  final _workers = <DuitWorker>[];

  // final Finalizer<DuitWorkerPool> _workerPoolFinalizer =
  //     Finalizer((wp) => wp.close());

  @override
  Future<Object?> perform(Task task) async {
    return await _distributor.distributeTask(_workers, task);
  }

  void close() {
    for (var worker in _workers) {
      worker.close();
    }
    // _workerPoolFinalizer.detach(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> initWithConfiguration(
    WorkerPoolConfiguration configuration,
  ) async {
    final config = configuration as DuitWorkerPoolConfiguration;
    if (!initialized) {
      for (var i = 0; i < config.workerCount; i++) {
        try {
          _workers.add(await DuitWorker.spawn());
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      _distributor = switch (config.policy) {
        TaskDistributionPolicy.sequential => SequentialDistributor(),
        //TODO: implement rr and lc distributors
        TaskDistributionPolicy.roundRobin ||
        TaskDistributionPolicy.leastConnection =>
          throw UnimplementedError(),
      };

      initialized = true;
      // _workerPoolFinalizer.attach(this, this, detach: this);
    } else {
      debugPrint("WorkerPool already initialized");
    }
  }
}
