import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_duit/flutter_duit.dart';

void main() {
  group("DuitColoredBox widget tests", () {
    testWidgets("check color", (WidgetTester tester) async {
      final driver = DuitDriver.static(
        {
          "type": "ColoredBox",
          "id": "colored",
          "attributes": {"color": "#933C3C"},
        },
        transportOptions: HttpTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final coloredBox = find.byKey(const ValueKey("colored"));

      expect(coloredBox, findsOneWidget);
      expect(coloredBox, paints..rect(color: const Color(0xFF933C3C)));
    });

    testWidgets("check animation", (WidgetTester tester) async {
      final driver = DuitDriver.static(
        {
          "type": "AnimatedBuilder",
          "id": "animated",
          "controlled": true,
          "attributes": {
            "tweenDescriptions": [
              {
                "type": "colorTween",
                "animatedPropKey": "color",
                "duration": 500,
                "begin": "#075eeb",
                "end": "#DCDCDC",
                "curve": "linear",
                "trigger": 0,
                "method": 0,
              }
            ],
          },
          "child": {
            "type": "ColoredBox",
            "id": "colored",
            "attributes": {
              "parentBuilderId": "animated",
              "affectedProperties": {
                "color",
              },
            },
          },
        },
        transportOptions: HttpTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final coloredBox = find.byKey(const ValueKey("colored"));

      expect(coloredBox, paints..rect(color: const Color(0xFFDCDCDC)));
    });
  });
}
