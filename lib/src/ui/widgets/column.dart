import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitColumn extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitColumn({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Column(
      key: Key(attributes.id),
      mainAxisAlignment: attrs.mainAxisAlignment(
        defaultValue: MainAxisAlignment.start,
      )!,
      mainAxisSize: attrs.mainAxisSize(
        defaultValue: MainAxisSize.max,
      )!,
      crossAxisAlignment: attrs.crossAxisAlignment(
        defaultValue: CrossAxisAlignment.center,
      )!,
      textDirection: attrs.textDirection(),
      verticalDirection: attrs.verticalDirection(
        defaultValue: VerticalDirection.down,
      ),
      children: children,
    );
  }
}

class DuitControlledColumn extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledColumn({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledColumn> createState() => _DuitControlledColumnState();
}

class _DuitControlledColumnState extends State<DuitControlledColumn>
    with ViewControllerChangeListener, SlotHost {
  @override
  void initState() {
    attachStateToController(widget.controller);
    handleSlots(widget.controller, widget.children);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key(widget.controller.id),
      mainAxisAlignment: attributes.mainAxisAlignment(
        defaultValue: MainAxisAlignment.start,
      )!,
      mainAxisSize: attributes.mainAxisSize(
        defaultValue: MainAxisSize.max,
      )!,
      crossAxisAlignment: attributes.crossAxisAlignment(
        defaultValue: CrossAxisAlignment.center,
      )!,
      textDirection: attributes.textDirection(),
      verticalDirection: attributes.verticalDirection(
        defaultValue: VerticalDirection.down,
      ),
      children: children,
    );
  }
}
