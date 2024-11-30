import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/ui/models/ui_tree.dart';

import 'index.dart';

Future<ElementTree> parseLayout(
  JSONObject data,
  UIDriver driver,
) async {
  return await DuitTree(
    json: data,
    driver: driver,
  ).parse();
}

ElementTree parseLayoutSync(
  JSONObject data,
  UIDriver driver,
) {
  return DuitTree(
    json: data,
    driver: driver,
  ).parseSync();
}
