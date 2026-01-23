import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitAspectRatio tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "AspectRatio",
              "id": "ar1",
              "controlled": false,
              "attributes": {
                "aspectRatio": 2.0,
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": {
                  "width": 100.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final arFinder = find.byKey(const ValueKey("ar1"));

          expect(arFinder, findsOneWidget);

          final ar = tester.widget<AspectRatio>(arFinder);

          expect(ar.aspectRatio, 2.0);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "AspectRatio",
              "id": "ar1",
              "controlled": true,
              "attributes": {
                "aspectRatio": 2.0,
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": {
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("ar1")), findsOneWidget);

          var ar = tester.widget<AspectRatio>(
            find.byKey(const ValueKey("ar1")),
          );

          expect(ar.aspectRatio, 2.0);

          await driver.asInternalDriver.updateAttributes(
            "ar1",
            {
              "aspectRatio": 1.5,
            },
          );

          await tester.pumpAndSettle();

          ar = tester.widget<AspectRatio>(
            find.byKey(const ValueKey("ar1")),
          );

          expect(ar.aspectRatio, 1.5);
        },
      );
    },
  );
}
