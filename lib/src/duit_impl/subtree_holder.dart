import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

mixin SubtreeHolder<T extends StatefulWidget> on State<T> {
  late Widget subtreeChild;
  late UIElementController _controller;
  late bool isRemote;

  void attachStateToController(
    UIElementController controller,
    Widget child, {
    bool remote = false,
  }) {
    _controller = controller;
    subtreeChild = child;
    isRemote = remote;

    if (isRemote) {
      _loadRemoteContent();
    }
  }

  Future<void> _listener() async {
    final driver = _controller.driver;
    final attrs = _controller.attributes.payload;

    if (isRemote) {
      try {
        if (attrs["data"] != null) {
          final layoutTree = await parseLayout(
            attrs["data"],
            driver,
          );

          final newChild = layoutTree.render();
          setState(() {
            subtreeChild = newChild;
          });
        }
      } catch (e, s) {
        driver.logger?.error(
          "Failed to handle remote subtree update",
          error: e,
          stackTrace: s,
        );
        rethrow;
      }
    } else {
      try {
        if (attrs["data"] != null) {
          final layoutTree = await parseLayout(
            attrs["data"],
            driver,
          );

          final newChild = layoutTree.render();
          setState(() {
            subtreeChild = newChild;
          });
        }
      } catch (e, s) {
        driver.logger?.error(
          "Failed to handle subtree update",
          error: e,
          stackTrace: s,
        );
      }
    }
  }

  Future<void> _loadRemoteContent() async {
    final remoteWidgetData = DuitDataSource(_controller.attributes.payload);

    final driver = _controller.driver;
    try {
      final body = driver.preparePayload(
        remoteWidgetData.getActionDependencies(),
      );

      final layout = await driver.transport?.request(
        remoteWidgetData.getString(key: "downloadPath"),
        remoteWidgetData["meta"] ?? const {},
        body,
      );

      if (layout != null) {
        final layoutTree = await parseLayout(
          layout,
          driver,
        );

        final newChild = layoutTree.render();
        setState(() {
          subtreeChild = newChild;
        });
      }
    } catch (e, s) {
      driver.logger?.error(
        "Failed to load remote widget",
        error: e,
        stackTrace: s,
      );
    }
  }

  void _listenControllerUpdateStateEvent() {
    _controller.addListener(_listener);
  }

  @override
  void didChangeDependencies() {
    _listenControllerUpdateStateEvent();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listener)
      ..detach();
    super.dispose();
  }
}
