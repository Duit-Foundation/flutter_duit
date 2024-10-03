import "dart:async";
import "dart:io";

import "package:alchemist/alchemist.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;

  const isRunningInCi = bool.fromEnvironment('CI', defaultValue: false);

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      ciGoldensConfig: CiGoldensConfig(
        enabled: !isRunningInCi
      ),
    ),
    run: testMain,
  );
}
