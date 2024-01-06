import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
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
final class AttributeParser implements AttributeParserBase {
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
  @override
  ViewAttributeWrapper<T> parse<T>(String type, JSONObject? json, String? tag) {
    final payload = switch (type) {
      ElementType.text => TextAttributes.fromJson(json ?? {}),
      ElementType.row => RowAttributes.fromJson(json ?? {}),
      ElementType.column => ColumnAttributes.fromJson(json ?? {}),
      ElementType.sizedBox => SizedBoxAttributes.fromJson(json ?? {}),
      ElementType.center => CenterAttributes.fromJson(json ?? {}),
      ElementType.coloredBox => ColoredBoxAttributes.fromJson(json ?? {}),
      ElementType.textField => TextFieldAttributes.fromJson(json ?? {}),
      ElementType.elevatedButton =>
        ElevatedButtonAttributes.fromJson(json ?? {}),
      ElementType.stack => StackAttributes.fromJson(json ?? {}),
      ElementType.expanded => ExpandedAttributes.fromJson(json ?? {}),
      ElementType.padding => PaddingAttributes.fromJson(json ?? {}),
      ElementType.positioned => PositionedAttributes.fromJson(json ?? {}),
      ElementType.decoratedBox => DecoratedBoxAttributes.fromJson(json ?? {}),
      ElementType.checkbox => CheckboxAttributes.fromJson(json ?? {}),
      ElementType.container => ContainerAttributes.fromJson(json ?? {}),
      ElementType.image => ImageAttributes.fromJson(json ?? {}),
      ElementType.gestureDetector =>
        GestureDetectorAttributes.fromJson(json ?? {}),
      ElementType.align => AlignAttributes.fromJson(json ?? {}),
      ElementType.transform => TransformAttributes.fromJson(json ?? {}),
      ElementType.richText => RichTextAttributes.fromJson(json ?? {}),
      ElementType.wrap => WrapAttributes.fromJson(json ?? {}),
      ElementType.custom => _parseCustomWidgetAttributes(json, tag),
      ElementType.lifecycleStateListener => LifecycleStateListenerAttributes.fromJson(json ?? {}),
      ElementType.empty || String() => EmptyAttributes(),
    };

    return ViewAttributeWrapper<T>(payload: payload);
  }
}
