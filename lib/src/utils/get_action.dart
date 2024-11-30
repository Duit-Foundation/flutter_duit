import 'package:duit_kernel/duit_kernel.dart';

extension type ActionCreator(Map<String, dynamic> json) {
  ServerAction? getActionFromJson(String name) {
    final hasProp = json.containsKey(name);

    if (!hasProp) {
      return null;
    } else {
      return ServerAction.parse(json[name]);
    }
  }
}
