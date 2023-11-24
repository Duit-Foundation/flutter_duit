import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/duit_impl/registry.dart';
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
      DUITElementType.coloredBox => ColoredBoxAttributes.fromJson(json ?? {}),
      DUITElementType.textField => TextFieldAttributes.fromJson(json ?? {}),
      DUITElementType.elevatedButton =>
        ElevatedButtonAttributes.fromJson(json ?? {}),
      DUITElementType.empty => EmptyAttributes(),
      DUITElementType.custom => () {
          final customType = json?["type"];

          if (customType is String) {
            final mapper = DuitRegistry.getAttributesMapper(type as String);
            if (mapper != null) {
              return mapper(customType, json?["data"]);
            } else {
              return EmptyAttributes();
            }
          }
        },
    };

    return ViewAttributeWrapper(payload: payload);
  }
}
