import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/view/view.dart";

final class DuitViewManager with ViewModelCapabilityDelegate {
  late final UIDriver _driver;

  final _eventStreamController = StreamController<UIDriverEvent>.broadcast();

  late final DuitViewModel _view;

  @override
  late BuildContext buildContext;

  @override
  @preferInline
  void addUIDriverError(Object error, [StackTrace? stackTrace]) =>
      _eventStreamController.addError(
        error,
        stackTrace,
      );

  @override
  @preferInline
  void addUIDriverEvent(UIDriverEvent event) =>
      _eventStreamController.add(event);

  @override
  @preferInline
  Stream<UIDriverEvent> get eventStream => _eventStreamController.stream;

  @override
  void notifyWidgetDisplayStateChanged(String viewTag, int state) {
    try {
      _view.changeViewState(viewTag, state);
    } catch (e, s) {
      _driver.logger?.error(
        "View not initialized and can`t be disposed",
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  @preferInline
  set context(BuildContext value) => buildContext = value;

  Future<DuitView?> _parseSingeLayoutModel(Map<String, dynamic> json) async {
    if (LayoutStructValidator.isWidgetStruct(json)) {
      _view = CommonDuitView();
      await _view.prepareModel(
        json,
        _driver,
      );
      return _view;
    } else if (LayoutStructValidator.isRootStruct(json)) {
      _view = CommonDuitView();
      final widget = Map<String, dynamic>.from(json["root"]);
      await _view.prepareModel(
        widget,
        _driver,
      );
      return _view;
    } else if (LayoutStructValidator.isWidgetsStruct(json)) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<DuitView?> prepareLayout(Map<String, dynamic> json) async {
    if (json.containsKey("embedded")) {
      final embedded = json["embedded"];
      if (embedded is List) {
        await DuitRegistry.registerComponents(
          embedded.cast<Map<String, dynamic>>(),
        );
      }
    }

    final compatView = await _parseSingeLayoutModel(json);

    if (enableSharedDrivers && compatView == null) {
      if (LayoutStructValidator.isWidgetStruct(json)) {
        _view = SharedDuitView();

        final collection = Map.from(json["widgets"]);

        final widgets = collection.entries.cast<MapEntry<String, dynamic>>();

        for (final widget in widgets) {
          await _view.prepareModel(
            <String, dynamic>{
              widget.key: widget.value,
            },
            _driver,
          );
        }
        return _view;
      }
      return null;
    }
    return compatView;
  }

  @override
  void releaseResources() {
    _eventStreamController.close();
  }

  @override
  bool isWidgetReady(String viewTag) => _view.isWidgetReady(viewTag);

  @override
  void linkDriver(UIDriver driver) => _driver = driver;
}
