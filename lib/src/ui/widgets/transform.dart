import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitTransform extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitTransform({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;

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

class DuitControlledTransform extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

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
    if (attributes is ScaleTransform) {
      final attrs = attributes as ScaleTransform;
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

    if (attributes is RotateTransform) {
      final attrs = attributes as RotateTransform;
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

    if (attributes is TranslateTransform) {
      final attrs = attributes as TranslateTransform;
      return Transform.translate(
        key: Key(widget.controller.id),
        offset: attrs.offset ?? Offset.zero,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: widget.child,
      );
    }

    if (attributes is FlipTransform) {
      final attrs = attributes as FlipTransform;
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
