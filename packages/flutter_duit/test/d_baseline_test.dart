import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitBaseline tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Baseline",
              "id": "baseline1",
              "controlled": false,
              "attributes": {
                "baseline": 20.0,
                "baselineType": "alphabetic",
              },
              "child": {
                "type": "Text",
                "id": "text",
                "controlled": false,
                "attributes": {
                  "data": "Test text",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final baselineFinder = find.byKey(const ValueKey("baseline1"));

          expect(baselineFinder, findsOneWidget);

          final baseline = tester.widget<Baseline>(baselineFinder);

          expect(baseline.baseline, 20.0);
          expect(baseline.baselineType, TextBaseline.alphabetic);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Baseline",
              "id": "baseline1",
              "controlled": true,
              "attributes": {
                "baseline": 20.0,
                "baselineType": "alphabetic",
              },
              "child": {
                "type": "Text",
                "id": "text",
                "controlled": false,
                "attributes": {
                  "data": "Test text",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("baseline1")), findsOneWidget);

          var baseline = tester.widget<Baseline>(
            find.byKey(const ValueKey("baseline1")),
          );

          expect(baseline.baseline, 20.0);
          expect(baseline.baselineType, TextBaseline.alphabetic);

          await driver.asInternalDriver.updateAttributes(
            "baseline1",
            {
              "baseline": 40.0,
              "baselineType": "ideographic",
            },
          );

          await tester.pumpAndSettle();

          baseline = tester.widget<Baseline>(
            find.byKey(const ValueKey("baseline1")),
          );

          expect(baseline.baseline, 40.0);
          expect(baseline.baselineType, TextBaseline.ideographic);
        },
      );
    },
  );
}
