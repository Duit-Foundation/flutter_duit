import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';

final class SliverFillRemainingAttributes
    implements DuitAttributes<SliverFillRemainingAttributes>, DuitSliverProps {
  final bool hasScrollBody, fillOverscroll;
  @override
  final bool needsBoxAdapter;

  const SliverFillRemainingAttributes({
    required this.hasScrollBody,
    required this.fillOverscroll,
    required this.needsBoxAdapter,
  });

  factory SliverFillRemainingAttributes.fromJson(Map<String, dynamic> json) {
    return SliverFillRemainingAttributes(
      hasScrollBody: json["hasScrollBody"] ?? true,
      fillOverscroll: json["fillOverscroll"] ?? false,
      needsBoxAdapter: json["needsBoxAdapter"] ?? false,
    );
  }

  @override
  SliverFillRemainingAttributes copyWith(SliverFillRemainingAttributes other) {
    return SliverFillRemainingAttributes(
      hasScrollBody: other.hasScrollBody,
      fillOverscroll: other.fillOverscroll,
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
