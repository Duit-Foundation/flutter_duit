import "dart:async";
import "dart:io";
import "package:golden_toolkit/golden_toolkit.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;
  await loadAppFonts();
  return testMain();
}
