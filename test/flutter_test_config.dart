import "dart:async";
import "dart:io";

import "package:alchemist/alchemist.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;

  final isGithubActionsEnv = Platform.isLinux;

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
