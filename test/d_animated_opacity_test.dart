import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget(double? opacity) {
  return {
    "type": "AnimatedOpacity",
    "id": "op1",
    "controlled": true,
    "attributes": {
      "opacity": opacity,
      "duration": 500,
    },
    "child": {
      "type": "Text",
      "id": "text1",
      "controlled": false,
      "attributes": {
        "data": "Text 1",
      },
    },
  };
}

void main() {
  group(
    "DuitAnimatedOpacity test set",
    () {
      testWidgets(
        "check child widget opacity",
        (t) async {
          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget(0.5),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(
            getFateTransitionOpacity(t, find.byKey(const ValueKey("text1"))),
            0.5,
          );
        },
      );

      testWidgets(
        "check child widget opacity with null opacity provided",
        (t) async {
          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget(null),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(
            getFateTransitionOpacity(t, find.byKey(const ValueKey("text1"))),
            1.0,
          );
        },
      );

      testWidgets(
        "check child widget opacity animated",
        (t) async {
          final driver = DuitDriver.static(
            _createWidget(0.5),
            transportOptions: HttpTransportOptions(),
            enableDevMetrics: false,
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(
            getFateTransitionOpacity(t, find.byKey(const ValueKey("text1"))),
            0.5,
          );

          await driver.updateTestAttributes("op1", {"opacity": 1.0});

          await t.pumpAndSettle();

          expect(
            getFateTransitionOpacity(t, find.byKey(const ValueKey("text1"))),
            1.0,
          );
        },
      );
    },
  );
}
