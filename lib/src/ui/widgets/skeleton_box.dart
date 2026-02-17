import "package:flutter/material.dart";
import "package:flutter_duit/kernel_api.dart";
import "package:flutter_duit/src/duit_impl/subtree_holder.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";

class DuitSkeletonBox extends StatelessWidget {
  final ViewAttribute attributes;

  const DuitSkeletonBox({
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final customSkeletonBuilder =
        DuitViewContext.of(context).customSkeletonBuilder;

    if (customSkeletonBuilder != null) {
      return customSkeletonBuilder(
        attributes.payload.tryGetDouble(key: "width") ?? 0,
        attributes.payload.tryGetDouble(key: "height") ?? 0,
      );
    }

    return Placeholder(
      color: Colors.red,
      child: SizedBox(
        width: attributes.payload.tryGetDouble(key: "width"),
        height: attributes.payload.tryGetDouble(key: "height"),
        child: const Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Default skeleton"),
          ),
        ),
      ),
    );
  }
}

class DuitSkeletonizedContent extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitSkeletonizedContent({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitSkeletonizedContent> createState() =>
      _DuitSkeletonizedContentState();
}

class _DuitSkeletonizedContentState extends State<DuitSkeletonizedContent>
    with SubtreeHolder {
  @override
  void initState() {
    attachStateToController(widget.controller, widget.child);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      child: subtreeChild,
    );
  }
}
