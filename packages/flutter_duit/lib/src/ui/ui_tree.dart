import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart";
import "package:flutter_duit/src/ui/index.dart" show DuitElement;

final class DuitTree extends ElementTree {
  Widget? _root;

  DuitTree({
    required super.json,
    required super.driver,
  });

  @override
  Future<ElementTree> parse() async {
    uiRoot = DuitElement.fromJson(
      json,
      driver,
    );
    return this;
  }

  @override
  ElementTree parseSync() {
    uiRoot = DuitElement.fromJson(
      json,
      driver,
    );
    return this;
  }

  @override
  Widget render() {
    return _root ??= uiRoot.renderView();
  }
}
