import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';

final class SliverPaddingAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<SliverPaddingAttributes>, DuitSliverProps {
  final EdgeInsetsGeometry padding;

  @override
  final bool needsBoxAdapter;

  const SliverPaddingAttributes({
    required this.padding,
    required this.needsBoxAdapter,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory SliverPaddingAttributes.fromJson(Map<String, dynamic> json) {
    final animation = AnimatedPropHelper(json);
    return SliverPaddingAttributes(
      padding: AttributeValueMapper.toEdgeInsets(json['padding']),
      needsBoxAdapter: json['wrapChild'] ?? false,
      parentBuilderId: animation.parentBuilderId,
      affectedProperties: animation.affectedProperties,
    );
  }

  @override
  SliverPaddingAttributes copyWith(SliverPaddingAttributes other) {
    return SliverPaddingAttributes(
      padding: other.padding,
      needsBoxAdapter: needsBoxAdapter,
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
        SliverPaddingAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
