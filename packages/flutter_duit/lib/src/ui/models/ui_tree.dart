import 'package:flutter/widgets.dart';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'element.dart';

class DUITAbstractTree {
  @protected
  final JSONObject json;
  @protected
  final UIDriver driver;
  late final DUITElement _uiRoot;

  DUITAbstractTree({
    required this.json,
    required this.driver,
  });

  ///Parse json to a [DUITElement] object tree
  Future<DUITAbstractTree> parse() async {
    _uiRoot = DUITElement.fromJson(json, driver);
    return this;
  }

  Widget render() {
    return _uiRoot.renderView();
  }
}