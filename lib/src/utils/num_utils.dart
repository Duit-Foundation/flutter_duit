final class NumUtils {
  static int? toInt(dynamic value) {
    if (value is num) {
      return value.toInt();
    }

    return null;
  }

  static double? toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return null;
  }
}