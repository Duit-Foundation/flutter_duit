enum PageViewConstructor {
  common,
  builder;

  static PageViewConstructor fromValue(value) {
    if (value is String) {
      return _stringLookup[value] ??
          (throw ArgumentError("Invalid page view constructor value: $value"));
    }

    if (value is int) {
      return _intLookup[value] ??
          (throw ArgumentError("Invalid page view constructor value: $value"));
    }

    throw ArgumentError("Invalid page view constructor value: $value");
  }
}

const _stringLookup = {
  "common": PageViewConstructor.common,
  "builder": PageViewConstructor.builder,
};

const _intLookup = {
  0: PageViewConstructor.common,
  1: PageViewConstructor.builder,
};
