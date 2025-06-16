import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "DuitPadding tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Padding",
              "id": "w1",
              "controlled": false,
              "attributes": {
                "padding": 12,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final wFinder = find.byKey(const ValueKey("w1"));

          expect(wFinder, findsOneWidget);

          final paddingWidget = tester.widget<Padding>(wFinder);

          expect(paddingWidget.padding, const EdgeInsets.all(12));
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Padding",
              "id": "w1",
              "controlled": true,
              "attributes": {
                "padding": [
                  12,
                  24,
                ],
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final wFinder = find.byKey(const ValueKey("w1"));

          expect(wFinder, findsOneWidget);

          var paddingWidget = tester.widget<Padding>(wFinder);

          expect(
            paddingWidget.padding,
            const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 24,
            ),
          );

          await driver.updateTestAttributes(
            "w1",
            {
              "padding": [
                2,
                4,
                6,
                8,
              ],
            },
          );

          await tester.pumpAndSettle();

          paddingWidget =
              tester.widget<Padding>(find.byKey(const ValueKey("w1")));

          expect(
            paddingWidget.padding,
            const EdgeInsets.only(
              left: 2,
              top: 4,
              right: 6,
              bottom: 8,
            ),
          );
        },
      );
    },
  );
}
