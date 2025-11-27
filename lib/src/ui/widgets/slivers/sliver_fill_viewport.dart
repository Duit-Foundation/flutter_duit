import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

final class DuitSliverFillViewport extends StatelessWidget
    with ChildDelegateBuilder {
  final ViewAttribute attributes;
  final List<Widget> children;
  const DuitSliverFillViewport({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      attributes.payload.getBool("isBuilderDelegate") == false,
      "Builder delegate not supported for uncontrolled widget variant",
    );
    return SliverFillViewport(
      key: ValueKey(attributes.id),
      delegate: buildDelegate(
        false,
        children: children,
        addAutomaticKeepAlives: attributes.payload.getBool(
          "addAutomaticKeepAlives",
          defaultValue: true,
        ),
        addRepaintBoundaries: attributes.payload.getBool(
          "addRepaintBoundaries",
          defaultValue: true,
        ),
        addSemanticIndexes: attributes.payload.getBool(
          "addSemanticIndexes",
        ),
      ),
      viewportFraction: attributes.payload.getDouble(
        key: "viewportFraction",
        defaultValue: 1.0,
      ),
      padEnds: attributes.payload.getBool(
        "padEnds",
        defaultValue: true,
      ),
    );
  }
}

final class DuitControlledSliverFillViewport extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;

  const DuitControlledSliverFillViewport({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledSliverFillViewport> createState() =>
      _DuitControlledSliverFillViewportState();
}

class _DuitControlledSliverFillViewportState
    extends State<DuitControlledSliverFillViewport>
    with
        ViewControllerChangeListener,
        OutOfBoundWidgetBuilder,
        ChildDelegateBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  Widget? _buildItem(BuildContext context, int index) {
    final list = attributes.childObjects();
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
        attributes.getBool("isBuilderDelegate"),
        builder: _buildItem,
        children: widget.children,
        addAutomaticKeepAlives: attributes.getBool(
          "addAutomaticKeepAlives",
          defaultValue: true,
        ),
        addRepaintBoundaries: attributes.getBool(
          "addRepaintBoundaries",
          defaultValue: true,
        ),
        addSemanticIndexes: attributes.getBool("addSemanticIndexes"),
        childCount: attributes.tryGetInt(key: "childCount"),
      ),
      viewportFraction: attributes.getDouble(
        key: "viewportFraction",
        defaultValue: 1.0,
      ),
      padEnds: attributes.getBool(
        "padEnds",
        defaultValue: true,
      ),
    );
  }
}
