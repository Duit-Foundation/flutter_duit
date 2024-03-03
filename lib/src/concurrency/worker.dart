import 'dart:async';
import 'dart:isolate';

import 'package:duit_kernel/duit_kernel.dart';

import 'handler.dart';
import 'index.dart';

typedef IsolateCallback = void Function(Task? message);

class DuitWorker {
  final SendPort _sp;
  final ReceivePort _rp;
  final Map<int, Completer<Object?>> _activeRequests = {};
  bool _closed = false;
  int _idCounter = 0;

  Future<Object?> sendTaskToIsolate(Task task) async {
    if (_closed) throw StateError('Worker closed');
    final completer = Completer<Object?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    task.setTaskId(id);
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

    try {
      await Isolate.spawn(_runIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return DuitWorker._(receivePort, sendPort);
  }

  DuitWorker._(this._rp, this._sp) {
    _rp.listen(_handleResponsesFromIsolate);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final (int id, Object? response) = message as (int, Object?);
    final completer = _activeRequests.remove(id)!;

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
    receivePort.listen((event) {
      if (event is Task) {
        if (event.key == 'shutdown') {
          receivePort.close();
          return;
        } else {
          final res = TaskHandler.perform(event);
          sendPort.send(res);
          return;
        }
      }
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

  void close() {
    if (!_closed) {
      _closed = true;
      _sp.send(ShutdownTask());
      if (_activeRequests.isEmpty) _rp.close();
    }
  }
}
