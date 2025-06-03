import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitOffstage extends StatelessWidget {
  final Widget child;
  final ViewAttribute<OffstageAttributes> attributes;

  const DuitOffstage({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Offstage(
      key: Key(attributes.id),
      offstage: attrs.offstage,
      child: child,
    );
  }
}

class DuitControlledOffstage extends StatefulWidget {
  final Widget child;
  final UIElementController<OffstageAttributes> controller;

  const DuitControlledOffstage({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledOffstage> createState() => _DuitControlledOffstageState();
}

class _DuitControlledOffstageState extends State<DuitControlledOffstage>
    with
        ViewControllerChangeListener<DuitControlledOffstage,
            OffstageAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      key: Key(widget.controller.id),
      offstage: attributes.offstage,
      child: widget.child,
    );
  }
}
