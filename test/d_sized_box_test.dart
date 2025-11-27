import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "DuitSizedBox tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "SizedBox",
              "id": "sb1",
              "controlled": false,
              "attributes": {
                "width": 100.0,
                "height": 50.0,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final sbFinder = find.byKey(const ValueKey("sb1"));

          expect(sbFinder, findsOneWidget);

          final sb = tester.widget<SizedBox>(sbFinder);

          expect(sb.width, 100.0);
          expect(sb.height, 50.0);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "SizedBox",
              "id": "sb1",
              "controlled": true,
              "attributes": {
                "width": 100.0,
                "height": 50.0,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          expect(find.byKey(const ValueKey("sb1")), findsOneWidget);

          var sb = tester.widget<SizedBox>(find.byKey(const ValueKey("sb1")));

          expect(sb.width, 100.0);
          expect(sb.height, 50.0);

          await driver.updateAttributes(
            "sb1",
            {
              "width": 200.0,
              "height": 80.0,
            },
          );

          await tester.pumpAndSettle();

          sb = tester.widget<SizedBox>(find.byKey(const ValueKey("sb1")));

          expect(sb.width, 200.0);
          expect(sb.height, 80.0);
        },
      );
    },
  );
}
