import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";
import "package:flutter_duit/src/ui/widgets/grid_constructor.dart";

final class DuitSliverGrid extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;
  final GridConstructor constructor;

  const DuitSliverGrid({
    required this.attributes,
    required this.children,
    required this.constructor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    switch (constructor) {
      case GridConstructor.common:
        SliverGridDelegate delegate;
        final viewCtx = DuitViewContext.of(context);

        final delegateBuilder = viewCtx.sliverGridDelegatesRegistry[
            attrs.getString(key: "sliverGridDelegateKey")];

        if (delegateBuilder != null) {
          delegate = delegateBuilder.call(
            attrs["sliverGridDelegateOptions"] ?? const <String, dynamic>{},
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
          ),
        );
      case GridConstructor.count:
        return SliverGrid.count(
          key: ValueKey(attributes.id),
          crossAxisCount: attrs.getInt(
            key: "crossAxisCount",
            defaultValue: 2,
          ),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(key: "crossAxisSpacing"),
          childAspectRatio: attrs.getDouble(
            key: "childAspectRatio",
            defaultValue: 1.0,
          ),
          children: children,
        );
      case GridConstructor.extent:
        return SliverGrid.extent(
          key: ValueKey(attributes.id),
          maxCrossAxisExtent: attrs.getDouble(
            key: "maxCrossAxisExtent",
            defaultValue: 0,
          ),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(key: "crossAxisSpacing"),
          childAspectRatio: attrs.getDouble(
            key: "childAspectRatio",
            defaultValue: 1.0,
          ),
          children: children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class DuitControlledSliverGrid extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;
  final GridConstructor constructor;

  const DuitControlledSliverGrid({
    required this.controller,
    required this.children,
    required this.constructor,
    super.key,
  });

  @override
  State<DuitControlledSliverGrid> createState() =>
      _DuitControlledSliverGridState();
}

class _DuitControlledSliverGridState extends State<DuitControlledSliverGrid>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = attributes;
    switch (widget.constructor) {
      case GridConstructor.common:
        SliverGridDelegate delegate;
        final viewCtx = DuitViewContext.of(context);

        final delegateBuilder = viewCtx.sliverGridDelegatesRegistry[
            attrs.getString(key: "sliverGridDelegateKey")];

        if (delegateBuilder != null) {
          delegate = delegateBuilder.call(
            attrs["sliverGridDelegateOptions"] ?? const <String, dynamic>{},
          );
        } else {
          throw ArgumentError(
            "SliverGridDelegate builder not found in DuitViewContext",
          );
        }

        return SliverGrid(
          key: ValueKey(widget.controller.id),
          gridDelegate: delegate,
          delegate: SliverChildListDelegate(
            widget.children,
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
          ),
        );
      case GridConstructor.count:
        return SliverGrid.count(
          key: ValueKey(widget.controller.id),
          crossAxisCount: attrs.getInt(
            key: "crossAxisCount",
            defaultValue: 2,
          ),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(
            key: "crossAxisSpacing",
            defaultValue: 0,
          ),
          childAspectRatio: attrs.getDouble(
            key: "childAspectRatio",
            defaultValue: 1.0,
          ),
          children: widget.children,
        );
      case GridConstructor.extent:
        return SliverGrid.extent(
          key: ValueKey(widget.controller.id),
          maxCrossAxisExtent: attrs.getDouble(
            key: "maxCrossAxisExtent",
            defaultValue: 0,
          ),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(key: "crossAxisSpacing"),
          childAspectRatio: attrs.getDouble(
            key: "childAspectRatio",
            defaultValue: 1.0,
          ),
          children: widget.children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
