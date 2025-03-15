import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitGridView tests",
    () {
      final arr = [];

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

            expect(tester.takeException(), isInstanceOf<UnimplementedError>());
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

            expect(tester.takeException(), isInstanceOf<UIDriverErrorEvent>());

            driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": true,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "constructor": "count",
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await pumpDriver(
              tester,
              driver,
              const ValueKey("second_case"),
            );

            expect(tester.takeException(), isInstanceOf<UIDriverErrorEvent>());
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

        testWidgets(
          "must throw assertion error",
          (tester) async {
            final driver = DuitDriver.static(
              {
                "type": "GridView",
                "controlled": true,
                "id": "grid",
                "children": arr,
                "attributes": {
                  "constructor": "count",
                },
              },
              transportOptions: EmptyTransportOptions(),
            );

            await pumpDriver(
              tester,
              driver,
            );

            expect(tester.takeException(), isInstanceOf<UIDriverErrorEvent>());
          },
        );
        },
      );
    },
  );
}
