import 'package:flutter/material.dart' show AlignmentGeometry;
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/implicit.dart';
import 'package:flutter_duit/src/utils/index.dart';

abstract interface class _AlignProps {
  abstract final AlignmentGeometry alignment;
  abstract final double? widthFactor, heightFactor;
}

final class AlignAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<AlignAttributes>, _AlignProps {
  @override
  final AlignmentGeometry alignment;
  @override
  final double? widthFactor, heightFactor;

  const AlignAttributes({
    required this.alignment,
    this.widthFactor,
    this.heightFactor,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory AlignAttributes.fromJson(JSONObject json) {
    final view = AnimatedPropHelper(json);
    return AlignAttributes(
      alignment: AttributeValueMapper.toAlignment(json["alignment"]),
      widthFactor: NumUtils.toDouble(json["widthFactor"]),
      heightFactor: NumUtils.toDouble(json["heightFactor"]),
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  AlignAttributes copyWith(AlignAttributes other) {
    return AlignAttributes(
      alignment: other.alignment,
      widthFactor: other.widthFactor ?? widthFactor,
      heightFactor: other.heightFactor ?? heightFactor,
      parentBuilderId: other.parentBuilderId ?? parentBuilderId,
      affectedProperties: other.affectedProperties ?? affectedProperties,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        AlignAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

final class AnimatedAlignAttributes extends ImplicitAnimatable
    implements DuitAttributes<AnimatedAlignAttributes>, _AlignProps {
  @override
  final AlignmentGeometry alignment;
  @override
  final double? widthFactor, heightFactor;

  const AnimatedAlignAttributes({
    required this.alignment,
    this.widthFactor,
    this.heightFactor,
    required super.duration,
    super.curve,
    super.onEnd,
  });

  factory AnimatedAlignAttributes.fromJson(JSONObject json) {
    final action = ActionUtils(json);
    return AnimatedAlignAttributes(
      alignment: AttributeValueMapper.toAlignment(json["alignment"]),
      widthFactor: NumUtils.toDouble(json["widthFactor"]),
      heightFactor: NumUtils.toDouble(json["heightFactor"]),
      duration: AttributeValueMapper.toDuration(json["duration"]),
      curve: AttributeValueMapper.toCurve(json["curve"]),
      onEnd: action.parseAction("onEnd"),
    );
  }

  @override
  AnimatedAlignAttributes copyWith(AnimatedAlignAttributes other) {
    return AnimatedAlignAttributes(
      alignment: other.alignment,
      widthFactor: other.widthFactor ?? widthFactor,
      heightFactor: other.heightFactor ?? heightFactor,
      duration: duration,
      curve: other.curve,
      onEnd: other.onEnd,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError();
}
