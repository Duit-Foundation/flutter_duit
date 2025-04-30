import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/subtree_holder.dart';

class DuitRemoteSubtree extends StatefulWidget {
  final UIElementController controller;

  const DuitRemoteSubtree({
    super.key,
    required this.controller,
  });

  @override
  State<DuitRemoteSubtree> createState() => _DuitRemoteSubtreeState();
}

class _DuitRemoteSubtreeState extends State<DuitRemoteSubtree>
    with SubtreeHolder<DuitRemoteSubtree> {
  @override
  void initState() {
    attachStateToController(
      widget.controller,
      const SizedBox.shrink(),
      remote: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(widget.controller.id),
      child: subtreeChild,
    );
  }
}
