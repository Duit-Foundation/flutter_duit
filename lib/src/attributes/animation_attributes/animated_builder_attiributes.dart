import 'package:duit_kernel/duit_kernel.dart';

final class AnimatedBuilderAttributes
    implements DuitAttributes<AnimatedBuilderAttributes> {
  AnimatedBuilderAttributes();

  @override
  AnimatedBuilderAttributes copyWith(AnimatedBuilderAttributes other) {
    return AnimatedBuilderAttributes();
  }

  factory AnimatedBuilderAttributes.fromJson(Map<String, dynamic>? json) {
    return AnimatedBuilderAttributes();
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName,
      {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    // TODO: implement dispatchInternalCall
    throw UnimplementedError();
  }
}
