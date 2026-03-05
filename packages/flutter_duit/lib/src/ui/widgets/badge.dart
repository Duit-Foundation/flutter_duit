import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

enum BadgeVariant {
  common,
  count;

  static BadgeVariant fromValue(value) {
    return switch (value) {
      String() => _strMap[value] ?? BadgeVariant.common,
      int() => _intMap[value] ?? BadgeVariant.common,
      _ => BadgeVariant.common,
    };
  }

  static const _strMap = <String, BadgeVariant>{
    "common": BadgeVariant.common,
    "count": BadgeVariant.count,
  };

  static const _intMap = <int, BadgeVariant>{
    0: BadgeVariant.common,
    1: BadgeVariant.count,
  };
}

class DuitBadge extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final List<Widget?> children;

  const DuitBadge({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(
      context,
      attributes.payload,
    );
    final variant = BadgeVariant.fromValue(attrs["variant"]);
    return switch (variant) {
      BadgeVariant.common => Badge(
          key: ValueKey(attributes.id),
          backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
          textColor: attrs.tryParseColor(key: "textColor"),
          smallSize: attrs.tryGetDouble(key: "smallSize"),
          largeSize: attrs.tryGetDouble(key: "largeSize"),
          textStyle: attrs.textStyle(key: "textStyle"),
          padding: attrs.edgeInsets(),
          alignment: attrs.alignment(),
          offset: attrs.offset(),
          isLabelVisible: attrs.getBool(
            "isLabelVisible",
            defaultValue: true,
          ),
          label: children.elementAtOrNull(1),
          child: children.elementAtOrNull(0),
        ),
      BadgeVariant.count => Badge.count(
          key: ValueKey(attributes.id),
          count: attrs.getInt(key: "count"),
          backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
          textColor: attrs.tryParseColor(key: "textColor"),
          smallSize: attrs.tryGetDouble(key: "smallSize"),
          largeSize: attrs.tryGetDouble(key: "largeSize"),
          textStyle: attrs.textStyle(key: "textStyle"),
          padding: attrs.edgeInsets(),
          alignment: attrs.alignment(),
          offset: attrs.offset(),
          isLabelVisible: attrs.getBool(
            "isLabelVisible",
            defaultValue: true,
          ),
          //TODO: Implement maxCount prop on Flutter version bump
          child: children.elementAtOrNull(0),
        ),
    };
  }
}

class DuitControlledBadge extends StatefulWidget with AnimatedAttributes {
  final UIElementController controller;
  final List<Widget?> children;

  const DuitControlledBadge({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledBadge> createState() => _DuitControlledBadgeState();
}

class _DuitControlledBadgeState extends State<DuitControlledBadge>
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
    final variant = BadgeVariant.fromValue(attrs["variant"]);
    return switch (variant) {
      BadgeVariant.common => Badge(
          key: ValueKey(widget.controller.id),
          backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
          textColor: attrs.tryParseColor(key: "textColor"),
          smallSize: attrs.tryGetDouble(key: "smallSize"),
          largeSize: attrs.tryGetDouble(key: "largeSize"),
          textStyle: attrs.textStyle(key: "textStyle"),
          padding: attrs.edgeInsets(),
          alignment: attrs.alignment(),
          offset: attrs.offset(),
          isLabelVisible: attrs.getBool(
            "isLabelVisible",
            defaultValue: true,
          ),
          label: widget.children.elementAtOrNull(1),
          child: widget.children.elementAtOrNull(0),
        ),
      BadgeVariant.count => Badge.count(
          key: ValueKey(widget.controller.id),
          count: attrs.getInt(key: "count"),
          backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
          textColor: attrs.tryParseColor(key: "textColor"),
          smallSize: attrs.tryGetDouble(key: "smallSize"),
          largeSize: attrs.tryGetDouble(key: "largeSize"),
          textStyle: attrs.textStyle(key: "textStyle"),
          padding: attrs.edgeInsets(),
          alignment: attrs.alignment(),
          offset: attrs.offset(),
          isLabelVisible: attrs.getBool(
            "isLabelVisible",
            defaultValue: true,
          ),
          //TODO: Implement maxCount prop on Flutter version bump
          child: widget.children.elementAtOrNull(0),
        ),
    };
  }
}
