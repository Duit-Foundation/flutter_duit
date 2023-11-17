import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/utils/index.dart';

base class ViewAttributeWrapper<T> {
  T payload;

  ViewAttributeWrapper({
    required this.payload,
  });

  static ViewAttributeWrapper<T> createAttributes<T>(DUITElementType type, JSONObject json) {
    return AttributeParser.parse(type, json);
  }


}