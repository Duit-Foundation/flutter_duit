import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class SafeAreaAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<SafeAreaAttributes> {
  final bool left, top, right, bottom;
  final EdgeInsets? minimum;
  final bool? maintainBottomViewPadding;

  SafeAreaAttributes({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    this.minimum,
    this.maintainBottomViewPadding,
    required super.affectedProperties,
    required super.parentBuilderId,
  });

  @override
  SafeAreaAttributes copyWith(other) {
    return SafeAreaAttributes(
      left: other.left,
      top: other.top,
      right: other.right,
      bottom: other.bottom,
      minimum: assignIfNotNull(
        other.minimum,
        minimum,
      ),
      affectedProperties: assignIfNotNull(
        other.affectedProperties,
        affectedProperties,
      ),
      parentBuilderId: assignIfNotNull(
        other.parentBuilderId,
        parentBuilderId,
      ),
      maintainBottomViewPadding:
          other.maintainBottomViewPadding ?? maintainBottomViewPadding,
    );
  }

  factory SafeAreaAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);
    return SafeAreaAttributes(
      left: view['left'] ?? true,
      top: view['top'] ?? true,
      right: view['right'] ?? true,
      bottom: view['bottom'] ?? true,
      minimum: AttributeValueMapper.toEdgeInsets(view['minimum']),
      maintainBottomViewPadding: view['maintainBottomViewPadding'],
      affectedProperties: view.affectedProperties,
      parentBuilderId: view.parentBuilderId,
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
        SafeAreaAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
