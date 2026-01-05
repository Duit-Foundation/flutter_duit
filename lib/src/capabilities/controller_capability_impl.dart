import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/index.dart";

final class DuitControllerManager with UIControllerCapabilityDelegate {
  final Map<String, UIElementController> _viewControllers = {};
  late final UIDriver _driver;

  @override
  void attachController(String id, UIElementController controller) {
    final alreadyContains = _viewControllers.containsKey(id);

    if (alreadyContains) {
      _driver.logger?.warn(
        "Controller with id=$id already exists and it will be overriden \n This could happen because two or more controlled widgets have the same id parameter",
      );
    }

    _viewControllers[id] = controller;
  }

  @override
  void detachController(String id) => _viewControllers.remove(id)?.dispose();

  @override
  UIElementController? getController(String id) => _viewControllers[id];

  @override
  int get controllersCount => _viewControllers.length;

  Future<void> _resolveComponentUpdate(
    UIElementController controller,
    Map<String, dynamic> json,
  ) async {
    final tag = controller.tag;
    final description = DuitRegistry.getComponentDescription(tag!);

    if (description != null) {
      final component = ComponentBuilder.build(
        description,
        json,
      );

      controller.updateState(component);
    }
  }

  @override
  Future<void> updateAttributes(
    String controllerId,
    Map<String, dynamic> json,
  ) async {
    final controller = _viewControllers[controllerId];
    if (controller != null) {
      if (controller.type == ElementType.component.name) {
        await _resolveComponentUpdate(controller, json);
        return;
      }
      controller.updateState(json);
    }
  }

  @override
  void releaseResources() {
    for (var controller in _viewControllers.values) {
      controller.detach();
    }
    _viewControllers.clear();
  }

  @override
  void linkDriver(UIDriver driver) => _driver = driver;
}
