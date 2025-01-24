import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/widgets.dart' show Widget, mustCallSuper;
import 'package:flutter_duit/src/view_manager/view_manager.dart';
import 'package:flutter_duit/src/view_manager/view_layout.dart';

base class SimpleViewManager extends ViewManager {
  late DuitViewLayout _view;

  @override
  @mustCallSuper
  Future<DuitView?> prepareLayout(Map<String, dynamic> json) async {
    try {
      _view = DuitViewLayout();

      switch (json) {
        case {
            "type": String _,
            "id": String _,
          }:
          await _view.prepareModel(
            json,
            driver,
          );
          return _view;
        case {
            "root": Map<String, dynamic> widget,
          }:
          await _view.prepareModel(
            widget,
            driver,
          );
          return _view;
        default:
          return null;
      }
    } catch (e, s) {
      driver.logger?.error(
        "Failed to resolve tree",
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Widget build([String tag = ""]) {
    if (tag.isNotEmpty) {
      driver.logger?.warn(
        "Tag is not supported in SimpleViewManager and will be ignored",
      );
    }

    return _view.build(tag);
  }
}
