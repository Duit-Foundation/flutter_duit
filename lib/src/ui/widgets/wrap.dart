import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitWrap extends StatelessWidget {
  final List<Widget> children;
  final ViewAttributeWrapper attributes;

  const DuitWrap({
    super.key,
    required this.attributes,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload as WrapAttributes;
    return Wrap(
      alignment: attrs.alignment ?? WrapAlignment.start,
      runAlignment: attrs.runAlignment ?? WrapAlignment.start,
      spacing: attrs.spacing,
      runSpacing: attrs.runSpacing,
      direction: attrs.direction ?? Axis.horizontal,
      textDirection: attrs.textDirection,
      verticalDirection: attrs.verticalDirection ?? VerticalDirection.down,
      clipBehavior: attrs.clipBehavior ?? Clip.none,
      crossAxisAlignment: attrs.crossAxisAlignment ?? WrapCrossAlignment.start,
      children: children,
    );
  }
}

class DuitControlledWrap extends StatefulWidget {
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
    with ViewControllerChangeListener<DuitControlledWrap, WrapAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: attributes?.alignment ?? WrapAlignment.start,
      runAlignment: attributes?.runAlignment ?? WrapAlignment.start,
      spacing: attributes?.spacing ?? 0.0,
      runSpacing: attributes?.runSpacing ?? 0.0,
      direction: attributes?.direction ?? Axis.horizontal,
      textDirection: attributes?.textDirection,
      crossAxisAlignment:
          attributes?.crossAxisAlignment ?? WrapCrossAlignment.start,
      verticalDirection:
          attributes?.verticalDirection ?? VerticalDirection.down,
      clipBehavior: attributes?.clipBehavior ?? Clip.none,
      children: widget.children,
    );
  }
}
