import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'element.dart';

final class DuitTree extends ElementTree {
  Widget? _root;
  final _dm = DevMetrics();

  DuitTree({
    required JSONObject json,
    required UIDriver driver,
  }) : super(json: json, driver: driver);

  @override
  Future<ElementTree> parse() async {
    _dm.add(ParseModelStartMessage());
    uiRoot = DuitElement.fromJson(
      json,
      driver,
    );
    _dm.add(ParseModelEndMessage());
    return this;
  }

  @override
  ElementTree parseSync() {
    _dm.add(ParseModelStartMessage());
    uiRoot = DuitElement.fromJson(
      json,
      driver,
    );
    _dm.add(ParseModelEndMessage());
    return this;
  }

  @override
  Widget render() {
    return _root ??= uiRoot.renderView();
  }
}
