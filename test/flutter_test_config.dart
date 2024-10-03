import "dart:async";
import "dart:io";

import "package:alchemist/alchemist.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      ciGoldensConfig: CiGoldensConfig(),
    ),
    run: testMain,
  );
}
