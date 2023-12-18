import 'dart:ui';

import 'package:flutter_duit/src/attributes/attributes.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a ColoredBox widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class ColoredBoxAttributes
    implements DuitAttributes<ColoredBoxAttributes> {
  final Color color;

  ColoredBoxAttributes({
    required this.color,
  });

  factory ColoredBoxAttributes.fromJson(JSONObject json) {
    return ColoredBoxAttributes(
      color: ColorUtils.tryParseColor(json["color"]),
    );
  }

  @override
  ColoredBoxAttributes copyWith(other) {
    return ColoredBoxAttributes(
      color: other.color,
    );
  }
}
