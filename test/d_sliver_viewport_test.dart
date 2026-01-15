import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitFillViewport",
    () {
      testWidgets(
        "must renders correctry",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverFillViewport",
                  "id": "viewport_sliver",
                  "controlled": false,
                  "attributes": {
                    "viewportFraction": 0.8,
                    "isBuilderDelegate": false,
                  },
                  "children": List.generate(
                    10,
                    (i) {
                      return {
                        "type": "Container",
                        "id": i.toString(),
                        "controlled": false,
                        "attributes": {
                          "color": generateHexColor(i),
                        },
                      };
                    },
                  ),
                }
              ],
            },
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(find.byKey(const ValueKey("viewport_sliver")), findsOneWidget);

          final scroll = find.byType(Scrollable);

          final itemLast = find.byKey(const ValueKey("9"));

          await tester.scrollUntilVisible(
            itemLast,
            1000,
            scrollable: scroll,
          );

          expect(find.byKey(const ValueKey("9")), findsOneWidget);
        },
      );
    },
  );

  group(
    "DuitControllerFillViewport",
    () {
      testWidgets(
        "must renders correctry (simple delegate)",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverFillViewport",
                  "id": "viewport_sliver",
                  "controlled": true,
                  "attributes": {
                    "viewportFraction": 0.8,
                    "isBuilderDelegate": false,
                  },
                  "children": List.generate(
                    10,
                    (i) {
                      return {
                        "type": "Container",
                        "id": i.toString(),
                        "controlled": false,
                        "attributes": {
                          "color": generateHexColor(i),
                        },
                      };
                    },
                  ),
                }
              ],
            },
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(find.byKey(const ValueKey("viewport_sliver")), findsOneWidget);
          expect(find.byKey(const ValueKey("0")), findsOneWidget);

          final scroll = find.byType(Scrollable);

          final itemLast = find.byKey(const ValueKey("9"));

          await tester.scrollUntilVisible(
            itemLast,
            1000,
            scrollable: scroll,
          );

          expect(find.byKey(const ValueKey("9")), findsOneWidget);
        },
      );

      testWidgets(
        "must renders correctry (builder delegate)",
        (tester) async {
          final children = List.generate(
            10,
            (i) {
              return {
                "type": "Container",
                "id": i.toString(),
                "controlled": false,
                "attributes": {
                  "color": generateHexColor(i),
                },
              } as Map<String, dynamic>;
            },
          );

          final driver = XDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverFillViewport",
                  "id": "viewport_sliver",
                  "controlled": true,
                  "attributes": {
                    "viewportFraction": 0.8,
                    "isBuilderDelegate": true,
                    "childObjects": children,
                    "childCount": 10,
                  },
                }
              ],
            },
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(find.byKey(const ValueKey("viewport_sliver")), findsOneWidget);
          expect(find.byKey(const ValueKey("0")), findsOneWidget);

          final scroll = find.byType(Scrollable);

          final itemLast = find.byKey(const ValueKey("9"));

          await tester.scrollUntilVisible(
            itemLast,
            500,
            scrollable: scroll,
          );

          expect(find.byKey(const ValueKey("9")), findsOneWidget);
        },
      );
    },
  );
}
