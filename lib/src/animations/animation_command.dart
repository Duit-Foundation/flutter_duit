import 'index.dart';

/// A command that is sent to control an animation by interacting with an
/// animation controller identified by [controllerId]. The command specifies
/// the [method] to be executed, such as forward, reverse, repeat, or toggle,
/// on the animation controller. It also identifies the animated property key
/// using [animatedPropKey], which is affected by the animation.
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