import 'index.dart';

abstract class AttributeParserBase {
  ViewAttributeWrapper<T> parse<T>(String type, Map<String, dynamic>? json, String? tag);
}