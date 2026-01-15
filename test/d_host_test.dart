import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_duit/flutter_duit.dart";

void main() {
  setUpAll(
    () async {
      await DuitRegistry.initialize();
    },
  );
  group(
    "DuitHost widget tests",
    () {
      group("Host error builder tests", () {
        testWidgets("Host must show error text", (WidgetTester tester) async {
          final driver = XDriver.static(
            {
              "type": "invalid_type",
              "id": "1",
            },
          );

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost.withDriver(
                driver: driver,
                errorWidgetBuilder: (context, error) {
                  return Text(error.toString());
                },
              ),
            ),
          );

          await tester.pumpAndSettle();

          final errorText = find.text(
            "Instance of 'UIDriverErrorEvent'",
          );

          expect(errorText, findsOneWidget);
        });
        testWidgets("Host must rethrow error", (WidgetTester tester) async {
          final driver = XDriver.static(
            {
              "type": "invalid_type",
              "id": "1",
            },
          );

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost.withDriver(
                driver: driver,
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(tester.takeException(), isInstanceOf<UIDriverErrorEvent>());
        });
      });

      testWidgets("Host must show child instead of placeholder",
          (WidgetTester tester) async {
        final driver = XDriver.static(
          {
            "type": "Container",
            "id": "1",
            "controlled": false,
            "attributes": {
              "width": 250,
              "height": 250,
            },
          },
        );

        const childKey = ValueKey("child");

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: driver,
              showChildInsteadOfPlaceholder: true,
              placeholder: const CircularProgressIndicator(),
              child: Container(
                key: childKey,
              ),
            ),
          ),
        );

        final child = find.byKey(childKey);

        expect(child, findsOneWidget);
      });

      testWidgets("Host must show placeholder correctly",
          (WidgetTester tester) async {
        final driver = XDriver.static(
          {
            "type": "Container",
            "id": "1",
            "controlled": false,
            "attributes": {
              "width": 250,
              "height": 250,
            },
          },
        );

        const childKey = ValueKey("child");

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: driver,
              showChildInsteadOfPlaceholder: false,
              placeholder: const CircularProgressIndicator(),
              child: Container(
                key: childKey,
              ),
            ),
          ),
        );

        final child = find.byType(CircularProgressIndicator);

        expect(child, findsOneWidget);
      });

      group(
        "Shared driver tests",
        () {
          testWidgets("shared driver must create two widgets",
              (WidgetTester tester) async {
            final driver = XDriver.static(
              {
                "widgets": {
                  "first": {
                    "type": "Container",
                    "id": "Container1",
                    "controlled": false,
                    "attributes": {
                      "width": 250,
                      "height": 250,
                      "color": "#DCDCDC",
                    },
                    "child": {
                      "type": "Text",
                      "id": "2",
                      "controlled": false,
                      "attributes": {"data": "One of us"},
                    },
                  },
                  "second": {
                    "type": "Container",
                    "id": "Container2",
                    "controlled": false,
                    "attributes": {
                      "width": 250,
                      "height": 250,
                      "color": "#933C3C",
                    },
                  },
                },
              },
            );

            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    DuitViewHost.withDriver(
                      driver: driver,
                      viewTag: "first",
                    ),
                    const Text("Flutter view between Duit views"),
                    DuitViewHost.withDriver(
                      driver: driver,
                      viewTag: "second",
                    ),
                  ],
                ),
              ),
            );

            await tester.pumpAndSettle();

            const c1 = ValueKey("Container1");
            const c2 = ValueKey("Container2");

            final ch1 = find.byKey(c1);
            final ch2 = find.byKey(c2);

            expect(ch1, findsOneWidget);
            expect(ch2, findsOneWidget);
          }, skip: !enableSharedDrivers);

          testWidgets("Host must show first view when viewTag not specified",
              (t) async {
            final driver = XDriver.static(
              {
                "widgets": {
                  "first": {
                    "type": "Container",
                    "id": "Container1",
                    "controlled": false,
                    "attributes": {
                      "width": 250,
                      "height": 250,
                      "color": "#DCDCDC",
                    },
                    "child": {
                      "type": "Text",
                      "id": "2",
                      "controlled": false,
                      "attributes": {"data": "One of us"},
                    },
                  },
                  "second": {
                    "type": "Container",
                    "id": "Container2",
                    "controlled": false,
                    "attributes": {
                      "width": 250,
                      "height": 250,
                      "color": "#933C3C",
                    },
                  },
                },
              },
            );

            await t.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    DuitViewHost.withDriver(
                      driver: driver,
                    ),
                    DuitViewHost.withDriver(
                      driver: driver,
                    ),
                  ],
                ),
              ),
            );

            await t.pumpAndSettle();

            const c1 = ValueKey("Container1");
            const c2 = ValueKey("Container2");

            final ch1 = find.byKey(c1);
            final ch2 = find.byKey(c2);

            expect(ch1, findsExactly(2));
            expect(ch2, findsNothing);
          }, skip: !enableSharedDrivers);

          testWidgets(
            "Host must throw error when non shared driver receive multiple views",
            (t) async {
              final driver = XDriver.static(
                {
                  "widgets": {
                    "first": {
                      "type": "Container",
                      "id": "Container1",
                      "controlled": false,
                      "attributes": {
                        "width": 250,
                        "height": 250,
                        "color": "#DCDCDC",
                      },
                      "child": {
                        "type": "Text",
                        "id": "2",
                        "controlled": false,
                        "attributes": {"data": "One of us"},
                      },
                    },
                    "second": {
                      "type": "Container",
                      "id": "Container2",
                      "controlled": false,
                      "attributes": {
                        "width": 250,
                        "height": 250,
                        "color": "#933C3C",
                      },
                    },
                  },
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

              expect(t.takeException(), isInstanceOf<UIDriverErrorEvent>());
            },
          );

          testWidgets("Shared driver must update single view correctly",
              (t) async {
            final driver = XDriver.static(
              {
                "widgets": {
                  "first": {
                    "type": "Container",
                    "id": "Container1",
                    "controlled": false,
                    "attributes": {
                      "width": 250,
                      "height": 250,
                      "color": "#DCDCDC",
                    },
                    "child": {
                      "type": "Text",
                      "id": "text1",
                      "controlled": true,
                      "attributes": {"data": "One of us"},
                    },
                  },
                  "second": {
                    "type": "Container",
                    "id": "Container2",
                    "controlled": false,
                    "attributes": {
                      "width": 250,
                      "height": 250,
                      "color": "#933C3C",
                    },
                  },
                },
              },
            );

            await t.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    DuitViewHost.withDriver(
                      driver: driver,
                      viewTag: "first",
                    ),
                    DuitViewHost.withDriver(
                      driver: driver,
                      viewTag: "second",
                    ),
                  ],
                ),
              ),
            );

            await t.pumpAndSettle();

            var text = find.text("One of us");

            expect(text, findsOneWidget);

            await driver.asInternalDriver.updateAttributes(
              "text1",
              {
                "data": "Two of us",
              },
            );

            await t.pumpAndSettle();

            text = find.text("Two of us");

            expect(text, findsOneWidget);
          }, skip: !enableSharedDrivers);
        },
      );
    },
  );
}
