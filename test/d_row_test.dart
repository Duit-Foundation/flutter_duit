import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitRow tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "id": "w1",
              "controlled": true,
              "attributes": <String, dynamic>{},
              "children": <Map<String, dynamic>>[],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final rowFinder = find.byKey(const ValueKey("w1"));

          expect(rowFinder, findsOneWidget);

          final row = tester.widget<Row>(rowFinder);

          expect(row.mainAxisAlignment, MainAxisAlignment.start);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "id": "w1",
              "controlled": true,
              "attributes": <String, dynamic>{},
              "children": <Map<String, dynamic>>[],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("w1")), findsOneWidget);

          var row = tester.widget<Row>(find.byKey(const ValueKey("w1")));

          expect(row.mainAxisAlignment, MainAxisAlignment.start);

          await driver.asInternalDriver.updateAttributes(
            "w1",
            {
              "mainAxisAlignment": "spaceBetween",
            },
          );

          await tester.pumpAndSettle();

          row = tester.widget<Row>(find.byKey(const ValueKey("w1")));

          expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
        },
      );
    },
  );
}
