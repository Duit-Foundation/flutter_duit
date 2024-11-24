extension type AnimatedPropHelper(Map<String, dynamic> json) implements Map {
  String? get parentBuilderId => json["parentBuilderId"];

  Iterable<String>? get affectedProperties {
    if (json.containsKey("affectedProperties")) {
      return Set.from(json["affectedProperties"]);
    } else {
      return null;
    }
  }
}
