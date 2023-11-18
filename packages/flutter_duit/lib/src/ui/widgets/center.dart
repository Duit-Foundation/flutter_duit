import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";

class DUITCenter extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final Widget child;

  const DUITCenter({
    super.key,
    required this.attributes,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as CenterAttributes?;
    return Center(
      widthFactor: state?.widthFactor,
      heightFactor: state?.heightFactor,
      child: child,
    );
  }
}

class DUITControlledCenter<CenterAttributes> extends StatefulWidget {
  final UIElementController<CenterAttributes>? controller;
  final Widget child;

  const DUITControlledCenter({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DUITControlledCenter> createState() => _DUITControlledCenterState();
}

class _DUITControlledCenterState extends State<DUITControlledCenter> {
  late CenterAttributes? attributes;

  @override
  void initState() {
    attributes = widget.controller?.attributes?.payload as CenterAttributes?;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.controller?.addListener(() {
      final newState =
          widget.controller?.attributes?.payload as CenterAttributes?;

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
    return Center(
      widthFactor: attributes?.widthFactor,
      heightFactor: attributes?.heightFactor,
      child: widget.child,
    );
  }
}
