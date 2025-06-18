import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';

final class SliverIgnorePointerAttributes
    implements DuitAttributes<SliverIgnorePointerAttributes>, DuitSliverProps {
  final bool ignoring;
  final bool? ignoringSemantics;
  @override
  final bool needsBoxAdapter;

  const SliverIgnorePointerAttributes({
    required this.ignoring,
    required this.ignoringSemantics,
    required this.needsBoxAdapter,
  });

  factory SliverIgnorePointerAttributes.fromJson(Map<String, dynamic> json) {
    return SliverIgnorePointerAttributes(
      ignoring: json["ignoring"] ?? true,
      ignoringSemantics: json["ignoringSemantics"],
      needsBoxAdapter: json["needsBoxAdapter"] ?? false,
    );
  }

  @override
  SliverIgnorePointerAttributes copyWith(SliverIgnorePointerAttributes other) {
    return SliverIgnorePointerAttributes(
      ignoring: other.ignoring,
      ignoringSemantics: other.ignoringSemantics ?? ignoringSemantics,
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
