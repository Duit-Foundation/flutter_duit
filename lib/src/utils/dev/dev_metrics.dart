import 'dart:async';
import 'dart:developer';

import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/dev/st_messages.dart';

final class DevMetrics {
  static final DevMetrics _instance = DevMetrics._();

  DevMetrics._();

  factory DevMetrics() => _instance;

  late final _StartupController? _sController;
  late final _ComponentMetricsController? _cController;
  bool _isInitialized = false;

  void init(String label) {
    _isInitialized = true;
    _sController = _StartupController(label);
    _cController = _ComponentMetricsController();
  }

  void add(dynamic message) {
    if (!_isInitialized) return;

    if (message is DevStartUpMessage) {
      _sController?.handleMessage(message);
    } else if (message is DevComponentMessage) {
      _cController?.handleMessage(message);
    }
  }
}

final class _ComponentMetricsController {
  DateTime? _cStartMerge, _cEndMerge;
  final List<Duration> _mergeDurations = [];

  void _reset() {
    _cStartMerge = null;
    _cEndMerge = null;
  }

  void _saveResult(Duration duration) {
    _mergeDurations.add(duration);
  }

  void handleMessage(DevComponentMessage message) {
    switch (message) {
      case StartMergeMessage():
        _cStartMerge = message.timestamp;
        break;
      case EndMergeMessage():
        _cEndMerge = message.timestamp;

        final mergeDuration = _cEndMerge!.difference(_cStartMerge!);
        _reset();
        _saveResult(mergeDuration);

        log(
          "Component data merge duration: $mergeDuration",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        break;

      case LogMergeInfo():
        var total = Duration.zero;
        for (var duration in _mergeDurations) {
          total += duration;
        }

        final medianDur = Duration(
            microseconds: total.inMicroseconds ~/ _mergeDurations.length);

        log(
          "Component data merge median duration: $medianDur from ${_mergeDurations.length} iterations ",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        break;
    }
  }
}

final class _StartupController {
  DateTime? _stReqTs,
      _stLByteTs,
      _stFByteTs,
      _stDecodeStartTs,
      _stDecodeEndTs,
      _stParseStartTs,
      _stParseEndTs,
      _stRenderStartTs,
      _stRenderEndTs;

  bool _isDataCaptured = false;

  final String label;

  _StartupController(this.label);

  void handleMessage(DevStartUpMessage message) {
    if (_isDataCaptured) return;

    switch (message) {
      case ConnectionStartMessage():
        _stReqTs = message.timestamp;
        break;

      case ReqStartMessage():
        _stFByteTs = message.timestamp;
        break;

      case ReqEndMessage():
        _stLByteTs = message.timestamp;
        break;

      case DecodeStartMessage():
        _stDecodeStartTs = message.timestamp;
        break;

      case DecodeEndMessage():
        _stDecodeEndTs = message.timestamp;
        break;

      case ParseModelStartMessage():
        _stParseStartTs = message.timestamp;
        break;

      case ParseModelEndMessage():
        _stParseEndTs = message.timestamp;
        break;

      case RenderStartMessage():
        _stRenderStartTs = message.timestamp;
        break;

      case RenderEndMessage():
        _stRenderEndTs = message.timestamp;

        final averageDuration = _stRenderEndTs!.difference(_stReqTs!);
        final reqTime = _stLByteTs!.difference(_stFByteTs!);
        final decodeTime = _stDecodeEndTs!.difference(_stDecodeStartTs!);
        final parseTime = _stParseEndTs!.difference(_stParseStartTs!);
        final renderTime = _stRenderEndTs!.difference(_stRenderStartTs!);

        _isDataCaptured = true;

        log(
          "Screen source: $label",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        log(
          "Average startup duration: $averageDuration",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        log(
          "Initial request time: $reqTime",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        log(
          "Initial request decode time: $decodeTime",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        log(
          "Initial request payload parse time: $parseTime",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        log(
          "Render time: $renderTime",
          zone: Zone.current,
          name: "Duit DevMetrics",
          time: DateTime.now().toLocal(),
        );
        break;
    }
  }
}
