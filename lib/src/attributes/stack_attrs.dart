import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Stack widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class StackAttributes implements DuitAttributes<StackAttributes> {
  final AlignmentGeometry? alignment;
  final TextDirection? textDirection;
  final StackFit? fit;
  final Clip? clipBehavior;

  StackAttributes({
    required this.alignment,
    this.textDirection,
    required this.fit,
    required this.clipBehavior,
  });

  factory StackAttributes.fromJson(JSONObject json) {
    return StackAttributes(
      alignment: ParamsMapper.convertToAlignmentDirectional(json["alignment"]),
      textDirection: ParamsMapper.convertToTextDirection(json["textDirection"]),
      fit: ParamsMapper.convertToStackFit(json["fit"]),
      clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
    );
  }

  @override
  StackAttributes copyWith(other) {
    return StackAttributes(
      alignment: other.alignment ?? alignment,
      textDirection: other.textDirection ?? textDirection,
      fit: other.fit ?? fit,
      clipBehavior: other.clipBehavior ?? clipBehavior,
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
        StackAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
