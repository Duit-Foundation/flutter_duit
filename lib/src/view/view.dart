import "package:duit_kernel/duit_kernel.dart";

export "package:flutter_duit/src/view/common.dart";
export "package:flutter_duit/src/view/shared.dart";

abstract class DuitViewModel implements DuitView {
  @Deprecated(
    "The method is not used and will be removed in the next major release",
  )
  @override
  ElementTree getElementTree([String tag = ""]) => throw UnimplementedError();

  void changeViewState(String tag, int state);

  bool isWidgetReady(String viewTag);
}
