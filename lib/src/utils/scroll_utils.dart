import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

mixin ScrollUtils<T extends StatefulWidget> on State<T> {
  //<editor-fold desc="Properties and getters">
  late final ScrollController _scrollController;
  bool _isExecuting = false;

  /// Indicates if the list is at the end of list
  bool _isEOL = false;
  late UIElementController _controller;

  ScrollController get scrollController => _scrollController;

  set isEOL(bool value) => _isEOL = value;

  //</editor-fold>

  //<editor-fold desc="Lifecycle methods">
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //</editor-fold>

  //<editor-fold desc="Methods">
  void attachOnScrollCallback(UIElementController controller) {
    _controller = controller;
    final attrs = _controller.attributes.payload;
    final extent = attrs.tryGetDouble(
      key: "scrollEndReachedThreshold",
      defaultValue: 300,
    )!;
    _scrollController = ScrollController()
      ..addListener(
        () async {
          if (_scrollController.position.maxScrollExtent -
                  _scrollController.offset <=
              extent) {
            if (!_isExecuting && !_isEOL) {
              _isExecuting = true;
              await _controller.performRelatedActionAsync();
              _isEOL = true;
              _isExecuting = false;
            }
          }
        },
      );
  }

//</editor-fold>
}
