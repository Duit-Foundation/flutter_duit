import 'dart:async';
import 'dart:isolate';

import 'package:duit_kernel/duit_kernel.dart';

final class DuitWorker {
  final SendPort _sp;
  final ReceivePort _rp;
  final Isolate _isolate;
  final Map<Capability, Completer<Object?>> _activeRequests = {};
  bool _closed = false;

  Future<TaskResult> sendTaskToIsolate(
    TaskOperation fn,
    dynamic payload,
  ) async {
    if (_closed) throw StateError('Worker closed');

    final completer = Completer<TaskResult>.sync();
    final cap = Capability();

    final task = Task(
      func: fn,
      cap: cap,
      payload: payload,
    );

    _activeRequests[cap] = completer;

    _sp.send(task);
    return await completer.future;
  }

  static Future<DuitWorker> spawn() async {
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };

    Isolate isolate;

    try {
      isolate = await Isolate.spawn(_runIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return DuitWorker._(receivePort, sendPort, isolate);
  }

  DuitWorker._(
    this._rp,
    this._sp,
    this._isolate,
  ) {
    _rp.listen(_handleResponsesFromIsolate);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final response = message as TaskResult;
    final completer = _activeRequests.remove(response.cap)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _rp.close();
  }

  static void _handleCommandsToIsolate(
    ReceivePort receivePort,
    SendPort sendPort,
  ) {
    receivePort.listen((event) async {
      if (event is Task) {
        final fnRes = event.func(event.payload);
        final taskRes = TaskResult(fnRes, event.cap);
        sendPort.send(taskRes);
        return;
      }
      return;
    });
  }

  static void _runIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(
      receivePort,
      sendPort,
    );
  }

  void dispose() {
    if (!_closed) {
      _closed = true;
      if (_activeRequests.isEmpty) _rp.close();
      _isolate.kill();
    }
  }
}
