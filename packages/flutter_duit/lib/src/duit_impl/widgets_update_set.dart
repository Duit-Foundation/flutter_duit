import 'package:flutter_duit/src/utils/index.dart';

class WidgetsUpdateSet {
  Map<String, dynamic> updates;

  WidgetsUpdateSet({required this.updates});

  static WidgetsUpdateSet? fromJson(JSONObject? json) {
    if (json == null) return null;

    return WidgetsUpdateSet(updates: json["updates"]);
  }
}
