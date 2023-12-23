import 'package:flutter/material.dart';

import 'index.dart';

/// The `ModelMapper` is a function type that maps a DUIT element to a `DUITElement`.
///
/// The function takes in the following parameters:
/// - [id]: The unique identifier of the DUIT element.
/// - [controlled]: A boolean indicating whether the DUIT element is controlled.
/// - [attributes]: The attributes of the DUIT element.
/// - [controller]: An optional UI element controller.
///
/// It returns a `DUITElement` that represents the mapped DUIT element.
typedef ModelMapper = TreeElement Function(
  String id,
  bool controlled,
  ViewAttributeWrapper attributes,
  UIElementController? controller,
);

/// The `Renderer` is a function type that returns a widget representation of a `DUITElement`.
///
/// The function takes in a single parameter:
/// - [model]: The `DUITElement` to be rendered.
///
/// It returns a `Widget` that represents the rendered `DUITElement`.
typedef Renderer = Widget Function(TreeElement model);

/// The `AttributesMapper` is a function type that maps the attributes of a DUIT element to `DUITAttributes`.
///
/// The function takes in the following parameters:
/// - [type]: The type of the DUIT element.
/// - [json]: The JSON object representing the attributes of the DUIT element.
///
/// It returns a `DUITAttributes` object that represents the mapped attributes.
typedef AttributesMapper = DuitAttributes Function(
    String type, Map<String, dynamic>? json);

/// The `DUITRegistry` class is responsible for registering and retrieving
/// model mappers, renderers, and attributes mappers for custom DUIT elements.
sealed class DuitRegistry {
  static final Map<String, (ModelMapper, Renderer, AttributesMapper)>
      _registry = {};

  /// Registers a DUIT element with the specified key, model mapper, renderer, and attributes mapper.
  ///
  /// The [key] is a unique identifier for the DUIT element.
  /// The [modelMapper] is a function that maps the DUIT element to a `DUITElement`.
  /// The [renderer] is a function that returns the widget representation of the `DUITElement`.
  /// The [attributesMapper] is a function that maps the attributes of the DUIT element to `DUITAttributes`.
  static void register(
    String key,
    ModelMapper modelMapper,
    Renderer renderer,
    AttributesMapper attributesMapper,
  ) {
    _registry[key] = (modelMapper, renderer, attributesMapper);
  }

  /// Returns the model mapper registered with the specified [key].
  ///
  /// Returns `null` if the specified [key] is not registered.
  static ModelMapper? getModelMapper(String key) {
    return _registry[key]?.$1;
  }

  /// Returns the renderer registered with the specified [key].
  ///
  /// Returns `null` if the specified [key] is not registered.
  static Renderer? getRenderer(String key) {
    return _registry[key]?.$2;
  }

  /// Returns the attributes mapper registered with the specified [key].
  ///
  /// Returns `null` if the specified [key] is not registered.
  static AttributesMapper? getAttributesMapper(String key) {
    return _registry[key]?.$3;
  }
}
