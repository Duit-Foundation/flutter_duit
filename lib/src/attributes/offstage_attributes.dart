import 'package:flutter_duit/flutter_duit.dart';

final class OffstageAttributes implements DuitAttributes<OffstageAttributes> {
  final bool offstage;

  OffstageAttributes({
    required this.offstage,
  });

  factory OffstageAttributes.fromJson(Map<String, dynamic> json) {
    return OffstageAttributes(
      offstage: json["offstage"] ?? true,
    );
  }

  @override
  OffstageAttributes copyWith(OffstageAttributes other) {
    return OffstageAttributes(
      offstage: assignIfNotNull(other.offstage, offstage),
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      'fromJson' => this as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
