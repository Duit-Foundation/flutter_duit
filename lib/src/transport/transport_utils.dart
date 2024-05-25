Uri objectToURLWithQueryParams(String url, Map<String, dynamic>? params) {
  String result = url;
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
