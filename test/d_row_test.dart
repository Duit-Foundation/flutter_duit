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
          final driver = DuitDriver.static(
            {
              "type": "Row",
              "id": "w1",
              "controlled": true,
              "attributes": <String, dynamic>{},
              "children": <Map<String, dynamic>>[],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final rowFinder = find.byKey(const ValueKey("w1"));

          expect(rowFinder, findsOneWidget);

          final row = tester.widget<Row>(rowFinder);

          expect(row.mainAxisAlignment, MainAxisAlignment.start);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Row",
              "id": "w1",
              "controlled": true,
              "attributes": <String, dynamic>{},
              "children": <Map<String, dynamic>>[],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          expect(find.byKey(const ValueKey("w1")), findsOneWidget);

          var row = tester.widget<Row>(find.byKey(const ValueKey("w1")));

          expect(row.mainAxisAlignment, MainAxisAlignment.start);

          await driver.updateAttributes(
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
