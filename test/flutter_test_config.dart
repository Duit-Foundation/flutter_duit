import "dart:async";
import "dart:io";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;
  return testMain();
}
