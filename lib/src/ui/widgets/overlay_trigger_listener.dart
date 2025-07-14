import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/controller/data.dart';
import 'package:flutter_duit/src/controller/index.dart';

class DuitOverlayTriggerListener extends StatefulWidget {
  final UIDriver driver;
  final Widget? child;

  const DuitOverlayTriggerListener({
    super.key,
    required this.driver,
    required this.child,
  });

  @override
  State<DuitOverlayTriggerListener> createState() =>
      _DuitOverlayTriggerListenerState();
}

class _DuitOverlayTriggerListenerState extends State<DuitOverlayTriggerListener>
    with ViewControllerChangeListener, OutOfBoundWidgetBuilder {
  late final UIElementController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ViewController(
      id: overlayTriggerId,
      type: overlayTriggerId,
      driver: widget.driver,
      attributes: ViewAttribute.from(
        overlayTriggerId,
        const {},
        overlayTriggerId,
      ),
    );
    widget.driver.attachController(
      overlayTriggerId,
      _controller,
    );
    attachStateToController(_controller);

    _controller.listenCommand(_listener);
  }

  Future<void> _handleBottomSheetCommand(BottomSheetCommand command) async {
    final content = command.commandData["content"] ?? const {};
    if (command.action == OverlayAction.open) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: command.isScrollControlled,
        backgroundColor: command.backgroundColor,
        barrierColor: command.barrierColor,
        shape: command.shape,
        clipBehavior: command.clipBehavior,
        useSafeArea: command.useSafeArea,
        useRootNavigator: command.useRootNavigator,
        isDismissible: command.isDismissible,
        enableDrag: command.enableDrag,
        showDragHandle: command.showDragHandle,
        constraints: command.constraints,
        anchorPoint: command.anchorPoint,
        scrollControlDisabledMaxHeightRatio:
            command.scrollControlDisabledMaxHeightRatio,
        // transitionAnimationController not supported
        // sheetAnimationStyle not supported
        builder: (context) {
          final body = buildOutOfBoundWidget(content, widget.driver, null);
          assert(body != null, "Body must not be null");
          return body!;
        },
      ).whenComplete(() => _controller.performAction(command.onClose));
    } else {
      _handleClose();
    }
  }

  void _handleClose() => Navigator.of(context).pop();

  Future<void> _listener(RemoteCommand command) async {
    switch (command) {
      case BottomSheetCommand():
        _handleBottomSheetCommand(command);
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
