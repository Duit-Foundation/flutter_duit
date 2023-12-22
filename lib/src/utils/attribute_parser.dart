import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/duit_impl/registry.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// The `AttributeParser` class is responsible for parsing and mapping attributes for different DUIT elements.
///
/// This class provides static methods for parsing custom widget attributes and creating `ViewAttributeWrapper` instances.
///
/// Usage:
/// ```dart
/// final attributes = AttributeParser.parse(type, json, tag);
/// ```
///
/// To parse custom widget attributes, you can use the `_parseCustomWidgetAttributes` method.
/// This method takes a JSON object and a tag as parameters and returns the parsed attributes.
/// ```dart
/// final customAttributes = AttributeParser._parseCustomWidgetAttributes(json, tag);
/// ```
sealed class AttributeParser {
  /// Parses custom widget attributes based on the specified JSON object and tag.
  ///
  /// This method retrieves the attributes mapper for the given tag from the `DUITRegistry`.
  /// If an attributes mapper is found, it is invoked with the tag and JSON object to get the parsed attributes.
  /// If no attributes mapper is found, it returns an instance of `EmptyAttributes`.
  ///
  /// Parameters:
  /// - [json]: The JSON object containing the attributes.
  /// - [tag]: The tag of the custom widget.
  ///
  /// Returns:
  /// The parsed attributes for the custom widget.
  static _parseCustomWidgetAttributes(JSONObject? json, String? tag) {
    assert(tag != null, "Custom widget must have specified tag");

    if (tag is String) {
      final attributesMapper = DuitRegistry.getAttributesMapper(tag);
      if (attributesMapper != null) {
        return attributesMapper(tag, json);
      } else {
        return EmptyAttributes();
      }
    }
  }

  /// Parses and creates a `ViewAttributeWrapper` instance based on the specified type, JSON object, and tag.
  ///
  /// This method is used to parse and map attributes for different DUIT elements.
  /// It returns a new instance of `ViewAttributeWrapper` with the appropriate payload type based on the element type.
  ///
  /// Parameters:
  /// - [type]: The type of the DUIT element.
  /// - [json]: The JSON object representing the attributes of the DUIT element.
  /// - [tag]: The tag of the DUIT element (optional for custom widgets).
  ///
  /// Returns:
  /// A `ViewAttributeWrapper` instance with the parsed attributes.
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
      DUITElementType.decoratedBox =>
        DecoratedBoxAttributes.fromJson(json ?? {}),
      DUITElementType.checkbox => CheckboxAttributes.fromJson(json ?? {}),
      DUITElementType.container => ContainerAttributes.fromJson(json ?? {}),
      DUITElementType.image => ImageAttributes.fromJson(json ?? {}),
      DUITElementType.gestureDetector =>
        GestureDetectorAttributes.fromJson(json ?? {}),
      DUITElementType.empty => EmptyAttributes(),
      DUITElementType.custom => _parseCustomWidgetAttributes(json, tag),
    };

    return ViewAttributeWrapper(payload: payload);
  }
}
