import 'package:duit_kernel/duit_kernel.dart';

/// Represents the attributes for a RotatedBox widget.
final class RotatedBoxAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<RotatedBoxAttributes> {
  final int quarterTurns;

  const RotatedBoxAttributes({
    required this.quarterTurns,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  static RotatedBoxAttributes? fromJson(Map<String, dynamic> json) {
    return RotatedBoxAttributes(
      quarterTurns: json["quarterTurns"],
      parentBuilderId: json["parentBuilderId"],
      affectedProperties: json["affectedProperties"] != null
          ? Set.from(
              json["affectedProperties"],
            )
          : null,
    );
  }

  @override
  RotatedBoxAttributes copyWith(RotatedBoxAttributes other) {
    return RotatedBoxAttributes(
      quarterTurns: other.quarterTurns,
      parentBuilderId: other.parentBuilderId,
      affectedProperties: other.affectedProperties,
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
        RotatedBoxAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
