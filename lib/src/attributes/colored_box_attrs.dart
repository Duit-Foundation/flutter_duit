import 'dart:ui';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a ColoredBox widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class ColoredBoxAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<ColoredBoxAttributes> {
  final Color color;

  ColoredBoxAttributes({
    required this.color,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory ColoredBoxAttributes.fromJson(JSONObject json) {
    return ColoredBoxAttributes(
      color: ColorUtils.tryParseColor(json["color"]),
      parentBuilderId: json["parentBuilderId"],
      affectedProperties: Set.from(
        json["affectedProperties"] ?? {},
      ),
    );
  }

  @override
  ColoredBoxAttributes copyWith(other) {
    return ColoredBoxAttributes(
      color: other.color,
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
        ColoredBoxAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
