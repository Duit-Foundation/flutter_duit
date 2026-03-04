import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/index.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "BadgeVariant tests",
    () {
      test(
        "BadgeVariant.fromValue must parse string values",
        () {
          expect(
            BadgeVariant.fromValue("common"),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue("count"),
            BadgeVariant.count,
          );
        },
      );

      test(
        "BadgeVariant.fromValue must parse int values",
        () {
          expect(
            BadgeVariant.fromValue(0),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue(1),
            BadgeVariant.count,
          );
        },
      );

      test(
        "BadgeVariant.fromValue must return common for unknown string values",
        () {
          expect(
            BadgeVariant.fromValue("unknown"),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue("invalid"),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue(""),
            BadgeVariant.common,
          );
        },
      );

      test(
        "BadgeVariant.fromValue must return common for unknown int values",
        () {
          expect(
            BadgeVariant.fromValue(2),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue(-1),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue(100),
            BadgeVariant.common,
          );
        },
      );

      test(
        "BadgeVariant.fromValue must return common for other types",
        () {
          expect(
            BadgeVariant.fromValue(true),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue(false),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue(3.14),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue(null),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue([]),
            BadgeVariant.common,
          );
          expect(
            BadgeVariant.fromValue({}),
            BadgeVariant.common,
          );
        },
      );
    },
  );

  group(
    "DuitBadge tests",
    () {
      group(
        "common variant",
        () {
          testWidgets(
            "must renders correctly",
            (tester) async {
              final driver = XDriver.static(
                {
                  "type": "Badge",
                  "id": "Badge",
                  "attributes": <String, dynamic>{},
                  "children": [
                    {
                      "type": "Text",
                      "id": "child",
                      "attributes": <String, dynamic>{
                        "data": "Text",
                      },
                    },
                    {
                      "type": "Container",
                      "id": "label",
                      "attributes": <String, dynamic>{
                        "width": 25,
                        "height": 25,
                        "color": Colors.amber,
                      },
                    },
                  ],
                },
              );

              await pumpDriver(tester, driver.asInternalDriver);

              final badge = find.byKey(const ValueKey("Badge"));
              final child = find.byKey(const ValueKey("child"));
              final label = find.byKey(const ValueKey("label"));

              expect(badge, findsOneWidget);
              expect(child, findsOneWidget);
              expect(label, findsOneWidget);
            },
          );

          testWidgets(
            "must update attributes correctly",
            (tester) async {
              final driver = XDriver.static(
                {
                  "type": "Badge",
                  "id": "Badge",
                  "controlled": true,
                  "attributes": <String, dynamic>{},
                  "children": [
                    {
                      "type": "Text",
                      "id": "child",
                      "attributes": <String, dynamic>{
                        "data": "Text",
                      },
                    },
                    {
                      "type": "Container",
                      "id": "label",
                      "attributes": <String, dynamic>{
                        "width": 25,
                        "height": 25,
                        "color": Colors.amber,
                      },
                    },
                  ],
                },
              );

              await pumpDriver(tester, driver.asInternalDriver);

              final badge = find.byKey(const ValueKey("Badge"));
              final child = find.byKey(const ValueKey("child"));
              final label = find.byKey(const ValueKey("label"));

              expect(badge, findsOneWidget);
              expect(child, findsOneWidget);
              expect(label, findsOneWidget);

              var badgeWidget = tester.widget<Badge>(badge);

              expect(badgeWidget.padding, null);

              await driver.asInternalDriver.updateAttributes("Badge", {
                "padding": [12, 12],
              });

              await tester.pumpAndSettle();

              badgeWidget = tester.widget<Badge>(badge);

              expect(
                badgeWidget.padding,
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              );
            },
          );
        },
      );
      group(
        "count variant",
        () {
          testWidgets(
            "must renders correctly",
            (tester) async {
              final driver = XDriver.static(
                {
                  "type": "Badge",
                  "id": "Badge",
                  "attributes": <String, dynamic>{
                    "variant": 1,
                    "count": 100,
                  },
                  "children": [
                    {
                      "type": "Text",
                      "id": "child",
                      "attributes": <String, dynamic>{
                        "data": "Text",
                      },
                    },
                    {
                      "type": "Container",
                      "id": "label",
                      "attributes": <String, dynamic>{
                        "width": 25,
                        "height": 25,
                        "color": Colors.amber,
                      },
                    },
                  ],
                },
              );

              await pumpDriver(tester, driver.asInternalDriver);

              final badge = find.byKey(const ValueKey("Badge"));
              final badgeCount = find.text("100");
              final child = find.byKey(const ValueKey("child"));
              final label = find.byKey(const ValueKey("label"));

              expect(badge, findsOneWidget);
              expect(child, findsOneWidget);
              expect(label, findsNothing);
              expect(badgeCount, findsOneWidget);
            },
          );

          testWidgets(
            "must update attributes correctly",
            (tester) async {
              final driver = XDriver.static(
                {
                  "type": "Badge",
                  "id": "Badge",
                  "controlled": true,
                  "attributes": <String, dynamic>{
                    "variant": 1,
                    "count": 100,
                  },
                  "children": [
                    {
                      "type": "Text",
                      "id": "child",
                      "attributes": <String, dynamic>{
                        "data": "Text",
                      },
                    },
                    {
                      "type": "Container",
                      "id": "label",
                      "attributes": <String, dynamic>{
                        "width": 25,
                        "height": 25,
                        "color": Colors.amber,
                      },
                    },
                  ],
                },
              );

              await pumpDriver(tester, driver.asInternalDriver);

              final badge = find.byKey(const ValueKey("Badge"));
              final badgeCount = find.text("100");
              final child = find.byKey(const ValueKey("child"));
              final label = find.byKey(const ValueKey("label"));

              expect(badge, findsOneWidget);
              expect(child, findsOneWidget);
              expect(label, findsNothing);
              expect(badgeCount, findsOneWidget);

              var badgeWidget = tester.widget<Badge>(badge);

              expect(badgeWidget.padding, null);

              await driver.asInternalDriver.updateAttributes("Badge", {
                "padding": [12, 12],
              });

              await tester.pumpAndSettle();

              badgeWidget = tester.widget<Badge>(badge);

              expect(
                badgeWidget.padding,
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              );
            },
          );
        },
      );
    },
  );
}
