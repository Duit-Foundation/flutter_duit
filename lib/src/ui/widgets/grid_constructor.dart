enum GridConstructor {
  common,
  builder,
  count,
  extent;

  static GridConstructor fromValue(dynamic value) {
    if (value is String) {
      return _stringLookup[value]!;
    }

    if (value is int) {
      return _intLookup[value]!;
    }

    throw ArgumentError("Invalid grid constructor value: $value");
  }
}

const _stringLookup = {
  "common": GridConstructor.common,
  "builder": GridConstructor.builder,
  "count": GridConstructor.count,
  "extent": GridConstructor.extent,
};

const _intLookup = {
  0: GridConstructor.common,
  1: GridConstructor.count,
  2: GridConstructor.builder,
  3: GridConstructor.extent,
};