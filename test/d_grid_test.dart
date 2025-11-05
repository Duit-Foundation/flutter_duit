import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitGridView tests",
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

      group("GridView.common consructor", () {
        testWidgets(
          "must renders correctly",
          (WidgetTester tester) async {
            final driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": false,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "sliverGridDelegateKey": "delegate1",
                  "constructor": "common",
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: DuitViewHost(
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
          "must throws error if sliverGridDelegateKey is not found",
          (WidgetTester tester) async {
            final driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": false,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "sliverGridDelegateKey": "invalid_delegate_key",
                  "constructor": "common",
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: DuitViewHost(
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

            expect(tester.takeException(), isArgumentError);
          },
        );

        testWidgets(
          "must update attributes correctly",
          (WidgetTester tester) async {
            final driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": true,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "sliverGridDelegateKey": "delegate1",
                  "constructor": "common",
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: DuitViewHost(
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
          },
        );
      });

      group("GridView.count consructor", () {
        testWidgets(
          "must renders correctly",
          (WidgetTester tester) async {
            final driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": false,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "constructor": "count",
                  "crossAxisCount": 3,
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await pumpDriver(
              tester,
              driver,
            );

            final grid = find.byKey(const ValueKey("grid"));

            expect(grid, findsOneWidget);
          },
        );

        testWidgets(
          "must update attributes correctly",
          (WidgetTester tester) async {
            final driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": true,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "constructor": "count",
                  "crossAxisCount": 3,
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await pumpDriver(
              tester,
              driver,
            );

            await driver.updateTestAttributes("grid", {
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
            var driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": true,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "constructor": "count",
                  "crossAxisCount": -1,
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await pumpDriver(
              tester,
              driver,
              const ValueKey("firts_case"),
            );

            expect(tester.takeException(), isAssertionError);
          },
        );
      });

      group(
        "GridView.extent constructor",
        () {
          testWidgets(
            "must renders correctly",
            (tester) async {
              final driver = DuitDriver.static(
                {
                  "type": "GridView",
                  "controlled": false,
                  "id": "grid",
                  "children": arr,
                  "attributes": {
                    "constructor": "extent",
                    "maxCrossAxisExtent": 20.0,
                  },
                },
                transportOptions: EmptyTransportOptions(),
              );

              await pumpDriver(
                tester,
                driver,
              );

              final grid = find.byKey(const ValueKey("grid"));

              expect(grid, findsOneWidget);
            },
          );

          testWidgets(
            "must update attributes correctly",
            (WidgetTester tester) async {
              final driver = DuitDriver.static(
                {
                  "type": "GridView",
                  "controlled": true,
                  "id": "grid",
                  "children": arr,
                  "attributes": {
                    "constructor": "extent",
                    "maxCrossAxisExtent": 20.0,
                  },
                },
                transportOptions: EmptyTransportOptions(),
              );

              await pumpDriver(
                tester,
                driver,
              );

              await driver.updateTestAttributes("grid", {
                "maxCrossAxisExtent": 30.0,
                "constructor": "extent",
              });

              await tester.pumpAndSettle();

              final grid = find.byKey(const ValueKey("grid"));

              expect(grid, findsOneWidget);
            },
          );
        },
      );

      group(
        "GridView.builder constructor",
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
              final driver = DuitDriver.static(
                {
                  "controlled": true,
                  "id": "grid",
                  "type": "GridView",
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
                          "tag": "c"
                        };
                      },
                    ),
                  },
                },
                transportOptions: EmptyTransportOptions(),
              )..applyMockTransport(
                  {
                    "type": "update",
                    "updates": {
                      "grid": {
                        "constructor": "builder",
                        "sliverGridDelegateKey": "delegate1",
                        "childObjects": List<Map<String, dynamic>>.generate(
                          10,
                          (i) => {
                            "controlled": true,
                            "action": null,
                            "id": (startIndex++).toString(),
                            "type": "Component",
                            "data": {
                              "come": "value",
                            },
                            "tag": "c"
                          },
                        ),
                      },
                    },
                  },
                );

              await pumpDriver(
                tester,
                driver,
                null,
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
              var itemLast = find.byKey(const ValueKey("10"));

              await tester.scrollUntilVisible(
                itemLast,
                1000,
                scrollable: scroll,
              );

              expect(itemLast, findsOneWidget);

              itemLast = find.byKey(const ValueKey("19"));

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
