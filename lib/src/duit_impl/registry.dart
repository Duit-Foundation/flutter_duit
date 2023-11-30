import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

typedef ModelMapper = DUITElement Function(
  String id,
  bool controlled,
  ViewAttributeWrapper attributes,
  UIElementController? controller,
);
typedef Renderer = Widget Function(DUITElement model);
typedef AttributesMapper = DUITAttributes Function(
    String type, JSONObject? json);

sealed class DUITRegistry {
  static final Map<String, (ModelMapper, Renderer, AttributesMapper)>
      _registry = {};

  static void register(
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
