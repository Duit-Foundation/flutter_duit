import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/animations/index.dart';

final class AnimatedBuilderAttributes
    implements DuitAttributes<AnimatedBuilderAttributes> {
  final List<DuitTweenDescription> tweenDescriptions;
  final String? persistentId;

  AnimatedBuilderAttributes({
    this.tweenDescriptions = const [],
    this.persistentId,
  });

  @override
  AnimatedBuilderAttributes copyWith(AnimatedBuilderAttributes other) {
    return AnimatedBuilderAttributes();
  }

  factory AnimatedBuilderAttributes.fromJson(Map<String, dynamic> json) {
    return AnimatedBuilderAttributes(
      tweenDescriptions: (json["tweenDescriptions"] as List)
          .map((e) => DuitTweenDescription.fromJson(e))
          .toList(),
      persistentId: json["persistentId"],
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    // TODO: implement dispatchInternalCall
    throw UnimplementedError();
  }
}
