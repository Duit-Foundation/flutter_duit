import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "DuitCustomScrollView tests",
    () {
      testWidgets(
        "DuitCustomScrollView must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "contolled": false,
              "attributes": {},
              "children": [],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("custom_view")), findsOneWidget);
        },
      );

      testWidgets(
        "DuitCustomScrollView update test",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": true,
              "attributes": {},
              "children": [],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("custom_view")), findsOneWidget);

          await driver.updateTestAttributes(
            "custom_view",
            {
              "scrollDirection": "horizontal",
              "shrinkWrap": true,
            },
          );

          await tester.pumpAndSettle();

          final CustomScrollView scrollView =
              tester.widget(find.byKey(const ValueKey("custom_view")));

          expect(scrollView.scrollDirection, Axis.horizontal);
          expect(scrollView.shrinkWrap, true);
        },
      );
    },
  );
}
