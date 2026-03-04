import "dart:convert";
import "dart:typed_data";

interface class Parsable {
  Converter<Object?, String>? encoder;
  Converter<Uint8List, Object?>? decoder;
}
