import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";

final class DuitSliverGrid extends StatelessWidget {
  final ViewAttribute<SliverGridAttributes> attributes;
  final List<Widget> children;

  const DuitSliverGrid({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    switch (attrs.constructor) {
      case GridConstructor.common:
        SliverGridDelegate delegate;
        final viewCtx = DuitViewContext.of(context);

        final delegateBuilder =
            viewCtx.sliverGridDelegatesRegistry[attrs.sliverGridDelegateKey];

        if (delegateBuilder != null) {
          delegate = delegateBuilder.call(
            attrs.sliverGridDelegateOptions,
          );
        } else {
          throw ArgumentError(
            "SliverGridDelegate builder not found in DuitViewContext",
          );
        }

        return SliverGrid(
          key: ValueKey(attributes.id),
          gridDelegate: delegate,
          delegate: SliverChildListDelegate(
            children,
            addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
            addRepaintBoundaries: attrs.addRepaintBoundaries,
            addSemanticIndexes: attrs.addSemanticIndexes,
          ),
        );
      case GridConstructor.count:
        return SliverGrid.count(
          key: ValueKey(attributes.id),
          crossAxisCount: attrs.crossAxisCount,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          childAspectRatio: attrs.childAspectRatio,
          children: children,
        );
      case GridConstructor.extent:
        return SliverGrid.extent(
          key: ValueKey(attributes.id),
          maxCrossAxisExtent: attrs.maxCrossAxisExtent,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          childAspectRatio: attrs.childAspectRatio,
          children: children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class DuitControlledSliverGrid extends StatefulWidget {
  final UIElementController<SliverGridAttributes> controller;
  final List<Widget> children;

  const DuitControlledSliverGrid({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledSliverGrid> createState() =>
      _DuitControlledSliverGridState();
}

class _DuitControlledSliverGridState extends State<DuitControlledSliverGrid>
    with
        ViewControllerChangeListener<DuitControlledSliverGrid,
            SliverGridAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = attributes;
    switch (attrs.constructor) {
      case GridConstructor.common:
        SliverGridDelegate delegate;
        final viewCtx = DuitViewContext.of(context);

        final delegateBuilder =
            viewCtx.sliverGridDelegatesRegistry[attrs.sliverGridDelegateKey];

        if (delegateBuilder != null) {
          delegate = delegateBuilder.call(
            attrs.sliverGridDelegateOptions,
          );
        } else {
          throw UnimplementedError("SliverGridDelegate builder not found");
        }

        return SliverGrid(
          key: ValueKey(widget.controller.id),
          gridDelegate: delegate,
          delegate: SliverChildListDelegate(
            widget.children,
            addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
            addRepaintBoundaries: attrs.addRepaintBoundaries,
            addSemanticIndexes: attrs.addSemanticIndexes,
          ),
        );
      case GridConstructor.count:
        return SliverGrid.count(
          key: ValueKey(widget.controller.id),
          crossAxisCount: attrs.crossAxisCount,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          childAspectRatio: attrs.childAspectRatio,
          children: widget.children,
        );
      case GridConstructor.extent:
        return SliverGrid.extent(
          key: ValueKey(widget.controller.id),
          maxCrossAxisExtent: attrs.maxCrossAxisExtent,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          childAspectRatio: attrs.childAspectRatio,
          children: widget.children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
