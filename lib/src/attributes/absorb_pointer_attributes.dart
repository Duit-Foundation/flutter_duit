import 'package:flutter_duit/flutter_duit.dart';

final class AbsorbPointerAttributes
    implements DuitAttributes<AbsorbPointerAttributes> {
  final bool absorbing;

  const AbsorbPointerAttributes({
    required this.absorbing,
  });

  factory AbsorbPointerAttributes.fromJson(Map<String, dynamic> json) {
    return AbsorbPointerAttributes(
      absorbing: json["absorbing"] ?? true,
    );
  }

  @override
  AbsorbPointerAttributes copyWith(AbsorbPointerAttributes other) {
    return AbsorbPointerAttributes(
      absorbing: assignIfNotNull(other.absorbing, absorbing),
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName,
      {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    return switch (methodName) {
      'fromJson' => this as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
