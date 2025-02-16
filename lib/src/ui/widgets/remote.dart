import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/subtree_holder.dart';

class DuitRemoteWidget extends StatefulWidget {
  final UIElementController controller;

  const DuitRemoteWidget({
    super.key,
    required this.controller,
  });

  @override
  State<DuitRemoteWidget> createState() => _DuitRemoteWidgetState();
}

class _DuitRemoteWidgetState extends State<DuitRemoteWidget>
    with SubtreeHolder<DuitRemoteWidget> {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
      const SizedBox.shrink(),
    );
    loadRemoteContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: Key(widget.controller.id),
      child: subtreeChild,
    );
  }
}
