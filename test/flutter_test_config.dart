import "dart:async";
import "dart:io";

import "package:alchemist/alchemist.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;

  final pEnv = Platform.environment["IS_CI"] == "true";
  const bEnv = bool.fromEnvironment("IS_CI", defaultValue: false);
  final isGithubActionsEnv = pEnv || bEnv;

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
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
