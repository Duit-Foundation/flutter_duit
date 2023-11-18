import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/utils/index.dart';

sealed class AttributeParser {
  static parse(DUITElementType type, JSONObject? json) {
    final payload = switch (type) {
      DUITElementType.text => TextAttributes.fromJson(json ?? {}),
      DUITElementType.row => RowAttributes.fromJson(json ?? {}),
      DUITElementType.column => ColumnAttributes.fromJson(json ?? {}),
      DUITElementType.sizedBox => SizedBoxAttributes.fromJson(json ?? {}),
      DUITElementType.center => CenterAttributes.fromJson(json ?? {}),
      DUITElementType.elevatedButton ||
      DUITElementType.textField ||
      DUITElementType.coloredBox ||
      DUITElementType.column ||
      DUITElementType.empty =>
        EmptyAttributes(),
    };

    return ViewAttributeWrapper(payload: payload);
  }
}
