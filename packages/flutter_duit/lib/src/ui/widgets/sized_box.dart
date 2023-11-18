import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";

class DUITSizedBox extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DUITSizedBox({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as SizedBoxAttributes?;
    return SizedBox(
      width: state?.width,
      height: state?.height,
      child: child,
    );
  }
}

class DUITControlledSizedBox<SizedBoxAttributes> extends StatefulWidget {
  final UIElementController<SizedBoxAttributes>? controller;
  final Widget child;

  const DUITControlledSizedBox({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DUITControlledSizedBox> createState() => _DUITControlledSizedBoxState();
}

class _DUITControlledSizedBoxState extends State<DUITControlledSizedBox> {
  late SizedBoxAttributes? attributes;

  @override
  void initState() {
    attributes = widget.controller?.attributes?.payload as SizedBoxAttributes?;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.controller?.addListener(() {
      final newState =
          widget.controller?.attributes?.payload as SizedBoxAttributes?;

      if (newState != null) {
        setState(() {
          attributes = attributes?.copyWith(newState);
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: attributes?.width,
      height: attributes?.height,
      child: widget.child,
    );
  }
}
