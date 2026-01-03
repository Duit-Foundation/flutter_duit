import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart";
import "package:flutter_duit/src/ui/index.dart";
import "package:flutter_duit/src/view/view.dart";

final class CommonDuitView extends DuitViewModel {
  late ElementTree _layout;
  @Deprecated("Will be removed in the next major release")
  bool isReady = false;

  @override
  Widget build([String _ = ""]) => _layout.render();

  @override
  Future<void> prepareModel(
    Map<String, dynamic> json,
    UIDriver driver,
  ) async {
    _layout = await DuitTree(
      json: json,
      driver: driver,
    ).parse();
  }

  @override
  void changeViewState(String tag, int state) {}

  @override
  @preferInline
  bool isWidgetReady(String viewTag) => true;
}
