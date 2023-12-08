import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents a wrapper for view attributes.
///
/// The [ViewAttributeWrapper] class is used to wrap view attributes,
/// providing a convenient way to access and manipulate them.
final class ViewAttributeWrapper<T> {
  /// The payload of the view attribute.
  ///
  /// Use the [payload] property to access or modify the value of the view attribute.
  final T payload;

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
      DUITElementType type, JSONObject? json, String? tag) {
    return AttributeParser.parse(type, json, tag);
  }
}
