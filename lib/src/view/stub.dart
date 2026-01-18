import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/view/view.dart";

final class StubDuitView extends DuitViewModel {
  const StubDuitView();

  @override
  @preferInline
  Widget build([String tag = ""]) => const SizedBox.shrink();

  @override
  @preferInline
  void changeViewState(String tag, int state) {}

  @override
  @preferInline
  bool isWidgetReady(String viewTag) => false;

  @override
  @preferInline
  Future<void> prepareModel(Map<String, dynamic> json, UIDriver driver) =>
      Future.value();
}
