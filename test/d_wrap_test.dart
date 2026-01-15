import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitWrap tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Wrap",
              "id": "w1",
              "controlled": false,
              "attributes": {
                "spacing": 12,
                "runSpacing": 24,
              },
              "children": <Map<String, dynamic>>[],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final wFinder = find.byKey(const ValueKey("w1"));

          expect(wFinder, findsOneWidget);

          final wrap = tester.widget<Wrap>(wFinder);

          expect(wrap.spacing, 12);
          expect(wrap.runSpacing, 24);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Wrap",
              "id": "w1",
              "controlled": true,
              "attributes": {
                "spacing": 12,
                "runSpacing": 24,
              },
              "children": <Map<String, dynamic>>[],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("w1")), findsOneWidget);

          var wrap = tester.widget<Wrap>(find.byKey(const ValueKey("w1")));

          expect(wrap.spacing, 12);
          expect(wrap.runSpacing, 24);

          await driver.asInternalDriver.updateAttributes(
            "w1",
            {
              "spacing": 24,
              "runSpacing": 12,
            },
          );

          await tester.pumpAndSettle();

          wrap = tester.widget<Wrap>(find.byKey(const ValueKey("w1")));

          expect(wrap.spacing, 24);
          expect(wrap.runSpacing, 12);
        },
      );
    },
  );
}
