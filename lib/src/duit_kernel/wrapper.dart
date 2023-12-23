import 'index.dart';

/// Represents a wrapper for view attributes.
///
/// The [ViewAttributeWrapper] class is used to wrap view attributes,
/// providing a convenient way to access and manipulate them.
final class ViewAttributeWrapper<T> {
  /// The payload of the view attribute.
  ///
  /// Use the [payload] property to access or modify the value of the view attribute.
  final T payload;

  static late AttributeParserBase attributeParser;

  /// Creates a new instance of the [ViewAttributeWrapper] class.
  ///
  /// The [payload] parameter is the initial value of the view attribute.
  ViewAttributeWrapper({
    required this.payload,
  });

  /// Creates a new [ViewAttributeWrapper] from the given [type], [json], and [tag].
  ///
  /// This factory method is used to create a [ViewAttributeWrapper] instance
  /// based on the specified [type], [json], and [tag]. It returns a new instance
  /// of [ViewAttributeWrapper] with the appropriate payload type.
  static ViewAttributeWrapper<T> createAttributes<T>(
      String type, Map<String, dynamic>? json, String? tag) {
    return attributeParser.parse(type, json, tag);
  }
}
