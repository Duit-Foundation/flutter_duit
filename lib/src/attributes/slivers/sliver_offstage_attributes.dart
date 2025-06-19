import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';

final class SliverOffstageAttributes
    implements DuitAttributes<SliverOffstageAttributes>, DuitSliverProps {
  final bool offstage;

  @override
  final bool needsBoxAdapter;

  const SliverOffstageAttributes({
    required this.offstage,
    required this.needsBoxAdapter,
  });

  factory SliverOffstageAttributes.fromJson(Map<String, dynamic> json) {
    return SliverOffstageAttributes(
      offstage: json["offstage"] ?? true,
      needsBoxAdapter: json['needsBoxAdapter'] ?? false,
    );
  }

  @override
  SliverOffstageAttributes copyWith(SliverOffstageAttributes other) {
    return SliverOffstageAttributes(
      offstage: other.offstage,
      needsBoxAdapter: needsBoxAdapter,
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
