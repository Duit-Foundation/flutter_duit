import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart" show SizedBox, Widget, mustCallSuper;
import "package:flutter_duit/src/ui/element_property_view.dart";
import "package:flutter_duit/src/view_manager/view_manager.dart";
import "package:flutter_duit/src/view_manager/view_layout.dart";

base class SimpleViewManager extends ViewManager {
  DuitViewLayout? _view;
  final Map<String, UIElementController> _viewControllers = {};
  final Map<String, Map<String, dynamic>> _slotHosts = {};

  @override
  @mustCallSuper
  Future<DuitView?> prepareLayout(Map<String, dynamic> json) async {
    try {
      _view = DuitViewLayout();

      if (json.containsKey("embedded")) {
        final embedded = json["embedded"];
        if (embedded is List) {
          await DuitRegistry.registerComponents(
            embedded.cast<Map<String, dynamic>>(),
          );
        }
      }

      switch (json) {
        case {
            "type": String _,
            "id": String _,
          }:
          await _view?.prepareModel(
            json,
            driver,
          );
          return _view;
        case {
            "root": Map<String, dynamic> widget,
          }:
          await _view?.prepareModel(
            widget,
            driver,
          );
          return _view;
        default:
          return null;
      }
    } catch (e, s) {
      driver.logger?.error(
        "Failed to resolve tree",
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Widget build([String tag = ""]) {
    if (tag.isNotEmpty) {
      driver.logger?.warn(
        "Tag is not supported in SimpleViewManager and will be ignored",
      );
    }

    return _view?.build(tag) ?? const SizedBox.shrink();
  }

  @override
  void notifyWidgetDisplayStateChanged(String viewTag, int state) {
    _view?.isReady = state == 1;
  }

  @override
  bool isWidgetReady(String viewTag) {
    return _view?.isReady ?? false;
  }

  @override
  void addController(String id, UIElementController controller) {
    final alreadyContains = _viewControllers.containsKey(id);

    if (alreadyContains) {
      driver.logger?.warn(
        "Controller with id=$id already exists and it will be overriden \n This could happen because two or more controlled widgets have the same id parameter",
      );
    }

    _viewControllers[id] = controller;
  }

  @override
  UIElementController? removeController(String id) {
    return _viewControllers.remove(id);
  }

  @override
  UIElementController? getController(String id) {
    return _viewControllers[id];
  }

  @override
  int get controllersCount => _viewControllers.length;

  @override
  void attachSlotHost(String id, Map<String, dynamic> view) =>
      _slotHosts[id] = view;

  @override
  void detachSlotHost(String id) => _slotHosts.remove(id);

  @override
  T? getSlotHostAs<T>(String id) => _slotHosts[id] as T?;

  @override
  void updateSlotHostContent(String id, Map<String, dynamic> data) {
    final controller = getController(id);
    if (controller != null) {
      final view = getSlotHostAs<ElementPropertyView>(id);
      if (view == null) return;

      switch (view.type.childRelation) {
        case 1:
          view["child"] = ElementPropertyView.fromJson(data["child"], driver);
          break;
        case 2:
          final rawChildren = (data["children"] as List?)
                  ?.whereType<Map<String, dynamic>>()
                  .map((e) => ElementPropertyView.fromJson(e, driver))
                  .toList() ??
              const <ElementPropertyView>[];

          if (rawChildren.isEmpty) return;

          final existing = view["children"];
          if (existing is List<ElementPropertyView?>) {
            existing.addAll(rawChildren);
          } else if (existing is List) {
            final existingViews = existing
                .whereType<Map<String, dynamic>>()
                .map((e) => ElementPropertyView.fromJson(e, driver))
                .toList();
            view["children"] = [...existingViews, ...rawChildren];
          } else {
            view["children"] = rawChildren;
          }
          break;
        default:
          break;
      }

      controller.updateState(const <String, dynamic>{});
    }
  }
}
