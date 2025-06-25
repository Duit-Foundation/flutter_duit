import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "DuitPositioned tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Stack",
              "id": "stack",
              "controlled": false,
              "children": [
                {
                  "type": "Positioned",
                  "id": "w1",
                  "controlled": false,
                  "attributes": {
                    "top": 12,
                    "left": 12,
                  },
                },
              ]
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final wFinder = find.byKey(const ValueKey("w1"));

          expect(wFinder, findsOneWidget);

          final posWidget = tester.widget<Positioned>(wFinder);

          expect(posWidget.top, 12);
          expect(posWidget.left, 12);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Stack",
              "id": "stack",
              "controlled": false,
              "children": [
                {
                  "type": "Positioned",
                  "id": "w1",
                  "controlled": true,
                  "attributes": {
                    "top": 12,
                    "left": 12,
                  },
                },
              ]
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          var wFinder = find.byKey(const ValueKey("w1"));

          expect(wFinder, findsOneWidget);

          var posWidget = tester.widget<Positioned>(wFinder);

          expect(posWidget.top, 12);
          expect(posWidget.left, 12);

          await driver.updateTestAttributes(
            "w1",
            {
              "right": 12,
              "bottom": 12,
            },
          );

          await tester.pumpAndSettle();

          wFinder = find.byKey(const ValueKey("w1"));
          posWidget = tester.widget<Positioned>(wFinder);

          expect(posWidget.right, 12);
          expect(posWidget.bottom, 12);
        },
      );
    },
  );
}
