import 'package:flutter_duit/flutter_duit.dart';

final class SliverFillRemainingAttributes
    implements DuitAttributes<SliverFillRemainingAttributes> {
  final bool hasScrollBody, fillOverscroll;

  const SliverFillRemainingAttributes({
    required this.hasScrollBody,
    required this.fillOverscroll,
  });

  factory SliverFillRemainingAttributes.fromJson(Map<String, dynamic> json) {
    return SliverFillRemainingAttributes(
      hasScrollBody: json["hasScrollBody"] ?? true,
      fillOverscroll: json["fillOverscroll"] ?? false,
    );
  }

  @override
  SliverFillRemainingAttributes copyWith(SliverFillRemainingAttributes other) {
    return SliverFillRemainingAttributes(
      hasScrollBody: other.hasScrollBody,
      fillOverscroll: other.fillOverscroll,
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
