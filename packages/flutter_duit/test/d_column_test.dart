import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitColumn tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Column",
              "id": "w1",
              "controlled": true,
              "attributes": <String, dynamic>{},
              "children": <Map<String, dynamic>>[],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final colFinder = find.byKey(const ValueKey("w1"));

          expect(colFinder, findsOneWidget);

          final column = tester.widget<Column>(colFinder);

          expect(column.mainAxisAlignment, MainAxisAlignment.start);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Column",
              "id": "w1",
              "controlled": true,
              "attributes": <String, dynamic>{},
              "children": <Map<String, dynamic>>[],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("w1")), findsOneWidget);

          var column = tester.widget<Column>(find.byKey(const ValueKey("w1")));

          expect(column.mainAxisAlignment, MainAxisAlignment.start);

          await driver.asInternalDriver.updateAttributes(
            "w1",
            {
              "mainAxisAlignment": "spaceBetween",
            },
          );

          await tester.pumpAndSettle();

          column = tester.widget<Column>(find.byKey(const ValueKey("w1")));

          expect(column.mainAxisAlignment, MainAxisAlignment.spaceBetween);
        },
      );
    },
  );
}
