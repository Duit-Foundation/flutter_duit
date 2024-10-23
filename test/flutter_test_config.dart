import "dart:async";
import "dart:io";

import "package:flutter_test/flutter_test.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;

  return await testMain();
}
