import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitLimitedBox tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "LimitedBox",
              "id": "lb1",
              "controlled": false,
              "attributes": {
                "maxWidth": 100.0,
                "maxHeight": 50.0,
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": {
                  "width": 200.0,
                  "height": 200.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final lbFinder = find.byKey(const ValueKey("lb1"));

          expect(lbFinder, findsOneWidget);

          final lb = tester.widget<LimitedBox>(lbFinder);

          expect(lb.maxWidth, 100.0);
          expect(lb.maxHeight, 50.0);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "LimitedBox",
              "id": "lb1",
              "controlled": true,
              "attributes": {
                "maxWidth": 100.0,
                "maxHeight": 50.0,
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

          expect(find.byKey(const ValueKey("lb1")), findsOneWidget);

          var lb = tester.widget<LimitedBox>(
            find.byKey(const ValueKey("lb1")),
          );

          expect(lb.maxWidth, 100.0);
          expect(lb.maxHeight, 50.0);

          await driver.asInternalDriver.updateAttributes(
            "lb1",
            {
              "maxWidth": 200.0,
              "maxHeight": 80.0,
            },
          );

          await tester.pumpAndSettle();

          lb = tester.widget<LimitedBox>(
            find.byKey(const ValueKey("lb1")),
          );

          expect(lb.maxWidth, 200.0);
          expect(lb.maxHeight, 80.0);
        },
      );
    },
  );
}
