import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

import 'list_view_context.dart';

class DuitListViewContextProvider extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitListViewContextProvider({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitListViewContextProvider> createState() =>
      _DuitListViewContextProviderState();
}

class _DuitListViewContextProviderState
    extends State<DuitListViewContextProvider>
    with
        ViewControllerChangeListener<DuitListViewContextProvider,
            ListViewAttributes> {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DuitListViewContext(
      childrenArray: attributes?.childObjects ?? [],
      controller: widget.controller,
      len: attributes?.childObjects?.length ?? 0,
      child: widget.child,
    );
  }
}
