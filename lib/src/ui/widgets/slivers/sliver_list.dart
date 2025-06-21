import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

final class DuitSliverList extends StatelessWidget {
  final ViewAttribute<SliverListAttributes> attributes;
  final List<Widget> children;

  const DuitSliverList({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return SliverList.list(
      key: Key(attributes.id),
      addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
      addRepaintBoundaries: attrs.addRepaintBoundaries,
      addSemanticIndexes: attrs.addSemanticIndexes,
      children: children,
    );
  }
}

final class DuitControlledSliverList extends StatefulWidget {
  final UIElementController<SliverListAttributes> controller;
  final List<Widget> children;

  const DuitControlledSliverList({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledSliverList> createState() =>
      _DuitControlledSliverListState();
}

class _DuitControlledSliverListState extends State<DuitControlledSliverList>
    with
        ViewControllerChangeListener<DuitControlledSliverList,
            SliverListAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      key: Key(widget.controller.id),
      addAutomaticKeepAlives: attributes.addAutomaticKeepAlives,
      addRepaintBoundaries: attributes.addRepaintBoundaries,
      addSemanticIndexes: attributes.addSemanticIndexes,
      children: widget.children,
    );
  }
}
