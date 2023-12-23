import 'package:flutter/widgets.dart';
import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'element.dart';

final class DuitTree extends DuitAbstractTree {
  DuitTree({
    required JSONObject json,
    required UIDriver driver,
  }) : super(json: json, driver: driver);

  @override
  Future<DuitAbstractTree> parse() async {
    uiRoot = DuitElement.fromJson(json, driver);
    return this;
  }

  @override
  Widget render() {
    return uiRoot.renderView();
  }
}
