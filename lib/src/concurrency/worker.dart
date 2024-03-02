import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';

typedef IsolateCallback = void Function(Task? message);

FutureOr<Object?> _handler(Task? message) {
  if (message == null) return null;

  switch (message.key) {
    case "parseJson":
      return switch (message.payload) {
        String() => jsonDecode(message.payload) as Map<String, dynamic>,
        Uint8List() =>
          jsonDecode(utf8.decode(message.payload)) as Map<String, dynamic>,
        Map() => message.payload,
        Object() || null => null,
      };
    case "fillComponentProperties":
      return JsonUtils.fillComponentProperties(
        message.payload["layout"],
        message.payload["data"],
      );
  }

  return null;
}

class DuitWorker {
  final SendPort _sp;
  final ReceivePort _rp;
  final Map<int, Completer<Object?>> _activeRequests = {};
  bool _closed = false;
  int _idCounter = 0;

  Future<Object?> executeTask(Task? task) async {
    if (_closed) throw StateError('Worker closed');
    final completer = Completer<Object?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
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
    IsolateCallback cb,
  ) {
    receivePort.listen((event) {
      if (event is Task) {
        if (event.key == 'shutdown') {
          receivePort.close();
          return;
        } else {
          cb(event);
        }
      }
    });
  }

  static void _runIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(receivePort, sendPort, _handler);
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _sp.send(ShutdownTask());
      if (_activeRequests.isEmpty) _rp.close();
    }
  }
}
