import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';

final class SliverIgnorePointerAttributes
    implements DuitAttributes<SliverIgnorePointerAttributes>, DuitSliverProps {
  final bool ignoring;

  @override
  final bool needsBoxAdapter;

  const SliverIgnorePointerAttributes({
    required this.ignoring,
    required this.needsBoxAdapter,
  });

  factory SliverIgnorePointerAttributes.fromJson(Map<String, dynamic> json) {
    return SliverIgnorePointerAttributes(
      ignoring: json["ignoring"] ?? true,
      needsBoxAdapter: json["needsBoxAdapter"] ?? false,
    );
  }

  @override
  SliverIgnorePointerAttributes copyWith(SliverIgnorePointerAttributes other) {
    return SliverIgnorePointerAttributes(
      ignoring: other.ignoring,
      needsBoxAdapter: other.needsBoxAdapter,
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
