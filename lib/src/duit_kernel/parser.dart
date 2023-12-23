import 'index.dart';

abstract class AttributeParserBase {
  ViewAttributeWrapper<T> parse<T>(DUITElementType type, Map<String, dynamic>? json, String? tag);
}