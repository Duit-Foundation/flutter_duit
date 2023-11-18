import 'dart:ui';

import 'package:flutter_duit/src/attributes/attributes.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class ColoredBoxAttributes
    implements DUITAttributes<ColoredBoxAttributes> {
  Color color;

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
