enum CarouselViewConstructor {
  common,
  weighted;

  static CarouselViewConstructor fromValue(dynamic value) {
    return switch (value) {
      "common" || 0 => CarouselViewConstructor.common,
      "weighted" || 1 => CarouselViewConstructor.weighted,
      _ => throw ArgumentError("Invalid CarouselViewConstructor value: $value"),
    };
  }
}
