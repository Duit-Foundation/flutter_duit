/// The constructor variants for PageView widgets.
///
/// [PageViewConstructor] enumerates the possible constructors available for creating
/// a PageView-like widget. It helps determine which style of PageView—either a standard,
/// child-based one ("common") or an item builder-based one ("builder")—should be used,
/// usually derived from a remote config or serialized data.
///
/// - [common]: Uses the regular PageView constructor, with an explicit list of child widgets.
/// - [builder]: Uses the PageView.builder constructor, where children are built lazily
///   using a builder function.
///
/// Example usage:
/// ```dart
/// final variant = PageViewConstructor.fromValue("builder");
/// switch (variant) {
///   case PageViewConstructor.common:
///     // Use a normal PageView
///     break;
///   case PageViewConstructor.builder:
///     // Use PageView.builder for dynamic/lazy content.
///     break;
/// }
/// ```
enum PageViewConstructor {
  common,
  builder;

  /// Returns the [PageViewConstructor] variant matching the given value.
  ///
  /// The [value] can be either a [String] ("common" or "builder") or an [int] (0 or 1).
  /// Throws an [ArgumentError] if [value] does not correspond to a valid variant.
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

/// Lookup from string values to [PageViewConstructor] variants.
const _stringLookup = {
  "common": PageViewConstructor.common,
  "builder": PageViewConstructor.builder,
};

/// Lookup from integer values to [PageViewConstructor] variants.
const _intLookup = {
  0: PageViewConstructor.common,
  1: PageViewConstructor.builder,
};
