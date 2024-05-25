import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitSingleChildScrollView extends StatelessWidget {
  final Widget child;
  final ViewAttribute attributes;

  const DuitSingleChildScrollView({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload as SingleChildScrollviewAttributes;
    return SingleChildScrollView(
      scrollDirection: attrs.scrollDirection ?? Axis.vertical,
      reverse: attrs.reverse ?? false,
      primary: attrs.primary,
      padding: attrs.padding,
      physics: attrs.physics,
      restorationId: attrs.restorationId,
      clipBehavior: attrs.clipBehavior ?? Clip.hardEdge,
      keyboardDismissBehavior: attrs.keyboardDismissBehavior ??
          ScrollViewKeyboardDismissBehavior.manual,
      dragStartBehavior: attrs.dragStartBehavior ?? DragStartBehavior.start,
      child: child,
    );
  }
}

class DuitControlledSingleChildScrollView extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitControlledSingleChildScrollView({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledSingleChildScrollView> createState() =>
      _DuitControlledSingleChildScrollViewState();
}

class _DuitControlledSingleChildScrollViewState
    extends State<DuitControlledSingleChildScrollView>
    with
        ViewControllerChangeListener<DuitControlledSingleChildScrollView,
            SingleChildScrollviewAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: Key(widget.controller.id),
      scrollDirection: attributes.scrollDirection ?? Axis.vertical,
      reverse: attributes.reverse ?? false,
      primary: attributes.primary,
      padding: attributes.padding,
      physics: attributes.physics,
      restorationId: attributes.restorationId,
      clipBehavior: attributes.clipBehavior ?? Clip.hardEdge,
      keyboardDismissBehavior: attributes.keyboardDismissBehavior ??
          ScrollViewKeyboardDismissBehavior.manual,
      dragStartBehavior:
          attributes.dragStartBehavior ?? DragStartBehavior.start,
      child: widget.child,
    );
  }
}
