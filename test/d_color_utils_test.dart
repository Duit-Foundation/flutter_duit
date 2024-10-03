import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_duit/flutter_duit.dart';

void main() {
  const goldenDC = Color(0xFFDCDCDC);
  const goldenBlack = Color(0xFF000000);

  group("ColorUtils test", () {
    test("Color from string", () {
      final color = ColorUtils.tryParseColor("#DCDCDC");
      expect(color, isSameColorAs(goldenDC));
    });

    test("Color from [4]array", () {
      final color = ColorUtils.tryParseColor([0, 0, 0, 1]);
      expect(color, isSameColorAs(goldenBlack));
    });

    test("Color from [3]array", () {
      final color = ColorUtils.tryParseColor([0, 0, 0]);
      expect(color, isSameColorAs(goldenBlack));
    });

    test("Utils error and null values", () {
      expect(() => ColorUtils.tryParseColor("DCDCDC"), throwsArgumentError);
      expect(() => ColorUtils.tryParseColor([]), throwsArgumentError);
      expect(ColorUtils.tryParseColor({}), isSameColorAs(goldenBlack));
      expect(ColorUtils.tryParseNullableColor({}), isNull);
    });
  });
}
