import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/duit_impl/index.dart";

class DuitSingleChildScrollView extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitSingleChildScrollView({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return SingleChildScrollView(
      key: ValueKey(attributes.id),
      scrollDirection: attrs.axis(),
      reverse: attrs.getBool("reverse", defaultValue: false),
      primary: attrs.tryGetBool("primary"),
      padding: attrs.edgeInsets(),
      physics: attrs.scrollPhysics(),
      restorationId: attrs.tryGetString("restorationId"),
      clipBehavior: attrs.clipBehavior()!,
      keyboardDismissBehavior: attrs.keyboardDismissBehavior(
        defaultValue: ScrollViewKeyboardDismissBehavior.manual,
      ),
      dragStartBehavior: attrs.dragStartBehavior(
        defaultValue: DragStartBehavior.start,
      ),
      child: child,
    );
  }
}

class DuitControlledSingleChildScrollView extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

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
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: Key(widget.controller.id),
      scrollDirection: attributes.axis(),
      reverse: attributes.getBool("reverse", defaultValue: false),
      primary: attributes.tryGetBool("primary"),
      padding: attributes.edgeInsets(),
      physics: attributes.scrollPhysics(),
      restorationId: attributes.tryGetString("restorationId"),
      clipBehavior: attributes.clipBehavior()!,
      keyboardDismissBehavior: attributes.keyboardDismissBehavior(
        defaultValue: ScrollViewKeyboardDismissBehavior.manual,
      ),
      dragStartBehavior: attributes.dragStartBehavior(
        defaultValue: DragStartBehavior.start,
      ),
      child: widget.child,
    );
  }
}
