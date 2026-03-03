import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

const _intLookup = <int, DismissDirection>{
  0: DismissDirection.vertical,
  1: DismissDirection.horizontal,
  2: DismissDirection.up,
  3: DismissDirection.down,
  4: DismissDirection.startToEnd,
  5: DismissDirection.endToStart,
  6: DismissDirection.none,
};

const _stringLookup = <String, DismissDirection>{
  "vertical": DismissDirection.vertical,
  "DismissDirection.vertical": DismissDirection.vertical,
  "horizontal": DismissDirection.horizontal,
  "DismissDirection.horizontal": DismissDirection.horizontal,
  "up": DismissDirection.up,
  "DismissDirection.up": DismissDirection.up,
  "down": DismissDirection.down,
  "DismissDirection.down": DismissDirection.down,
  "startToEnd": DismissDirection.startToEnd,
  "DismissDirection.startToEnd": DismissDirection.startToEnd,
  "endToStart": DismissDirection.endToStart,
  "DismissDirection.endToStart": DismissDirection.endToStart,
  "none": DismissDirection.none,
  "DismissDirection.none": DismissDirection.none,
};

typedef _DismissThresholds = Map<DismissDirection, double>;

// Computed on first appearance to avoid re-registering the factory
final _lazyRegistar = () {
  DuitRegistry.registerCustomEnumFactory<DismissDirection>(
    (value) {
      return switch (value) {
        int() => _intLookup[value]!,
        String() => _stringLookup[value]!,
        _ => throw ArgumentError("Invalid dismiss direction: $value"),
      };
    },
  );

  DuitRegistry.registerCustomObjectFactory<_DismissThresholds>((data) {
    if (data.isEmpty) return const <DismissDirection, double>{};
    return {
      if (data.containsKey("vertical"))
        DismissDirection.vertical: data.getDouble(key: "vertical"),
      if (data.containsKey("horizontal"))
        DismissDirection.horizontal: data.getDouble(key: "horizontal"),
      if (data.containsKey("up"))
        DismissDirection.up: data.getDouble(key: "up"),
      if (data.containsKey("down"))
        DismissDirection.down: data.getDouble(key: "down"),
      if (data.containsKey("startToEnd"))
        DismissDirection.startToEnd: data.getDouble(key: "startToEnd"),
      if (data.containsKey("endToStart"))
        DismissDirection.endToStart: data.getDouble(key: "endToStart"),
      if (data.containsKey("none"))
        DismissDirection.none: data.getDouble(key: "none"),
    };
  });
}();

class DuitDismissible extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget?> children;

  DuitDismissible({
    required this.attributes,
    required this.children,
    super.key,
  }) {
    assert(
      children.isNotEmpty,
      "Dismissible widget must have at least one child",
    );
    _lazyRegistar;
  }

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Dismissible(
      key: ValueKey(attributes.id),
      background: children.elementAtOrNull(1),
      secondaryBackground: children.elementAtOrNull(2),
      direction: attrs.toEnum<DismissDirection>(
        key: "direction",
        defaultValue: DismissDirection.startToEnd,
      ),
      resizeDuration: attrs.duration(
        key: "resizeDuration",
        defaultValue: const Duration(milliseconds: 300),
      ),
      movementDuration: attrs.duration(
        key: "movementDuration",
        defaultValue: const Duration(milliseconds: 200),
      ),
      crossAxisEndOffset: attrs.tryGetDouble(
        key: "crossAxisEndOffset",
        defaultValue: 0.0,
      )!,
      dismissThresholds: attrs.toClass<_DismissThresholds>(
        key: "dismissThresholds",
        defaultValue: const <DismissDirection, double>{
          DismissDirection.startToEnd: 0.5,
        },
      ),
      behavior: attrs.hitTestBehavior(defaultValue: HitTestBehavior.opaque),
      dragStartBehavior:
          attrs.dragStartBehavior(defaultValue: DragStartBehavior.start),
      child: children.elementAt(0)!,
    );
  }
}

class DuitControlledDismissible extends StatefulWidget {
  final UIElementController controller;
  final List<Widget?> children;

  DuitControlledDismissible({
    required this.controller,
    required this.children,
    super.key,
  }) {
    assert(
      children.isNotEmpty,
      "Dismissible widget must have at least one child",
    );
    _lazyRegistar;
  }

  @override
  State<DuitControlledDismissible> createState() =>
      _DuitControlledDismissibleState();
}

class _DuitControlledDismissibleState extends State<DuitControlledDismissible>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @preferInline
  void _onDismissed(DismissDirection direction) =>
      widget.controller.performAction(
        attributes.getAction("onDismissed"),
      );

  @preferInline
  void _onResize() => widget.controller.performAction(
        attributes.getAction("onResize"),
      );

  @preferInline
  void _onUpdate(DismissUpdateDetails _) => widget.controller.performAction(
        attributes.getAction("onUpdate"),
      );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.controller.id),
      background: widget.children.elementAtOrNull(1),
      secondaryBackground: widget.children.elementAtOrNull(2),
      direction: attributes.toEnum<DismissDirection>(
        key: "direction",
        defaultValue: DismissDirection.horizontal,
      ),
      resizeDuration: attributes.duration(
        key: "resizeDuration",
        defaultValue: const Duration(milliseconds: 300),
      ),
      movementDuration: attributes.duration(
        key: "movementDuration",
        defaultValue: const Duration(milliseconds: 200),
      ),
      crossAxisEndOffset: attributes.tryGetDouble(
        key: "crossAxisEndOffset",
        defaultValue: 0.0,
      )!,
      behavior:
          attributes.hitTestBehavior(defaultValue: HitTestBehavior.opaque),
      dragStartBehavior:
          attributes.dragStartBehavior(defaultValue: DragStartBehavior.start),
      dismissThresholds: attributes.toClass<_DismissThresholds>(
        key: "dismissThresholds",
        defaultValue: const <DismissDirection, double>{},
      ),
      onDismissed: _onDismissed,
      onResize: _onResize,
      onUpdate: _onUpdate,
      child: widget.children.elementAt(0)!,
    );
  }
}
