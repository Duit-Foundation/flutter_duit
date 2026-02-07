import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

const _kDrag = 0.0000135;

class DuitControlledInteractiveViewer extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledInteractiveViewer({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledInteractiveViewer> createState() =>
      _DuitControlledInteractiveViewerState();
}

class _DuitControlledInteractiveViewerState
    extends State<DuitControlledInteractiveViewer>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  void _onInteractionEnd(ScaleEndDetails _) {
    widget.controller.performAction(
      attributes.getAction("onInteractionEnd"),
    );
  }

  void _onInteractionStart(ScaleStartDetails _) {
    widget.controller.performAction(
      attributes.getAction("onInteractionStart"),
    );
  }

  void _onInteractionUpdate(ScaleUpdateDetails _) {
    widget.controller.performAction(
      attributes.getAction("onInteractionUpdate"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      key: ValueKey(widget.controller.id),
      // TODO: add pan axis
      // TODO: add transformation controller
      onInteractionStart: _onInteractionStart,
      onInteractionUpdate: _onInteractionUpdate,
      onInteractionEnd: _onInteractionEnd,
      panEnabled: attributes.getBool("panEnabled", defaultValue: true),
      scaleEnabled: attributes.getBool("scaleEnabled", defaultValue: true),
      minScale: attributes.getDouble(key: "minScale", defaultValue: 0.8),
      maxScale: attributes.getDouble(key: "maxScale", defaultValue: 2.5),
      boundaryMargin: attributes.edgeInsets(
        key: "boundaryMargin",
        defaultValue: EdgeInsets.zero,
      )!,
      constrained: attributes.getBool("constrained", defaultValue: true),
      clipBehavior: attributes.clipBehavior(
        defaultValue: Clip.hardEdge,
      )!,
      alignment: attributes.alignment(),
      scaleFactor: attributes.getDouble(
        key: "scaleFactor",
        defaultValue: kDefaultMouseScrollToScaleFactor,
      ),
      trackpadScrollCausesScale: attributes.getBool(
        "trackpadScrollCausesScale",
        defaultValue: false,
      ),
      interactionEndFrictionCoefficient: attributes.getDouble(
        key: "interactionEndFrictionCoefficient",
        defaultValue: _kDrag,
      ),
      child: widget.child,
    );
  }
}
