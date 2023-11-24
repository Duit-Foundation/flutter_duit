import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/models/element.dart';
import 'package:flutter_duit/src/utils/index.dart';

typedef ModelMapper = DUITElement Function(JSONObject json, UIDriver driver);
typedef AttributesMapper = ViewAttributeWrapper Function(
    String type, JSONObject? json);
typedef Renderer = Widget Function(DUITElement model);

final class DuitRegistry {
  static final Map<String, (ModelMapper, Renderer, AttributesMapper)>
      _registry = {};

  static register(
    String key,
    ModelMapper modelMapper,
    Renderer renderer,
    AttributesMapper attributesMapper,
  ) {
    _registry[key] = (modelMapper, renderer, attributesMapper);
  }

  static ModelMapper? getModelMapper(String key) {
    return _registry[key]?.$1;
  }

  static Renderer? getRenderer(String key) {
    return _registry[key]?.$2;
  }

  static AttributesMapper? getAttributesMapper(String key) {
    return _registry[key]?.$3;
  }
}
