import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart";
import "package:flutter_duit/flutter_duit.dart";

final class DuitFocusNodeManager with FocusCapabilityDelegate {
  final _nodeRegistry = <String, FocusNode>{};

  @override
  void attachFocusNode(String nodeId, FocusNode node) {
    final existing = _nodeRegistry[nodeId];
    if (allowFocusNodeOverride) {
      if (existing != null) {
        existing.dispose();
      }
      _nodeRegistry[nodeId] = node;
    } else {
      if (existing != null) {
        throw StateError("FocusNode with id $nodeId is already attached");
      }
      _nodeRegistry[nodeId] = node;
    }
  }

  @override
  void detachFocusNode(String nodeId) =>
      _nodeRegistry.remove(nodeId)?.dispose();

  @override
  bool focusInDirection(String nodeId, TraversalDirection direction) =>
      _nodeRegistry[nodeId]?.focusInDirection(direction) ??
      (throw MissingFocusNodeException(
        nodeId,
        "focusInDirection",
      ));

  @override
  bool nextFocus(String nodeId) =>
      _nodeRegistry[nodeId]?.nextFocus() ??
      (throw MissingFocusNodeException(
        nodeId,
        "nextFocus",
      ));

  @override
  bool previousFocus(String nodeId) =>
      _nodeRegistry[nodeId]?.previousFocus() ??
      (throw MissingFocusNodeException(
        nodeId,
        "previousFocus",
      ));

  @override
  void requestFocus(String nodeId, {String? targetNodeId}) {
    final node = _nodeRegistry[nodeId];
    if (node != null) {
      if (targetNodeId != null) {
        final targetNode = _nodeRegistry[targetNodeId];
        node.requestFocus(targetNode);
      } else {
        node.requestFocus();
      }
      return;
    }
    throw MissingFocusNodeException(
      nodeId,
      "requestFocus",
    );
  }

  @override
  void unfocus(
    String nodeId, {
    UnfocusDisposition disposition = UnfocusDisposition.scope,
  }) {
    final node = _nodeRegistry[nodeId];

    if (node != null) {
      node.unfocus(disposition: disposition);
      return;
    }
    throw MissingFocusNodeException(
      nodeId,
      "unfocus",
    );
  }

  void dispose() {
    for (var node in _nodeRegistry.entries) {
      node.value.dispose();
    }
    _nodeRegistry.clear();
  }

  @override
  FocusNode? getNode(Object? key) => _nodeRegistry[key];
}
