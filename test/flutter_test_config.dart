import "dart:async";
import "dart:io";

import "package:alchemist/alchemist.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;

  const isRunningInCi = bool.fromEnvironment('CI');

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isRunningInCi
      ),
      ciGoldensConfig: CiGoldensConfig(
        enabled: isRunningInCi
      ),
    ),
    run: testMain,
  );
}
