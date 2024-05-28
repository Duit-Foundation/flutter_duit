import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/index.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitTransform extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute<DuitAttributes> attributes;
  final Widget child;

  const DuitTransform({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithAttributes(
      context,
      attributes.payload,
    );

    if (attrs is ScaleTransform) {
      return Transform.scale(
        key: Key(attributes.id),
        scale: attrs.scale,
        scaleX: attrs.scaleX,
        scaleY: attrs.scaleY,
        origin: attrs.origin,
        alignment: attrs.alignment,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: child,
      );
    }

    if (attrs is RotateTransform) {
      return Transform.rotate(
        key: Key(attributes.id),
        angle: attrs.angle ?? 0,
        origin: attrs.origin,
        alignment: attrs.alignment,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: child,
      );
    }

    if (attrs is TranslateTransform) {
      return Transform.translate(
        key: Key(attributes.id),
        offset: attrs.offset ?? Offset.zero,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: child,
      );
    }

    if (attrs is FlipTransform) {
      return Transform.flip(
        key: Key(attributes.id),
        flipX: attrs.flipX ?? false,
        flipY: attrs.flipY ?? false,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        origin: attrs.origin,
        child: child,
      );
    }

    return SizedBox.shrink(child: child);
  }
}

class DuitControlledTransform extends StatefulWidget with AnimatedAttributes {
  final Widget child;
  final UIElementController<DuitAttributes> controller;

  const DuitControlledTransform({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledTransform> createState() =>
      _DuitControlledTransformState();
}

class _DuitControlledTransformState extends State<DuitControlledTransform>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithController(
      context,
      widget.controller,
    );

    if (attrs is ScaleTransform) {
      return Transform.scale(
        key: Key(widget.controller.id),
        scale: attrs.scale,
        scaleX: attrs.scaleX,
        scaleY: attrs.scaleY,
        origin: attrs.origin,
        alignment: attrs.alignment,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: widget.child,
      );
    }

    if (attrs is RotateTransform) {
      return Transform.rotate(
        key: Key(widget.controller.id),
        angle: attrs.angle ?? 0,
        origin: attrs.origin,
        alignment: attrs.alignment,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: widget.child,
      );
    }

    if (attrs is TranslateTransform) {
      return Transform.translate(
        key: Key(widget.controller.id),
        offset: attrs.offset ?? Offset.zero,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: widget.child,
      );
    }

    if (attrs is FlipTransform) {
      return Transform.flip(
        key: Key(widget.controller.id),
        flipX: attrs.flipX ?? false,
        flipY: attrs.flipY ?? false,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        origin: attrs.origin,
        child: widget.child,
      );
    }

    return SizedBox.shrink(
      child: widget.child,
    );
  }
}
