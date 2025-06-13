import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SliverOpacityAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<SliverOpacityAttributes>, DuitSliverProps {
  final double opacity;

  @override
  final bool needsBoxAdapter;

  const SliverOpacityAttributes({
    required this.opacity,
    required this.needsBoxAdapter,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory SliverOpacityAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);
    return SliverOpacityAttributes(
      opacity: NumUtils.toDoubleWithNullReplacement(
        json["opacity"],
        1.0,
      ),
      needsBoxAdapter: json['needsBoxAdapter'] ?? false,
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  SliverOpacityAttributes copyWith(other) {
    return SliverOpacityAttributes(
      opacity: other.opacity,
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
        SliverOpacityAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
