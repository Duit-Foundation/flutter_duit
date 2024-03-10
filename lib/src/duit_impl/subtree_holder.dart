import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

mixin SubtreeHolder<T extends StatefulWidget> on State<T> {
  Widget? subtreeChild;
  UIElementController? _controller;

  void attachStateToController(UIElementController? controller, Widget child) {
    _controller = controller;
    subtreeChild = child;
  }

  Future<void> _listener() async {
    final layout = _controller?.attributes?.payload as SubtreeAttributes?;

    if (layout?.data != null) {
      final driver = _controller!.driver;
      final layoutTree = await parseLayout(
        layout!.data!,
        driver,
      );

      final newChild = layoutTree.render();
      setState(() {
        subtreeChild = newChild;
      });
    }
  }

  void _listenControllerUpdateStateEvent() {
    _controller?.addListener(_listener);
  }

  @override
  void didChangeDependencies() {
    _listenControllerUpdateStateEvent();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    super.dispose();
  }
}
