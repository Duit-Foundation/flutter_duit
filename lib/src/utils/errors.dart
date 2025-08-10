final class NullTagException implements Exception {
  final String message;

  NullTagException(this.message);

  @override
  String toString() => message;
}