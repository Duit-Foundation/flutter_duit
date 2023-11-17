import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';

import 'jsono.dart';

sealed class AttributeParser {
  static parse(DUITElementType type, JSONObject json) {
    final payload = switch (type) {
      DUITElementType.text => TextAttributes.fromJson(json),
      DUITElementType.column ||
      DUITElementType.row ||
      DUITElementType.center ||
      DUITElementType.elevatedButton ||
      DUITElementType.textField ||
      DUITElementType.sizedBox ||
      DUITElementType.coloredBox ||
      DUITElementType.column ||
      DUITElementType.empty =>
        RowAttributes(),
    };

    return ViewAttributeWrapper(payload: payload);
  }
}
