import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';

final class SliverSafeAreaAttributes
    implements DuitAttributes<SliverSafeAreaAttributes>, DuitSliverProps {
  final bool left, top, right, bottom;
  final EdgeInsets? minimum;
  final bool? maintainBottomViewPadding;

  @override
  final bool needsBoxAdapter;

  const SliverSafeAreaAttributes({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    this.minimum,
    this.maintainBottomViewPadding,
    required this.needsBoxAdapter,
  });

  factory SliverSafeAreaAttributes.fromJson(Map<String, dynamic> json) {
    final animation = AnimatedPropHelper(json);
    return SliverSafeAreaAttributes(
      left: json['left'] ?? true,
      top: json['top'] ?? true,
      right: json['right'] ?? true,
      bottom: json['bottom'] ?? true,
      minimum: AttributeValueMapper.toEdgeInsets(json['minimum']),
      maintainBottomViewPadding: json['maintainBottomViewPadding'],
      needsBoxAdapter: json['needsBoxAdapter'] ?? false,
    );
  }

  @override
  SliverSafeAreaAttributes copyWith(SliverSafeAreaAttributes other) {
    return SliverSafeAreaAttributes(
      left: other.left,
      top: other.top,
      right: other.right,
      bottom: other.bottom,
      minimum: other.minimum,
      maintainBottomViewPadding: other.maintainBottomViewPadding,
      needsBoxAdapter: needsBoxAdapter, //prevents copy with default value
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
