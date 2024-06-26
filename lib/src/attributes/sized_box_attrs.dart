import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a SizedBox widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class SizedBoxAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<SizedBoxAttributes> {
  num? width, height;

  SizedBoxAttributes({
    this.height,
    this.width,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory SizedBoxAttributes.fromJson(JSONObject json) {
    return SizedBoxAttributes(
      width: json["width"],
      height: json["height"],
      parentBuilderId: json["parentBuilderId"],
      affectedProperties: Set.from(
        json["affectedProperties"] ?? {},
      ),
    );
  }

  @override
  SizedBoxAttributes copyWith(SizedBoxAttributes other) {
    return SizedBoxAttributes(
      width: other.width ?? width,
      height: other.height ?? height,
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
        SizedBoxAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
