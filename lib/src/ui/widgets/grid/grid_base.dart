import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";

final class DuitGridView extends StatelessWidget {
  final ViewAttribute<GridViewAttributes> attributes;
  final List<Widget> children;

  const DuitGridView({
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

        return GridView(
          key: ValueKey(attributes.id),
          gridDelegate: delegate,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          primary: attrs.primary,
          physics: attrs.physics,
          shrinkWrap: attrs.shrinkWrap,
          padding: attrs.padding,
          addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
          addRepaintBoundaries: attrs.addRepaintBoundaries,
          addSemanticIndexes: attrs.addSemanticIndexes,
          cacheExtent: attrs.cacheExtent,
          semanticChildCount: attrs.semanticChildCount,
          dragStartBehavior: attrs.dragStartBehavior,
          keyboardDismissBehavior: attrs.keyboardDismissBehavior,
          clipBehavior: attrs.clipBehavior,
          restorationId: attrs.restorationId,
          hitTestBehavior: attrs.hitTestBehavior,
          children: children,
        );
      case GridConstructor.count:
        return GridView.count(
          key: ValueKey(attributes.id),
          crossAxisCount: attrs.crossAxisCount,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          primary: attrs.primary,
          physics: attrs.physics,
          shrinkWrap: attrs.shrinkWrap,
          padding: attrs.padding,
          addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
          addRepaintBoundaries: attrs.addRepaintBoundaries,
          addSemanticIndexes: attrs.addSemanticIndexes,
          cacheExtent: attrs.cacheExtent,
          semanticChildCount: attrs.semanticChildCount,
          dragStartBehavior: attrs.dragStartBehavior,
          keyboardDismissBehavior: attrs.keyboardDismissBehavior,
          clipBehavior: attrs.clipBehavior,
          restorationId: attrs.restorationId,
          hitTestBehavior: attrs.hitTestBehavior,
          children: children,
        );
      case GridConstructor.extent:
        return GridView.extent(
          key: ValueKey(attributes.id),
          maxCrossAxisExtent: attrs.maxCrossAxisExtent,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          primary: attrs.primary,
          physics: attrs.physics,
          shrinkWrap: attrs.shrinkWrap,
          padding: attrs.padding,
          addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
          addRepaintBoundaries: attrs.addRepaintBoundaries,
          addSemanticIndexes: attrs.addSemanticIndexes,
          cacheExtent: attrs.cacheExtent,
          semanticChildCount: attrs.semanticChildCount,
          dragStartBehavior: attrs.dragStartBehavior,
          keyboardDismissBehavior: attrs.keyboardDismissBehavior,
          clipBehavior: attrs.clipBehavior,
          restorationId: attrs.restorationId,
          hitTestBehavior: attrs.hitTestBehavior,
          children: children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class DuitControlledGridView extends StatefulWidget {
  final UIElementController<GridViewAttributes> controller;
  final List<Widget> children;

  const DuitControlledGridView({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledGridView> createState() => _DuitControlledGridViewState();
}

class _DuitControlledGridViewState extends State<DuitControlledGridView>
    with
        ViewControllerChangeListener<DuitControlledGridView,
            GridViewAttributes> {
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

        return GridView(
          key: ValueKey(widget.controller.id),
          gridDelegate: delegate,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          primary: attrs.primary,
          physics: attrs.physics,
          shrinkWrap: attrs.shrinkWrap,
          padding: attrs.padding,
          addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
          addRepaintBoundaries: attrs.addRepaintBoundaries,
          addSemanticIndexes: attrs.addSemanticIndexes,
          cacheExtent: attrs.cacheExtent,
          semanticChildCount: attrs.semanticChildCount,
          dragStartBehavior: attrs.dragStartBehavior,
          keyboardDismissBehavior: attrs.keyboardDismissBehavior,
          clipBehavior: attrs.clipBehavior,
          restorationId: attrs.restorationId,
          hitTestBehavior: attrs.hitTestBehavior,
          children: widget.children,
        );
      case GridConstructor.count:
        return GridView.count(
          key: ValueKey(widget.controller.id),
          crossAxisCount: attrs.crossAxisCount,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          primary: attrs.primary,
          physics: attrs.physics,
          shrinkWrap: attrs.shrinkWrap,
          padding: attrs.padding,
          addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
          addRepaintBoundaries: attrs.addRepaintBoundaries,
          addSemanticIndexes: attrs.addSemanticIndexes,
          cacheExtent: attrs.cacheExtent,
          semanticChildCount: attrs.semanticChildCount,
          dragStartBehavior: attrs.dragStartBehavior,
          keyboardDismissBehavior: attrs.keyboardDismissBehavior,
          clipBehavior: attrs.clipBehavior,
          restorationId: attrs.restorationId,
          hitTestBehavior: attrs.hitTestBehavior,
          children: widget.children,
        );
      case GridConstructor.extent:
        return GridView.extent(
          key: ValueKey(widget.controller.id),
          maxCrossAxisExtent: attrs.maxCrossAxisExtent,
          mainAxisSpacing: attrs.mainAxisSpacing,
          crossAxisSpacing: attrs.crossAxisSpacing,
          scrollDirection: attrs.scrollDirection,
          reverse: attrs.reverse,
          primary: attrs.primary,
          physics: attrs.physics,
          shrinkWrap: attrs.shrinkWrap,
          padding: attrs.padding,
          addAutomaticKeepAlives: attrs.addAutomaticKeepAlives,
          addRepaintBoundaries: attrs.addRepaintBoundaries,
          addSemanticIndexes: attrs.addSemanticIndexes,
          cacheExtent: attrs.cacheExtent,
          semanticChildCount: attrs.semanticChildCount,
          dragStartBehavior: attrs.dragStartBehavior,
          keyboardDismissBehavior: attrs.keyboardDismissBehavior,
          clipBehavior: attrs.clipBehavior,
          restorationId: attrs.restorationId,
          hitTestBehavior: attrs.hitTestBehavior,
          children: widget.children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
