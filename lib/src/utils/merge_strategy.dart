/// Merge stategy for arrays used at list and grid widgets
/// Defines the strategies for merging arrays, particularly useful in list and grid widgets.
enum ArrayMergeStrategy {
  /// Appends new elements to the end of the existing array.
  addToEnd,

  /// Inserts new elements at the start of the existing array.
  addToStart,

  /// Replaces the existing array with new elements.
  replace;

  /// Returns the [ArrayMergeStrategy] corresponding to the given [value].
  ///
  /// The [value] can be a string or integer representation of the strategy.
  /// If the [value] does not match any known strategy, it defaults to [ArrayMergeStrategy.addToEnd].
  static ArrayMergeStrategy fromValue(dynamic value) {
    return switch (value) {
      "addToEnd" || 0 => ArrayMergeStrategy.addToEnd,
      "addToStart" || 1 => ArrayMergeStrategy.addToStart,
      "replace" || 2 => ArrayMergeStrategy.replace,
      _ => ArrayMergeStrategy.addToEnd,
    };
  }
}
