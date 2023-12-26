import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";

class DuitTransform extends StatelessWidget {
  final ViewAttributeWrapper attributes;
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
      print(attrs.angle);
      return Transform.rotate(
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
        offset: attrs.offset ?? Offset.zero,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: child,
      );
    }

    if (attrs is FlipTransform) {
      return Transform.flip(
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
  final UIElementController? controller;

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
        offset: attrs.offset ?? Offset.zero,
        transformHitTests: attrs.transformHitTests,
        filterQuality: attrs.filterQuality,
        child: widget.child,
      );
    }

    if (attributes is FlipTransform) {
      final attrs = attributes as FlipTransform;
      return Transform.flip(
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
