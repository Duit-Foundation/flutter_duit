import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitSliverGrid tests",
    () {
      final arr = <Map<String, dynamic>>[];

      for (var i = 0; i < 20; i++) {
        arr.add({
          "type": "Container",
          "controlled": false,
          "id": i.toString(),
          "attributes": {
            "color": "#DCDCDC",
            "width": 25,
            "height": 25,
          },
        });
      }

      group("SliverGrid.common consructor", () {
        testWidgets(
          "must renders correctly",
          (WidgetTester tester) async {
            final driver = XDriver.static(
              {
                "type": "CustomScrollView",
                "controlled": false,
                "id": "scroll_view",
                "children": [
                  {
                    "type": "SliverGrid",
                    "controlled": false,
                    "id": "grid",
                    "children": arr,
                    "attributes": {
                      "sliverGridDelegateKey": "delegate1",
                      "constructor": "common",
                    },
                  },
                ],
              },
            );

            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: DuitViewHost.withDriver(
                  driver: driver,
                  sliverGridDelegatesRegistry: {
                    "delegate1": (_) =>
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                  },
                ),
              ),
            );

            await tester.pumpAndSettle();

            final grid = find.byKey(const ValueKey("grid"));

            expect(grid, findsOneWidget);
          },
        );

        testWidgets(
          "must update attributes correctly",
          (WidgetTester tester) async {
            final driver = XDriver.static(
              {
                "type": "CustomScrollView",
                "controlled": false,
                "id": "scroll_view",
                "children": [
                  {
                    "type": "SliverGrid",
                    "controlled": true,
                    "id": "grid",
                    "children": arr,
                    "attributes": {
                      "sliverGridDelegateKey": "delegate1",
                      "constructor": "common",
                    },
                  },
                ],
              },
            );

            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: DuitViewHost.withDriver(
                  driver: driver,
                  sliverGridDelegatesRegistry: {
                    "delegate1": (_) =>
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    "delegate2": (_) =>
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                  },
                ),
              ),
            );

            await tester.pumpAndSettle();

            final grid = find.byKey(const ValueKey("grid"));

            expect(grid, findsOneWidget);

            await driver.asInternalDriver.updateAttributes("grid", {
              "sliverGridDelegateKey": "delegate2",
              "constructor": "common",
            });

            await tester.pumpAndSettle();

            expect(find.byKey(const ValueKey("grid")), findsOneWidget);
          },
        );
      });

      group("SliverGrid.count consructor", () {
        testWidgets(
          "must renders correctly",
          (WidgetTester tester) async {
            final driver = XDriver.static(
              {
                "type": "CustomScrollView",
                "controlled": false,
                "id": "scroll_view",
                "children": [
                  {
                    "type": "SliverGrid",
                    "controlled": false,
                    "id": "grid",
                    "children": arr,
                    "attributes": {
                      "constructor": "count",
                      "crossAxisCount": 3,
                    },
                  },
                ],
              },
            );

            await pumpDriver(
              tester, driver.asInternalDriver,
            );

            final grid = find.byKey(const ValueKey("grid"));

            expect(grid, findsOneWidget);
          },
        );

        testWidgets(
          "must update attributes correctly",
          (WidgetTester tester) async {
            final driver = XDriver.static(
              {
                "type": "CustomScrollView",
                "controlled": false,
                "id": "scroll_view",
                "children": [
                  {
                    "type": "SliverGrid",
                    "controlled": true,
                    "id": "grid",
                    "children": arr,
                    "attributes": {
                      "constructor": "count",
                      "crossAxisCount": 3,
                    },
                  },
                ],
              },
            );

            await pumpDriver(
              tester, driver.asInternalDriver,
            );

            await driver.asInternalDriver.updateAttributes("grid", {
              "crossAxisCount": 2,
              "constructor": "count",
            });

            await tester.pumpAndSettle();

            final grid = find.byKey(const ValueKey("grid"));

            expect(grid, findsOneWidget);
          },
        );

        testWidgets(
          "must throw assertion error",
          (tester) async {
            var driver = XDriver.static(
              {
                "type": "SliverGrid",
                "controlled": true,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "constructor": "count",
                  "crossAxisCount": -1,
                },
              },
            );

            await pumpDriver(
              tester, driver.asInternalDriver,
              const ValueKey("firts_case"),
            );

            expect(tester.takeException(), isAssertionError);

            driver = XDriver.static(
              {
                "type": "SliverGrid",
                "controlled": true,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "constructor": "count",
                },
              },
            );

            await pumpDriver(
              tester, driver.asInternalDriver,
              const ValueKey("second_case"),
            );

            expect(tester.takeException(), isAssertionError);
          },
        );
      });

      group(
        "SliverGrid.extent constructor",
        () {
          testWidgets(
            "must renders correctly",
            (tester) async {
              final driver = XDriver.static(
                {
                  "type": "CustomScrollView",
                  "controlled": false,
                  "id": "scroll_view",
                  "children": [
                    {
                      "type": "SliverGrid",
                      "controlled": false,
                      "id": "grid",
                      "children": arr,
                      "attributes": {
                        "constructor": "extent",
                        "maxCrossAxisExtent": 20.0,
                      },
                    },
                  ],
                },
              );

              await pumpDriver(
                tester, driver.asInternalDriver,
              );

              final grid = find.byKey(const ValueKey("grid"));

              expect(grid, findsOneWidget);
            },
          );

          testWidgets(
            "must update attributes correctly",
            (WidgetTester tester) async {
              final driver = XDriver.static(
                {
                  "type": "CustomScrollView",
                  "controlled": false,
                  "id": "scroll_view",
                  "children": [
                    {
                      "type": "SliverGrid",
                      "controlled": true,
                      "id": "grid",
                      "children": arr,
                      "attributes": {
                        "constructor": "extent",
                        "maxCrossAxisExtent": 20.0,
                      },
                    },
                  ],
                },
              );

              await pumpDriver(
                tester, driver.asInternalDriver,
              );

              await driver.asInternalDriver.updateAttributes("grid", {
                "maxCrossAxisExtent": 30.0,
                "constructor": "extent",
              });

              await tester.pumpAndSettle();

              final grid = find.byKey(const ValueKey("grid"));

              expect(grid, findsOneWidget);
            },
          );

          testWidgets(
            "must throw assertion error",
            (tester) async {
              final driver = XDriver.static(
                {
                  "type": "SliverGrid",
                  "controlled": true,
                  "id": "grid",
                  "children": arr,
                  "attributes": {
                    "constructor": "count",
                  },
                },
              );

              await pumpDriver(
                tester, driver.asInternalDriver,
              );

              expect(tester.takeException(), isAssertionError);
            },
          );
        },
      );

      group(
        "SliverGrid.builder constructor",
        () {
          setUpAll(() async {
            await DuitRegistry.initialize();

            await DuitRegistry.registerComponents([
              {
                "tag": "c",
                "layoutRoot": {
                  "type": "Container",
                  "tag": "c",
                  "id": "ckk",
                  "controlled": false,
                  "attributes": {
                    "color": "#DCDCDC",
                    "width": 25,
                    "height": 1000,
                  },
                },
              }
            ]);
          });

          testWidgets(
            "must render correctly",
            (tester) async {
              var startIndex = 0;
              final driver = XDriver.static(
                {
                  "type": "CustomScrollView",
                  "controlled": false,
                  "id": "scroll_view",
                  "children": [
                    {
                      "controlled": true,
                      "id": "grid",
                      "type": "SliverGrid",
                      "action": {
                        "executionType": 0,
                        "event": "/data",
                        "dependsOn": [],
                      },
                      "attributes": {
                        "constructor": "builder",
                        "sliverGridDelegateKey": "delegate1",
                        "childObjects": List<Map<String, dynamic>>.generate(
                          10,
                          (i) {
                            return {
                              "controlled": true,
                              "action": null,
                              "id": (startIndex++).toString(),
                              "type": "Component",
                              "data": {
                                "come": "value",
                              },
                              "tag": "c",
                            };
                          },
                        ),
                      },
                    },
                  ],
                },
              );

              await pumpDriver(
                tester, driver.asInternalDriver,
                const ValueKey("builder_case"),
                {
                  "delegate1": (_) =>
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                },
              );

              final grid = find.byKey(const ValueKey("grid"));

              expect(grid, findsOneWidget);

              final scroll = find.byType(Scrollable);
              var itemLast = find.byKey(const ValueKey("3"));

              await tester.scrollUntilVisible(
                itemLast,
                1000,
                scrollable: scroll,
              );

              expect(itemLast, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
