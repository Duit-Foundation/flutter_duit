import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

final class DuitSliverList extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;

  const DuitSliverList({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return SliverList.list(
      key: Key(attributes.id),
      addAutomaticKeepAlives: attrs.getBool(
        "addAutomaticKeepAlives",
        defaultValue: true,
      ),
      addRepaintBoundaries: attrs.getBool(
        "addRepaintBoundaries",
        defaultValue: true,
      ),
      addSemanticIndexes: attrs.getBool(
        "addSemanticIndexes",
        defaultValue: true,
      ),
      children: children,
    );
  }
}

final class DuitControlledSliverList extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledSliverList({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledSliverList> createState() =>
      _DuitControlledSliverListState();
}

class _DuitControlledSliverListState extends State<DuitControlledSliverList>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      key: Key(widget.controller.id),
      addAutomaticKeepAlives: attributes.getBool(
        "addAutomaticKeepAlives",
        defaultValue: true,
      ),
      addRepaintBoundaries: attributes.getBool(
        "addRepaintBoundaries",
        defaultValue: true,
      ),
      addSemanticIndexes: attributes.getBool(
        "addSemanticIndexes",
        defaultValue: true,
      ),
      children: widget.children,
    );
  }
}
