import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
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

        if (d != null && d.isDirty) {
          setState(() {
            _children[0] = d.renderView();
            d.markAsClean();
          });
        }
      case 2:
        final ops = slot.ops;

        if (ops.isNotEmpty) {
          for (final op in ops) {
            switch (op.code) {
              case SlotOpCode.add:
              case SlotOpCode.insert:
                final index = op.index;
                final kids = slot.children;
                if (index >= 0 && index < kids.length) {
                  final e = kids[index];
                  final widget =
                      e != null ? e.renderView() : const SizedBox.shrink();
                  if (op.code == SlotOpCode.add && index >= _children.length) {
                    _children.add(widget);
                  } else {
                    if (index <= _children.length) {
                      _children.insert(index, widget);
                    }
                  }
                  if (e != null) e.markAsClean();
                }
              case SlotOpCode.move:
                final from = op.from;
                var to = op.to;
                if (from < 0 || from >= _children.length) break;
                if (to < 0) to = 0;
                if (to > _children.length) to = _children.length;
                final item = _children.removeAt(from);
                _children.insert(to, item);
              case SlotOpCode.remove:
                final index = op.index;
                if (index < 0 || index >= _children.length) break;
                _children.removeAt(index);
              default:
                break;
            }
          }
        }

        // Apply minimal re-render only for dirty children
        final kids = slot.children;
        final dirtyIndices = <int>[];
        for (var i = 0; i < kids.length; i++) {
          final e = kids[i];
          if (e != null && e.isDirty) dirtyIndices.add(i);
        }

        if (dirtyIndices.isNotEmpty) {
          setState(() {
            for (final i in dirtyIndices) {
              final e = kids[i];
              _children[i] =
                  e != null ? e.renderView() : const SizedBox.shrink();
              e?.markAsClean();
            }
          });
        }

        slot.clearOps();
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
