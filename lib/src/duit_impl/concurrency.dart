import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_duit/src/utils/index.dart';

FutureOr<Object?> _handler(Object? message) {
  if (message is Job) {
    switch (message.key) {
      case "parseJson":
        jsonDecode(utf8.decode(message.payload)) as Map<String, dynamic>;
      case "fillProps":
        return JsonUtils.fillComponentProperties(
          message.payload["layout"],
          message.payload["data"],
        );
      case "test":
        print("test");
        return 0;
    }
  }

  return null;
}

base class Job {
  final String key;
  final dynamic payload;

  Job({
    required this.key,
    required this.payload,
  });
}

enum TaskDistributionPolicy {
  sequential,
  roundRobin,
}

typedef Handler = void Function(Object? message);

final class WorkerPool {
  static final WorkerPool _singleton = WorkerPool._internal();

  factory WorkerPool() {
    return _singleton;
  }

  WorkerPool._internal();

  bool initialized = false;
  final _workers = <_Worker>[];

  Future<void> init() async {
    if (!initialized) {
      for (var i = 0; i < 4; i++) {
        try {
          _workers.add(await _Worker.spawn());
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      initialized = true;
    } else {
      debugPrint("WorkerPool already initialized");
    }
  }

  Future<Object?> run(Job job) async {
    return await _workers.first.sendJob(job);
  }

  void close() {
    for (var worker in _workers) {
      worker.close();
    }
  }
}

class _Worker {
  final SendPort _sp;
  final ReceivePort _rp;
  final Map<int, Completer<Object?>> _activeRequests = {};
  bool _closed = false;
  int _idCounter = 0;

  Future<Object?> sendJob(Object? message) async {
    if (_closed) throw StateError('Worker closed');
    final completer = Completer<Object?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _sp.send(message);
    return await completer.future;
  }

  static Future<_Worker> spawn() async {
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

    return _Worker._(receivePort, sendPort);
  }

  _Worker._(this._rp, this._sp) {
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
    Handler cb,
  ) {
    receivePort.listen(cb);
  }

  static void _runIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(receivePort, sendPort, _handler);
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _sp.send('shutdown');
      if (_activeRequests.isEmpty) _rp.close();
      print('--- port closed --- ');
    }
  }
}
