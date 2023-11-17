import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/utils/index.dart';


sealed class AttributeParser {
  static parse(DUITElementType type, JSONObject? json) {
    if (json == null) return ViewAttributeWrapper(payload: null);

    final payload = switch (type) {
      DUITElementType.text => TextAttributes.fromJson(json),
      DUITElementType.row => RowAttributes.fromJson(json),
      DUITElementType.column ||
      DUITElementType.center ||
      DUITElementType.elevatedButton ||
      DUITElementType.textField ||
      DUITElementType.sizedBox ||
      DUITElementType.coloredBox ||
      DUITElementType.column ||
      DUITElementType.empty =>
        EmptyAttributes(),
    };

    return ViewAttributeWrapper(payload: payload);
  }
}
