import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitTransform extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitTransform({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      DuitDataSource(attributes.payload),
    );

    return const SizedBox.shrink();

    // if (attrs is ScaleTransform) {
    //   return Transform.scale(
    //     key: Key(attributes.id),
    //     scale: attrs.tryGetDouble(key: "scale"),
    //     scaleX: attrs.tryGetDouble(key: "scaleX"),
    //     scaleY: attrs.tryGetDouble(key: "scaleY"),
    //     origin: attrs.offset(key: "origin"),
    //     alignment: attrs.alignment(),
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     filterQuality: attrs.filterQuality(),
    //     child: child,
    //   );
    // }

    // if (attrs is RotateTransform) {
    //   return Transform.rotate(
    //     key: Key(attributes.id),
    //     angle: attrs.getDouble(key: "angle"),
    //     origin: attrs.offset(key: "origin"),
    //     alignment: attrs.alignment(),
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     child: child,
    //   );
    // }

    // if (attrs is TranslateTransform) {
    //   return Transform.translate(
    //     key: Key(attributes.id),
    //     offset: attrs.offset(defaultValue: Offset.zero) as Offset,
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     filterQuality: attrs.filterQuality(),
    //     child: child,
    //   );
    // }

    // if (attrs is FlipTransform) {
    //   return Transform.flip(
    //     key: Key(attributes.id),
    //     flipX: attrs.getBool("flipX", defaultValue: false),
    //     flipY: attrs.getBool("flipY", defaultValue: false),
    //     origin: attrs.offset(key: "origin"),
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     child: child,
    //   );
    // }

    // return SizedBox.shrink(
    //   child: child,
    // );
  }
}

class DuitControlledTransform extends StatefulWidget with AnimatedAttributes {
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
    final attrs = widget.mergeWithDataSource(
      context,
      attributes,
    );

    return const SizedBox.shrink();

    // if (attrs is ScaleTransform) {
    //   return Transform.scale(
    //     key: Key(widget.controller.id),
    //     scale: attrs.tryGetDouble(key: "scale"),
    //     scaleX: attrs.tryGetDouble(key: "scaleX"),
    //     scaleY: attrs.tryGetDouble(key: "scaleY"),
    //     origin: attrs.offset(key: "origin"),
    //     alignment: attrs.alignment(),
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     filterQuality: attrs.filterQuality(),
    //     child: widget.child,
    //   );
    // }

    // if (attrs is RotateTransform) {
    //   return Transform.rotate(
    //     key: Key(widget.controller.id),
    //     angle: attrs.getDouble(key: "angle"),
    //     alignment: attrs.alignment(),
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     filterQuality: attrs.filterQuality(),
    //     child: widget.child,
    //   );
    // }

    // if (attrs is TranslateTransform) {
    //   return Transform.translate(
    //     key: Key(widget.controller.id),
    //     offset: attrs.offset(defaultValue: Offset.zero) as Offset,
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     filterQuality: attrs.filterQuality(),
    //     child: widget.child,
    //   );
    // }

    // if (attrs is FlipTransform) {
    //   return Transform.flip(
    //     key: Key(widget.controller.id),
    //     flipX: attrs.getBool("flipX", defaultValue: false),
    //     flipY: attrs.getBool("flipY", defaultValue: false),
    //     transformHitTests: attrs.getBool(
    //       "transformHitTests",
    //       defaultValue: true,
    //     ),
    //     filterQuality: attrs.filterQuality(),
    //     origin: attrs.offset(key: "origin"),
    //     child: widget.child,
    //   );
    // }

    // return SizedBox.shrink(
    //   child: widget.child,
    // );
  }
}
