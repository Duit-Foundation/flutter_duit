import 'package:flutter/foundation.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';

import 'ui_controller.dart';

final class ViewController<T>
    with ChangeNotifier
    implements UIElementController<T> {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  ServerAction? action;

  @override
  UIDriver driver;

  @override
  String id;

  @override
  DUITElementType type;

  @override
  String? tag;

  ViewController({
    required this.id,
    required this.driver,
    required this.type,
    this.action,
    this.attributes,
    this.tag,
  });

  //</editor-fold>

  //<editor-fold desc="Methods">
  @override
  void updateState(ViewAttributeWrapper<T> newAttrs) {
    attributes = newAttrs;
    notifyListeners();
  }

  @override
  void performRelatedAction() {
    if (action != null) {
      driver.execute(action!);
    }
  }
//</editor-fold>
}
