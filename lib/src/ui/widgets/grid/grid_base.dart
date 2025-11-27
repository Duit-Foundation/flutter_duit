import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";
import "package:flutter_duit/src/ui/widgets/grid_constructor.dart";

final class DuitGridView extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget> children;
  final GridConstructor constructor;

  const DuitGridView({
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

        return GridView(
          key: ValueKey(attributes.id),
          gridDelegate: delegate,
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool("reverse"),
          primary: attrs.tryGetBool("primary"),
          physics: attrs.scrollPhysics(),
          shrinkWrap: attrs.getBool("shrinkWrap"),
          padding: attrs.edgeInsets(),
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
          cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
          semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
          dragStartBehavior: attrs.dragStartBehavior(),
          keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
          clipBehavior: attrs.clipBehavior()!,
          restorationId: attrs.tryGetString("restorationId"),
          hitTestBehavior: attrs.hitTestBehavior(
            defaultValue: HitTestBehavior.opaque,
          ),
          children: children,
        );
      case GridConstructor.count:
        return GridView.count(
          key: ValueKey(attributes.id),
          crossAxisCount: attrs.getInt(
            key: "crossAxisCount",
            defaultValue: 1,
          ),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(
            key: "crossAxisSpacing",
            defaultValue: 0,
          ),
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool("reverse"),
          primary: attrs.tryGetBool("primary"),
          physics: attrs.scrollPhysics(),
          shrinkWrap: attrs.getBool("shrinkWrap"),
          padding: attrs.edgeInsets(),
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
          cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
          semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
          dragStartBehavior: attrs.dragStartBehavior(),
          keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
          clipBehavior: attrs.clipBehavior()!,
          restorationId: attrs.tryGetString("restorationId"),
          hitTestBehavior: attrs.hitTestBehavior(
            defaultValue: HitTestBehavior.opaque,
          ),
          children: children,
        );
      case GridConstructor.extent:
        return GridView.extent(
          key: ValueKey(attributes.id),
          maxCrossAxisExtent: attrs.getDouble(key: "maxCrossAxisExtent"),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(
            key: "crossAxisSpacing",
            defaultValue: 0,
          ),
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool("reverse"),
          primary: attrs.tryGetBool("primary"),
          physics: attrs.scrollPhysics(),
          shrinkWrap: attrs.getBool("shrinkWrap"),
          padding: attrs.edgeInsets(),
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
          cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
          semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
          dragStartBehavior: attrs.dragStartBehavior(),
          keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
          clipBehavior: attrs.clipBehavior()!,
          restorationId: attrs.tryGetString("restorationId"),
          hitTestBehavior: attrs.hitTestBehavior(
            defaultValue: HitTestBehavior.opaque,
          ),
          children: children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class DuitControlledGridView extends StatefulWidget {
  final UIElementController controller;
  final List<Widget> children;
  final GridConstructor constructor;

  const DuitControlledGridView({
    required this.controller,
    required this.children,
    required this.constructor,
    super.key,
  });

  @override
  State<DuitControlledGridView> createState() => _DuitControlledGridViewState();
}

class _DuitControlledGridViewState extends State<DuitControlledGridView>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = attributes;
    final constructor = GridConstructor.fromValue(
      attrs.getString(key: "constructor"),
    );

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
          throw UnimplementedError("SliverGridDelegate builder not found");
        }

        return GridView(
          key: ValueKey(widget.controller.id),
          gridDelegate: delegate,
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool("reverse"),
          primary: attrs.tryGetBool("primary"),
          physics: attrs.scrollPhysics(),
          shrinkWrap: attrs.getBool("shrinkWrap"),
          padding: attrs.edgeInsets(),
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
          cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
          semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
          dragStartBehavior: attrs.dragStartBehavior(),
          keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
          clipBehavior: attrs.clipBehavior()!,
          restorationId: attrs.tryGetString("restorationId"),
          hitTestBehavior: attrs.hitTestBehavior(
            defaultValue: HitTestBehavior.opaque,
          ),
          children: widget.children,
        );
      case GridConstructor.count:
        return GridView.count(
          key: ValueKey(widget.controller.id),
          crossAxisCount: attrs.getInt(
            key: "crossAxisCount",
            defaultValue: 1,
          ),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(
            key: "crossAxisSpacing",
            defaultValue: 0,
          ),
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool("reverse"),
          primary: attrs.tryGetBool("primary"),
          physics: attrs.scrollPhysics(),
          shrinkWrap: attrs.getBool("shrinkWrap"),
          padding: attrs.edgeInsets(),
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
          cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
          semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
          dragStartBehavior: attrs.dragStartBehavior(),
          keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
          clipBehavior: attrs.clipBehavior()!,
          restorationId: attrs.tryGetString("restorationId"),
          hitTestBehavior: attrs.hitTestBehavior(
            defaultValue: HitTestBehavior.opaque,
          ),
          children: widget.children,
        );
      case GridConstructor.extent:
        return GridView.extent(
          key: ValueKey(widget.controller.id),
          maxCrossAxisExtent: attrs.getDouble(key: "maxCrossAxisExtent"),
          mainAxisSpacing: attrs.getDouble(
            key: "mainAxisSpacing",
            defaultValue: 0,
          ),
          crossAxisSpacing: attrs.getDouble(
            key: "crossAxisSpacing",
            defaultValue: 0,
          ),
          scrollDirection: attrs.axis(),
          reverse: attrs.getBool("reverse"),
          primary: attrs.tryGetBool("primary"),
          physics: attrs.scrollPhysics(),
          shrinkWrap: attrs.getBool("shrinkWrap"),
          padding: attrs.edgeInsets(),
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
          cacheExtent: attrs.tryGetDouble(key: "cacheExtent"),
          semanticChildCount: attrs.tryGetInt(key: "semanticChildCount"),
          dragStartBehavior: attrs.dragStartBehavior(),
          keyboardDismissBehavior: attrs.keyboardDismissBehavior(),
          clipBehavior: attrs.clipBehavior()!,
          restorationId: attrs.tryGetString("restorationId"),
          hitTestBehavior: attrs.hitTestBehavior(
            defaultValue: HitTestBehavior.opaque,
          ),
          children: widget.children,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
