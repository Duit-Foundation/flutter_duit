import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/controller/index.dart";

class DUITColumn extends StatelessWidget {
  final ViewAttributeWrapper? attributes;
  final List<Widget> children;

  const DUITColumn({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final state = attributes?.payload as ColumnAttributes?;
    return Column(
      mainAxisAlignment: state?.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: state?.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment:
          state?.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: state?.textDirection,
      verticalDirection: state?.verticalDirection ?? VerticalDirection.down,
      children: children,
    );
  }
}

class DUITControlledColumn<ColumnAttributes> extends StatefulWidget {
  final UIElementController<ColumnAttributes>? controller;
  final List<Widget> children;

  const DUITControlledColumn({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DUITControlledColumn> createState() => _DUITControlledColumnState();
}

class _DUITControlledColumnState extends State<DUITControlledColumn> {
  late ColumnAttributes? attributes;

  @override
  void initState() {
    attributes = widget.controller?.attributes?.payload as ColumnAttributes?;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.controller?.addListener(() {
      final newState =
          widget.controller?.attributes?.payload as ColumnAttributes?;

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
    return Column(
      mainAxisAlignment:
          attributes?.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: attributes?.mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment:
          attributes?.crossAxisAlignment ?? CrossAxisAlignment.center,
      textDirection: attributes?.textDirection,
      verticalDirection:
          attributes?.verticalDirection ?? VerticalDirection.down,
      children: widget.children,
    );
  }
}
