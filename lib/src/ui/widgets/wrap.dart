import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitWrap extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitWrap({
    super.key,
    required this.attributes,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      DuitDataSource(
        attributes.payload,
      ),
    );
    return Wrap(
      key: Key(attributes.id),
      alignment: attrs.wrapAlignment(defaultValue: WrapAlignment.start)
          as WrapAlignment,
      runAlignment: attrs.wrapAlignment(
          key: "runAlignment",
          defaultValue: WrapAlignment.start) as WrapAlignment,
      spacing: attrs.getDouble(key: "spacing"),
      runSpacing: attrs.getDouble(key: "runSpacing"),
      direction: attrs.axis(defaultValue: Axis.horizontal),
      textDirection: attrs.textDirection(),
      verticalDirection: attrs.verticalDirection(),
      clipBehavior: attrs.clipBehavior(
        defaultValue: Clip.none,
      ),
      crossAxisAlignment: attrs.wrapCrossAlignment(
          defaultValue: WrapCrossAlignment.start) as WrapCrossAlignment,
      children: children,
    );
  }
}

class DuitControlledWrap extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledWrap({
    super.key,
    required this.controller,
    this.children = const [],
  });

  @override
  State<DuitControlledWrap> createState() => _DuitControlledWrapState();
}

class _DuitControlledWrapState extends State<DuitControlledWrap>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );

    return Wrap(
      key: Key(widget.controller.id),
      alignment: attrs.wrapAlignment(defaultValue: WrapAlignment.start)
          as WrapAlignment,
      runAlignment: attrs.wrapAlignment(
          key: "runAlignment",
          defaultValue: WrapAlignment.start) as WrapAlignment,
      spacing: attrs.getDouble(key: "spacing"),
      runSpacing: attrs.getDouble(key: "runSpacing"),
      direction: attrs.axis(defaultValue: Axis.horizontal),
      textDirection: attrs.textDirection(),
      verticalDirection: attrs.verticalDirection(),
      clipBehavior: attrs.clipBehavior(
        defaultValue: Clip.none,
      ),
      crossAxisAlignment: attrs.wrapCrossAlignment(
          defaultValue: WrapCrossAlignment.start) as WrapCrossAlignment,
      children: widget.children,
    );
  }
}
