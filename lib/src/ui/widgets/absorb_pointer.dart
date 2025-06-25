import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitAbsorbPointer extends StatelessWidget {
  final Widget child;
  final ViewAttribute<AbsorbPointerAttributes> attributes;

  const DuitAbsorbPointer({
    super.key,
    required this.child,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return AbsorbPointer(
      key: Key(attributes.id),
      absorbing: attrs.absorbing,
      child: child,
    );
  }
}

class DuitControlledAbsorbPointer extends StatefulWidget {
  final Widget child;
  final UIElementController<AbsorbPointerAttributes> controller;

  const DuitControlledAbsorbPointer({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitControlledAbsorbPointer> createState() =>
      _DuitControlledAbsorbPointerState();
}

class _DuitControlledAbsorbPointerState
    extends State<DuitControlledAbsorbPointer>
    with
        ViewControllerChangeListener<DuitControlledAbsorbPointer,
            AbsorbPointerAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      key: Key(widget.controller.id),
      absorbing: attributes.absorbing,
      child: widget.child,
    );
  }
}
