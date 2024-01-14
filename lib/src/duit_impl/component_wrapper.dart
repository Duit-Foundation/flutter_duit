import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/attributes/index.dart";

///Wraps a subtree of component widgets and controls its updating
class DuitComponentWrapper extends StatefulWidget {
  final Widget child;
  final UIElementController controller;

  const DuitComponentWrapper({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<DuitComponentWrapper> createState() => _DuitComponentWrapperState();
}

class _DuitComponentWrapperState extends State<DuitComponentWrapper> {
  Widget? _child;

  void _listener() async {
    final attributes =
        widget.controller.attributes?.payload as ComponentAttributes?;

    if (attributes != null) {
      final layoutTree = await attributes.data?.parse();

      if (layoutTree != null) {
        final newChild = layoutTree.render();
        setState(() {
          _child = newChild;
        });
      }
    }
  }

  @override
  void initState() {
    _child = widget.child;
    widget.controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _child ?? const SizedBox.shrink();
  }
}
