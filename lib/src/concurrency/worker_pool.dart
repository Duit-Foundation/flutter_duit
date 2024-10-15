import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/foundation.dart';

import 'distributor.dart';
import 'index.dart';

@Deprecated("Will be removed in next major version")
final class DuitWorkerPoolConfiguration extends WorkerPoolConfiguration {
  final TaskDistributionPolicy policy;

  DuitWorkerPoolConfiguration({
    required super.workerCount,
    required this.policy,
  });
}

final class _WorkerPoolFinalizationController {
  final WorkerPool p;

  _WorkerPoolFinalizationController(this.p);

  void dispose() {
    p.dispose();
  }
}

@Deprecated("Will be removed in next major version")
final class DuitWorkerPool extends WorkerPool {
  late final Distributor _distributor;
  final _workers = <Worker>[];

  final Finalizer<_WorkerPoolFinalizationController> _workerPoolFinalizer =
      Finalizer((wp) => wp.dispose());

  @override
  void dispose() {
    for (var worker in _workers) {
      worker.dispose();
    }
    _workerPoolFinalizer.detach(this);
  }

  @override
  Future<TaskResult> perform(TaskHandler func, dynamic payload) async {
    return await _distributor.distributeTask(
      _workers,
      fn: func,
      payload: payload,
    );
  }

  @override
  Future<void> initWithConfiguration(
    WorkerPoolConfiguration configuration,
  ) async {
    final config = configuration as DuitWorkerPoolConfiguration;
    if (!initialized) {
      for (var i = 0; i < config.workerCount; i++) {
        try {
          _workers.add(await Worker.spawn());
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      _distributor = switch (config.policy) {
        TaskDistributionPolicy.roundRobin => RoundRobinDistributor(),
        TaskDistributionPolicy.leastConnection => throw UnimplementedError(),
      };

      _workerPoolFinalizer.attach(
        this,
        _WorkerPoolFinalizationController(this),
        detach: this,
      );
      initialized = true;
    } else {
      debugPrint("WorkerPool already initialized");
    }
  }
}
