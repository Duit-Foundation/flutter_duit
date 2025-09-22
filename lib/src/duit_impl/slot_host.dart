import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/element_property_view.dart";

mixin SlotHost<T extends StatefulWidget> on State<T> {
  final List<Widget> _children = [];
  late UIElementController _controller;

  /// Returns the list of children of the widget.
  List<Widget> get children => _children;

  /// Returns the first child of the widget.
  Widget get child => _children[0];

  void handleSlots(
    UIElementController controller,
    subviews,
  ) {
    if (subviews is List<Widget>) {
      _children.addAll(subviews);
    } else if (subviews is Widget) {
      _children.add(subviews);
    }

    _controller = controller;
  }

  void _listener() {
    final slot =
        _controller.driver.getSlotHostAs<ElementPropertyView>(_controller.id);

    if (slot == null) return;

    switch (slot.type.childRelation) {
      case 1:
        final d = slot.child;

        if (d != null) {
          setState(() {
            _children[0] = d.renderView();
          });
        }
      case 2:
        final diffedArray = slot.children.sublist(_children.length);

        final newChildren = diffedArray.map((e) {
          if (e != null) {
            return e.renderView();
          } else {
            return const SizedBox.shrink();
          }
        }).toList();

        setState(() {
          _children.addAll(newChildren);
        });
      default:
        break;
    }
  }

  void _setupListener() {
    try {
      _controller.addListener(_listener);
    } catch (e) {
      // Controller might be disposed - skip adding listener
      return;
    }
  }

  @override
  void didChangeDependencies() {
    _setupListener();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.driver.detachSlotHost(_controller.id);
    super.dispose();
  }
}
