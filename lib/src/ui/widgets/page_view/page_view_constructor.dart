enum PageViewConstructor {
  common,
  builder,
  custom;

  static PageViewConstructor fromValue(value) {
    if (value is String) {
      return _stringLookup[value]!;
    }

    if (value is int) {
      return _intLookup[value]!;
    }

    throw ArgumentError("Invalid page view constructor value: $value");
  }
}

const _stringLookup = {
  "common": PageViewConstructor.common,
  "builder": PageViewConstructor.builder,
  "custom": PageViewConstructor.custom,
};

const _intLookup = {
  0: PageViewConstructor.common,
  1: PageViewConstructor.builder,
  2: PageViewConstructor.custom,
};
