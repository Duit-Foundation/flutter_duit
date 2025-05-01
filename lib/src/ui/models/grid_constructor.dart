enum GridConstructor {
  common,
  count,
  builder,
  extent;
  // custom;

  static fromValue(dynamic value) {
    return switch (value) {
      "common" || 0 => GridConstructor.common,
      "count" || 1 => GridConstructor.count,
      "builder" || 3 => GridConstructor.builder,
      "extent" || 4 => GridConstructor.extent,
      // "custom" || 5 => GridConstructor.custom,
      _ => throw ArgumentError("Invalid GridConstructor value: $value"),
    };
  }
}