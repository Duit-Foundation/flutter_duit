import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

enum _TransformType {
  scale,
  rotate,
  translate,
  flip;

  static _TransformType fromString(String type) {
    return _TransformType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => _TransformType.scale,
    );
  }
}

class DuitTransform extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const DuitTransform({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );

    final type = _TransformType.fromString(attrs.getString(key: "type"));

    final transformData = DuitDataSource(attrs["data"]);

    switch (type) {
      case _TransformType.scale:
        return Transform.scale(
          key: Key(attributes.id),
          scale: transformData.tryGetDouble(key: "scale"),
          scaleX: transformData.tryGetDouble(key: "scaleX"),
          scaleY: transformData.tryGetDouble(key: "scaleY"),
          origin: transformData.offset(key: "origin"),
          alignment: transformData.alignment(),
          transformHitTests: attrs.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          child: child,
        );
      case _TransformType.rotate:
        return Transform.rotate(
          key: Key(attributes.id),
          angle: transformData.getDouble(key: "angle"),
          origin: transformData.offset(),
          alignment: transformData.alignment(),
          transformHitTests: transformData.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          child: child,
        );
      case _TransformType.translate:
        return Transform.translate(
          key: Key(attributes.id),
          offset: transformData.offset(defaultValue: Offset.zero)!,
          transformHitTests: transformData.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          child: child,
        );
      case _TransformType.flip:
        return Transform.flip(
          key: Key(attributes.id),
          flipX: transformData.getBool("flipX"),
          flipY: transformData.getBool("flipY"),
          transformHitTests: transformData.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          origin: transformData.offset(),
          child: child,
        );
    }
  }
}

class DuitControlledTransform extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final Widget child;

  const DuitControlledTransform({
    required this.child,
    required this.controller,
    super.key,
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
    final type = _TransformType.fromString(attrs.getString(key: "type"));

    final transformData = DuitDataSource(attrs["data"]);

    switch (type) {
      case _TransformType.scale:
        return Transform.scale(
          key: Key(widget.controller.id),
          scale: transformData.tryGetDouble(key: "scale"),
          scaleX: transformData.tryGetDouble(key: "scaleX"),
          scaleY: transformData.tryGetDouble(key: "scaleY"),
          origin: transformData.offset(key: "origin"),
          alignment: transformData.alignment(),
          transformHitTests: transformData.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          child: widget.child,
        );
      case _TransformType.rotate:
        return Transform.rotate(
          key: Key(widget.controller.id),
          angle: transformData.getDouble(key: "angle"),
          origin: transformData.offset(),
          alignment: transformData.alignment(),
          transformHitTests: transformData.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          child: widget.child,
        );
      case _TransformType.translate:
        return Transform.translate(
          key: Key(widget.controller.id),
          offset: transformData.offset(defaultValue: Offset.zero)!,
          transformHitTests: transformData.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          child: widget.child,
        );
      case _TransformType.flip:
        return Transform.flip(
          key: Key(widget.controller.id),
          flipX: transformData.getBool("flipX"),
          flipY: transformData.getBool("flipY"),
          transformHitTests: transformData.getBool(
            "transformHitTests",
            defaultValue: true,
          ),
          filterQuality: transformData.filterQuality(),
          origin: transformData.offset(),
          child: widget.child,
        );
    }
  }
}
