import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SliverAnimatedOpacityAttributes extends ImplicitAnimatable
    implements
        DuitAttributes<SliverAnimatedOpacityAttributes>,
        DuitSliverProps {
  final double opacity;

  @override
  final bool needsBoxAdapter;

  const SliverAnimatedOpacityAttributes({
    required this.opacity,
    required this.needsBoxAdapter,
    required super.duration,
    required super.curve,
    required super.onEnd,
  });

  factory SliverAnimatedOpacityAttributes.fromJson(Map<String, dynamic> json) {
    final action = ActionUtils(json);
    return SliverAnimatedOpacityAttributes(
      opacity: NumUtils.toDoubleWithNullReplacement(json["opacity"], 1.0),
      needsBoxAdapter: json["needsBoxAdapter"] ?? false,
      duration: AttributeValueMapper.toDuration(json["duration"]),
      curve: AttributeValueMapper.toCurve(json["curve"]),
      onEnd: action.parseAction("onEnd"),
    );
  }

  @override
  SliverAnimatedOpacityAttributes copyWith(
    SliverAnimatedOpacityAttributes other,
  ) {
    return SliverAnimatedOpacityAttributes(
      opacity: other.opacity,
      needsBoxAdapter: needsBoxAdapter,
      duration: duration,
      curve: other.curve,
      onEnd: other.onEnd ?? onEnd,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) => throw UnimplementedError();
}
