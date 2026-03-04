import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitFractionalTranslation tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "FractionalTranslation",
              "id": "ft1",
              "controlled": false,
              "attributes": {
                "translation": {"dx": 0.5, "dy": 0.25},
                "transformHitTests": true,
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

          final ftFinder = find.byKey(const ValueKey("ft1"));

          expect(ftFinder, findsOneWidget);

          final ft = tester.widget<FractionalTranslation>(ftFinder);

          expect(ft.translation, const Offset(0.5, 0.25));
          expect(ft.transformHitTests, true);
        },
      );

      testWidgets(
        "must render with default transformHitTests",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "FractionalTranslation",
              "id": "ft2",
              "controlled": false,
              "attributes": {
                "translation": {"dx": 0.3, "dy": 0.7},
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

          final ftFinder = find.byKey(const ValueKey("ft2"));

          expect(ftFinder, findsOneWidget);

          final ft = tester.widget<FractionalTranslation>(ftFinder);

          expect(ft.translation, const Offset(0.3, 0.7));
          expect(ft.transformHitTests, true); // default value
        },
      );

      testWidgets(
        "must render with transformHitTests false",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "FractionalTranslation",
              "id": "ft3",
              "controlled": false,
              "attributes": {
                "translation": {"dx": 0.0, "dy": 0.0},
                "transformHitTests": false,
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

          final ftFinder = find.byKey(const ValueKey("ft3"));

          expect(ftFinder, findsOneWidget);

          final ft = tester.widget<FractionalTranslation>(ftFinder);

          expect(ft.translation, Offset.zero);
          expect(ft.transformHitTests, false);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "FractionalTranslation",
              "id": "ft4",
              "controlled": true,
              "attributes": {
                "translation": {"dx": 0.2, "dy": 0.4},
                "transformHitTests": true,
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

          expect(find.byKey(const ValueKey("ft4")), findsOneWidget);

          var ft = tester.widget<FractionalTranslation>(
            find.byKey(const ValueKey("ft4")),
          );

          expect(ft.translation, const Offset(0.2, 0.4));
          expect(ft.transformHitTests, true);

          await driver.asInternalDriver.updateAttributes(
            "ft4",
            {
              "translation": {"dx": 0.8, "dy": 0.6},
              "transformHitTests": false,
            },
          );

          await tester.pumpAndSettle();

          ft = tester.widget<FractionalTranslation>(
            find.byKey(const ValueKey("ft4")),
          );

          expect(ft.translation, const Offset(0.8, 0.6));
          expect(ft.transformHitTests, false);
        },
      );

      testWidgets(
        "must handle negative translation values",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "FractionalTranslation",
              "id": "ft5",
              "controlled": false,
              "attributes": {
                "translation": {"dx": -0.3, "dy": -0.5},
                "transformHitTests": true,
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

          final ftFinder = find.byKey(const ValueKey("ft5"));

          expect(ftFinder, findsOneWidget);

          final ft = tester.widget<FractionalTranslation>(ftFinder);

          expect(ft.translation, const Offset(-0.3, -0.5));
          expect(ft.transformHitTests, true);
        },
      );
    },
  );
}
