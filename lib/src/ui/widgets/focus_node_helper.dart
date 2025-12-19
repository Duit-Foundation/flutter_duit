import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/controller/index.dart";
import "package:meta/meta.dart";

mixin FocusNodeCommandHandler {
  @internal
  late final FocusNode focusNode;
  @internal
  late final UIElementController controller;

  @internal
  Future<void> handleCommand(
    RemoteCommand command,
  ) async {
    if (command is GenericFocusNodeCommand) {
      switch (command) {
        case FocusNodeUnfocusCommand(:final disposition):
          focusNode.unfocus(disposition: disposition);
          break;
        case FocusNodeNextFocusCommand():
          focusNode.nextFocus();
          break;
        case FocusNodePreviousFocusCommand():
          focusNode.previousFocus();
          break;
        case FocusNodeFocusInDirectionCommand(:final direction):
          focusNode.focusInDirection(direction);
          break;
        case FocusNodeRequestFocusCommand(:final nodeId):
          final driver = controller.driver;
          final targetNode = driver.getNode(nodeId);
          focusNode.requestFocus(targetNode);
          break;
      }
    }
  }
}
