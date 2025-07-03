import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/view_context.dart';
import 'package:flutter_duit/src/ui/widgets/tile.dart';

class DuitSliverGridBuilder extends StatefulWidget {
  final UIElementController controller;

  const DuitSliverGridBuilder({
    super.key,
    required this.controller,
  });

  @override
  State<DuitSliverGridBuilder> createState() => _DuitSliverGridBuilderState();
}

class _DuitSliverGridBuilderState extends State<DuitSliverGridBuilder>
    with ViewControllerChangeListener, ScrollUtils, OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    attachOnScrollCallback(widget.controller);
    super.initState();
  }

  Widget? _buildItem(BuildContext context, int index) {
    final item = attributes.childObjects()[index];

    final driver = widget.controller.driver;

    return buildOutOfBoundWidget(
      item,
      driver,
      (child) => DuitTile(
        id: item?["id"],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SliverGridDelegate delegate;
    final viewCtx = DuitViewContext.of(context);

    final delegateBuilder =
        viewCtx.sliverGridDelegatesRegistry[
        attributes.getString(key: "sliverGridDelegateKey")];

    if (delegateBuilder != null) {
      delegate = delegateBuilder.call(
        attributes["sliverGridDelegateOptions"] ?? const <String, dynamic>{},
      );
    } else {
      throw ArgumentError(
        "SliverGridDelegate builder not found in DuitViewContext",
      );
    }

    // Reset the end-of-list flag to allow loading more data if the grid is rebuilt
    // (e.g., when new items are added to the list)
    isEOL = false;
    return SliverGrid.builder(
      key: Key(widget.controller.id),
      gridDelegate: delegate,
      itemBuilder: _buildItem,
      itemCount: attributes.childObjects().length,
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
    );
  }
}
