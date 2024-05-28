import 'index.dart';


final class AnimationCommand {
  final String controllerId;
  final AnimationMethod method;
  final String animatedPropKey;

  AnimationCommand({
    required this.controllerId,
    required this.method,
    required this.animatedPropKey,
  });
}