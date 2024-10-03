import "dart:async";
import "dart:io";

import "package:alchemist/alchemist.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;

  const isGithubActionsEnv = bool.fromEnvironment("IS_CI");

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isGithubActionsEnv,
      ),
      ciGoldensConfig: CiGoldensConfig(
        enabled: isGithubActionsEnv,
      ),
    ),
    run: testMain,
  );
}
