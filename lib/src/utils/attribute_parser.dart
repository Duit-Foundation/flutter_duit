import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/duit_impl/registry.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/utils/index.dart';

sealed class AttributeParser {
  static _parseCustomWidgetAttributes(JSONObject? json, String? tag) {
    assert(tag != null, "Custom widget must have specified tag");

    if (tag is String) {
      final attributesMapper = DUITRegistry.getAttributesMapper(tag);
      if (attributesMapper != null) {
        return attributesMapper(tag, json);
      } else {
        return EmptyAttributes();
      }
    }
  }

  static parse(DUITElementType type, JSONObject? json, String? tag) {
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
      DUITElementType.stack => StackAttributes.fromJson(json ?? {}),
      DUITElementType.expanded => ExpandedAttributes.fromJson(json ?? {}),
      DUITElementType.padding => PaddingAttributes.fromJson(json ?? {}),
      DUITElementType.positioned => PositionedAttributes.fromJson(json ?? {}),
      DUITElementType.empty => EmptyAttributes(),
      DUITElementType.custom => _parseCustomWidgetAttributes(json, tag),
    };

    return ViewAttributeWrapper(payload: payload);
  }
}
