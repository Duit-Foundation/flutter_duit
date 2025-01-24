import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_duit/src/ui/models/ui_tree.dart';

final class DuitMultiViewLayout implements DuitView {
  final _views = <String, ElementTree>{};

  @override
  Widget build([String tag = ""]) {
    if (tag.isEmpty || !_views.containsKey(tag)) {
      return _views.values.first.render();
    }
    return _views[tag]!.render();
  }

  @override
  Future<void> prepareModel(
    Map<String, dynamic> json,
    UIDriver driver,
  ) async {
    final widgets = json.entries.cast<MapEntry<String, dynamic>>();

    for (var entry in widgets) {
      final tree = await DuitTree(
        json: entry.value,
        driver: driver,
      ).parse();

      _views[entry.key] = tree;
    }
  }

  @override
  ElementTree getElementTree([String tag = ""]) {
    if (tag.isEmpty || !_views.containsKey(tag)) {
      return _views.values.first;
    }
    return _views[tag]!;
  }
}
