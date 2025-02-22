import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "mocks/custom.dart";

void main() {
  group(
    "Custom widget tests",
    () {
      setUpAll(() {
        regCustom();
      });

      testWidgets(
        "must create custom widget",
        (t) async {
          final driver = DuitDriver.static(
            {
              "type": "Custom",
              "tag": exampleCustomWidget,
              "attributes": {},
              "id": "custom",
              "controlled": true,
            },
            transportOptions: EmptyTransportOptions(),
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.byType(Text), findsOneWidget);
        },
      );

      testWidgets(
        "must update custom widget",
        (t) async {
          final driver = DuitDriver.static(
            {
              "type": "Custom",
              "tag": exampleCustomWidget,
              "attributes": {},
              "id": "custom",
              "controlled": true,
            },
            transportOptions: EmptyTransportOptions(),
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.byType(Text), findsOneWidget);

          await driver.updateTestAttributes(
            "custom",
            {
              "random": "value",
            },
          );

          await t.pumpAndSettle();

          expect(find.text("value"), findsOneWidget);
        },
      );

      testWidgets(
        "must create empty view when invalid tag provided",
        (t) async {
          final driver = DuitDriver.static(
            {
              "type": "Custom",
              "tag": "invalid_tag",
              "attributes": {},
              "id": "custom",
              "controlled": true,
            },
            transportOptions: EmptyTransportOptions(),
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.byType(SizedBox), findsOneWidget);
        },
      );
    },
  );
}
