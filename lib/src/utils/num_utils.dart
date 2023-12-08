/// Provides utility functions for working with numeric values.
///
/// The [NumUtils] class contains a collection of static methods that provide utility functions for working with numeric values.
sealed class NumUtils {
  /// Converts a value to an integer.
  ///
  /// The [toInt] function converts a value to an integer.
  /// If the value is null or cannot be converted to an integer, it returns null.
  /// The [value] parameter represents the value to convert.
  ///
  /// Returns the converted integer value, or null if the conversion is not possible.
  static int? toInt(dynamic value) {
    if (value is num) {
      return value.toInt();
    }

    return null;
  }

  /// Converts a value to a double.
  ///
  /// The [toDouble] function converts a value to a double.
  /// If the value is null or cannot be converted to a double, it returns null.
  /// The [value] parameter represents the value to convert.
  ///
  /// Returns the converted double value, or null if the conversion is not possible.
  static double? toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return null;
  }

  /// Converts a value to a double with a null replacement.
  ///
  /// The [toDoubleWithNullReplacement] function converts a value to a double.
  /// If the value is null, it is replaced with the specified [replacement] value before converting to a double.
  /// The [value] parameter represents the value to convert, and the [replacement] parameter represents the value to use as a replacement for null.
  ///
  /// Returns the converted double value.
  static double toDoubleWithNullReplacement(dynamic value, double replacement) {
    if (value is num) {
      return value.toDouble();
    }

    return replacement;
  }
}
