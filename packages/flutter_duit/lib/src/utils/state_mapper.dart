import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';

mixin StateMapper<T extends StatefulWidget, AttrType extends DUITAttributes>
    on State<T> {
  AttrType? attributes;
  UIElementController? _controller;

  void attachStateToController(UIElementController? controller) {
    _controller = controller;
    attributes = _controller?.attributes?.payload;
  }

  void _listenControllerUpdateStateEvent() {
    _controller?.addListener(() {
      final newState = _controller?.attributes?.payload;

      if (newState != null) {
        setState(() {
          attributes = attributes?.copyWith(newState);
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    _listenControllerUpdateStateEvent();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
