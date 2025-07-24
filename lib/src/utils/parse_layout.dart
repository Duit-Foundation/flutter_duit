import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/ui/index.dart';

Future<ElementTree> parseLayout(
  Map<String, dynamic> data,
  UIDriver driver,
) async {
  return await DuitTree(
    json: data,
    driver: driver,
  ).parse();
}

ElementTree parseLayoutSync(
  Map<String, dynamic> data,
  UIDriver driver,
) {
  return DuitTree(
    json: data,
    driver: driver,
  ).parseSync();
}
