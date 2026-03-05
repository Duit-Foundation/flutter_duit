import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "mocks/custom.dart";

void main() {
  group(
    "Custom widget tests",
    () {
      setUpAll(() async {
        await regCustom();
      });

      testWidgets(
        "must create custom widget",
        (t) async {
          final driver = XDriver.static(
            {
              "type": "Custom",
              "tag": exampleCustomWidget,
              "id": "custom",
              "controlled": true,
            },
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost.withDriver(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.byType(Text), findsOneWidget);
        },
      );

      testWidgets(
        "must render child",
        (t) async {
          final driver = XDriver.static(
            {
              "type": "Custom",
              "tag": exampleCustomWidget,
              "id": "custom",
              "controlled": true,
              "children": [
                {
                  "type": "Text",
                  "attributes": {
                    "data": "Hello",
                  },
                  "id": "text",
                  "controlled": false,
                },
              ],
            },
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost.withDriver(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.text("Hello"), findsOneWidget);
        },
      );

      testWidgets(
        "must update custom widget",
        (t) async {
          final driver = XDriver.static(
            {
              "type": "Custom",
              "tag": exampleCustomWidget,
              "id": "custom",
              "controlled": true,
            },
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost.withDriver(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.byType(Text), findsOneWidget);

          await driver.asInternalDriver.updateAttributes(
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
          final driver = XDriver.static(
            {
              "type": "Custom",
              "tag": "invalid_tag",
              "id": "custom",
              "controlled": true,
            },
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost.withDriver(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.byType(SizedBox), findsOneWidget);
        },
      );

      testWidgets(
        "must use provided theme",
        (t) async {
          final driver = XDriver.static(
            {
              "type": "Custom",
              "tag": exampleCustomWidget,
              "attributes": {
                "theme": "custom_1",
              },
              "id": "custom",
              "controlled": true,
            },
          );

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost.withDriver(
                driver: driver,
              ),
            ),
          );

          await t.pumpAndSettle();

          expect(find.byType(Text), findsOneWidget);

          expect(find.text("100500"), findsOneWidget);
        },
      );
    },
  );
}
