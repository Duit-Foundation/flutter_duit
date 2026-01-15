import "dart:convert";
import "dart:typed_data";

import "package:duit_kernel/duit_kernel.dart";

Uri objectToURLWithQueryParams(String url, Map<String, dynamic>? params) {
  var result = url;
  Uri uri;

  if (params != null && params.isNotEmpty) {
    result += "?";
    params.forEach((key, value) {
      result += "$key=$value";
    });
    return Uri.parse(result);
  } else {
    uri = Uri.parse(result);
  }

  return uri;
}

String prepareUrl(String baseUrl, String url) {
  var urlString = "";
  if (baseUrl.isNotEmpty) {
    urlString += baseUrl;
  }

  return "$urlString$url";
}

Future<Map<String, dynamic>> parseResponse(
  data, {
  required Converter<Uint8List, Object?>? customDecoder,
}) async {
  if (customDecoder != null) {
    final decodingResult = customDecoder.convert(data)! as Map<String, dynamic>;
    return decodingResult;
  }

  if (data is Uint8List) {
    return jsonDecode(
      utf8.decode(data),
      reviver: DuitDataSource.jsonReviver,
    ) as Map<String, dynamic>;
  }

  if (data is String) {
    return jsonDecode(
      data,
      reviver: DuitDataSource.jsonReviver,
    ) as Map<String, dynamic>;
  }

  throw ArgumentError("Invalid data type: ${data.runtimeType}");
}
