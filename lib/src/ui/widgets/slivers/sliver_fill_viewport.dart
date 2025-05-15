import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

final class DuitSliverFillViewport extends StatelessWidget
    with ChildDelegateBuilder {
  final ViewAttribute<SliverFillViewportAttributes> attributes;
  final List<Widget> children;
  const DuitSliverFillViewport({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    assert(attributes.payload.isBuilderDelegate == false,
        "Builder delegate not supported for uncontrolled widget variant");
    return SliverFillViewport(
      key: ValueKey(attributes.id),
      delegate: buildDelegate(
        false,
        children: children,
        addAutomaticKeepAlives: attributes.payload.addAutomaticKeepAlives,
        addRepaintBoundaries: attributes.payload.addRepaintBoundaries,
        addSemanticIndexes: attributes.payload.addSemanticIndexes,
        // semanticIndexOffset: attributes.,
      ),
      viewportFraction: attributes.payload.viewportFraction,
      padEnds: attributes.payload.padEnds,
    );
  }
}

final class DuitControlledSliverFillViewport extends StatefulWidget {
  final UIElementController<SliverFillViewportAttributes> controller;
  final List<Widget> children;

  const DuitControlledSliverFillViewport({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledSliverFillViewport> createState() =>
      _DuitControlledSliverFillViewportState();
}

class _DuitControlledSliverFillViewportState
    extends State<DuitControlledSliverFillViewport>
    with
        ViewControllerChangeListener<DuitControlledSliverFillViewport,
            SliverFillViewportAttributes>,
        OutOfBoundWidgetBuilder,
        ChildDelegateBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  Widget? _buildItem(BuildContext context, int index) {
    final list = attributes.childObjects ?? const [];
    final item = list[index];

    return buildOutOfBoundWidget(
      item,
      widget.controller.driver,
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillViewport(
      key: ValueKey(widget.controller.id),
      delegate: buildDelegate(
        attributes.isBuilderDelegate,
        builder: _buildItem,
        children: widget.children,
        addAutomaticKeepAlives: attributes.addAutomaticKeepAlives,
        addRepaintBoundaries: attributes.addRepaintBoundaries,
        addSemanticIndexes: attributes.addSemanticIndexes,
        childCount: attributes.childCount,
        // semanticIndexOffset: attributes.,
      ),
      viewportFraction: attributes.viewportFraction,
      padEnds: attributes.padEnds,
    );
  }
}
