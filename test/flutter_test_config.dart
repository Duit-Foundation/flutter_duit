import "dart:async";
import "dart:io";

import "package:alchemist/alchemist.dart";

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  HttpOverrides.global = null;

  final isGithubActionsEnv = Platform.isLinux;

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      platformGoldensConfig:
          PlatformGoldensConfig(enabled: isGithubActionsEnv == false),
      ciGoldensConfig: CiGoldensConfig(enabled: isGithubActionsEnv == true),
    ),
    run: testMain,
  );
}
