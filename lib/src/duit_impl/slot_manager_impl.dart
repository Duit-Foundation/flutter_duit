import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/ui/element_property_view.dart";

final class SlotManagerImpl implements SlotManager {
  final _slotHosts = <String, ElementPropertyView>{};
  final UIDriver driver;

  SlotManagerImpl(this.driver);

  @override
  void attachSlotHost(String id, ElementPropertyView view) =>
      _slotHosts[id] = view;

  @override
  void detachSlotHost(String id) => _slotHosts.remove(id);

  @override
  T? getSlotHostAs<T>(String id) => _slotHosts[id] as T?;

  @override
  void updateSlotHostContent(String id, List<SlotOp> ops) {
    final controller = driver.getController(id);
    if (controller == null) return;

    final view = _slotHosts[id];
    if (view == null) return;

    switch (view.type.childRelation) {
      case 1:
        final op = ops.first;
        //SlotOpCode.add has "replace" semantics in single-child slot hosts
        if (op.code == SlotOpCode.add) {
          view["child"] = ElementPropertyView.fromJson(op.data, driver)
            ..markAsDirty();
          break;
        }
        break;
      case 2:
        var children = view.children;
        final forwardedOps = <Map<String, dynamic>>[];

        // Ensure children list exists in json when it was absent
        if (!view.containsKey("children")) {
          view["children"] = <ElementPropertyView?>[];
          children = view.children;
        }

        for (final op in ops) {
          switch (op.code) {
            case SlotOpCode.add:
              final data = op.addOp();
              final added = ElementPropertyView.fromJson(data.data, driver)
                ..markAsDirty();
              children.add(added);
              forwardedOps.add({
                "op": data.code,
                "index": children.length - 1,
              });
            case SlotOpCode.insert:
              final data = op.insertOp();
              final element = ElementPropertyView.fromJson(data.data, driver)
                ..markAsDirty();
              final insertIndex = data.index;
              if (insertIndex < 0 || insertIndex > children.length) {
                // Clamp to valid bounds
                final clamped = insertIndex < 0 ? 0 : children.length;
                children.insert(clamped, element);
                forwardedOps.add({
                  "op": data.code,
                  "index": clamped,
                });
              } else {
                children.insert(insertIndex, element);
                forwardedOps.add({
                  "op": data.code,
                  "index": insertIndex,
                });
              }
            case SlotOpCode.move:
              final data = op.moveOp();
              final from = data.from;
              final to = data.to;
              if (from >= 0 && from < children.length) {
                final item = children.removeAt(from);
                var target = to;
                if (target < 0) target = 0;
                if (target > children.length) target = children.length;
                children.insert(target, item);
                forwardedOps.add({
                  "op": data.code,
                  "from": from,
                  "to": target,
                });
              }
            case SlotOpCode.remove:
              final data = op.removeOp();
              final removeIndex = data.index;
              if (removeIndex >= 0 && removeIndex < children.length) {
                children.removeAt(removeIndex);
                forwardedOps.add({
                  "op": data.code,
                  "index": removeIndex,
                });
              }
          }
        }

        // Store ops for the widget-side listener to apply minimal updates
        view["_ops"] = forwardedOps;
        break;
      default:
        break;
    }

    //force update state
    controller.updateState(const <String, dynamic>{});
  }
}
