import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/index.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  setUp(
    () async {
      await DuitRegistry.initialize();
      await DuitRegistry.registerComponent(
        {
          "tag": "Page",
          "layoutRoot": {
            "type": "Container",
            "id": "c1",
            "controlled": false,
            "attributes": <String, dynamic>{
              "refs": [
                {
                  "objectKey": "color",
                  "attributeKey": "color",
                },
              ],
            },
            "child": {
              "type": "Center",
              "id": "center",
              "controlled": false,
              "child": {
                "type": "Text",
                "id": "txt",
                "controlled": false,
                "attributes": {
                  "style": {
                    "color": Colors.blueAccent,
                  },
                  "refs": [
                    {
                      "objectKey": "text",
                      "attributeKey": "data",
                    },
                  ],
                },
              },
            },
          },
        },
      );
    },
  );
  group(
    "PageViewConstructor tests",
    () {
      test(
        "PageViewConstructor must parse value",
        () {
          expect(
            PageViewConstructor.fromValue("common"),
            PageViewConstructor.common,
          );
          expect(PageViewConstructor.fromValue(0), PageViewConstructor.common);
          expect(
            PageViewConstructor.fromValue("builder"),
            PageViewConstructor.builder,
          );
          expect(PageViewConstructor.fromValue(1), PageViewConstructor.builder);
        },
      );

      test(
        "PageViewConstructor must throw error",
        () {
          expect(
            () => PageViewConstructor.fromValue(true),
            throwsArgumentError,
          );
          expect(
            () => PageViewConstructor.fromValue("dsfdsbvsdf"),
            throwsArgumentError,
          );
          expect(
            () => PageViewConstructor.fromValue(123123),
            throwsArgumentError,
          );
        },
      );
    },
  );

  group("DuitPageView tests", () {
    group(
      "DuitPageView common",
      () {
        testWidgets(
          "must renders correctly",
          (tester) async {
            final driver = XDriver.static(
              {
                "type": "PageView",
                "id": "PageView",
                "controlled": false,
                "attributes": {
                  "constructor": "common",
                  "childObjects": List.generate(4, (index) {
                    return {
                      "type": "Component",
                      "id": "c$index",
                      "tag": "Page",
                      "data": {
                        "color": index % 2 == 0 ? Colors.red : Colors.black87,
                        "text": "Page №$index",
                      },
                    };
                  }),
                },
                "children": [
                  {
                    "type": "Container",
                    "id": "c1",
                    "controlled": false,
                    "attributes": {
                      "color": "#CFCFCF",
                    },
                  },
                  {
                    "type": "Container",
                    "id": "c2",
                    "controlled": false,
                    "attributes": {
                      "color": "#DCDCDC",
                    },
                  },
                  {
                    "type": "Container",
                    "id": "c3",
                    "controlled": false,
                    "attributes": {
                      "color": "#CFCFCF",
                    },
                  },
                ],
              },
            );

            await pumpDriver(tester, driver.asInternalDriver);

            final pager = find.byKey(const ValueKey("PageView"));
            final c1 = find.byKey(const ValueKey("c1"));
            expect(pager, findsOneWidget);
            expect(c1, findsOneWidget);

            final c2 = find.byKey(const ValueKey("c2"));
            await tester.scrollUntilVisible(
              c2,
              500,
            );
            expect(c2, findsOneWidget);

            final c3 = find.byKey(const ValueKey("c3"));
            await tester.scrollUntilVisible(
              c3,
              500,
            );
            expect(c3, findsOneWidget);
          },
        );

        testWidgets(
          "must update attributes correctly",
          (tester) async {
            final driver = XDriver.static(
              {
                "type": "PageView",
                "id": "PageView",
                "controlled": true,
                "attributes": {
                  "constructor": "common",
                },
                "children": [
                  {
                    "type": "Container",
                    "id": "c1",
                    "controlled": false,
                    "attributes": {
                      "color": "#CFCFCF",
                    },
                  },
                  {
                    "type": "Container",
                    "id": "c2",
                    "controlled": false,
                    "attributes": {
                      "color": "#DCDCDC",
                    },
                  },
                  {
                    "type": "Container",
                    "id": "c3",
                    "controlled": false,
                    "attributes": {
                      "color": "#CFCFCF",
                    },
                  },
                ],
              },
            );

            await pumpDriver(tester, driver.asInternalDriver);

            var pager = find.byKey(const ValueKey("PageView"));
            var pageViewWidget = tester.widget<PageView>(pager);
            final c1 = find.byKey(const ValueKey("c1"));
            expect(pager, findsOneWidget);
            expect(c1, findsOneWidget);

            expect(pageViewWidget.pageSnapping, true);

            await driver.asInternalDriver.updateAttributes("PageView", {
              "pageSnapping": false,
            });

            await tester.pumpAndSettle();

            pager = find.byKey(const ValueKey("PageView"));
            pageViewWidget = tester.widget<PageView>(pager);

            expect(pageViewWidget.pageSnapping, false);
          },
        );
      },
    );

    group(
      "DuitPageView builder",
      () {
        testWidgets(
          "must renders and update attributes correctly",
          (tester) async {
            final driver = XDriver.static(
              {
                "type": "PageView",
                "id": "PageView",
                "controlled": true,
                "attributes": {
                  "constructor": "builder",
                  "childObjects": List.generate(10, (index) {
                    return {
                      "type": "Component",
                      "id": "c$index",
                      "tag": "Page",
                      "data": {
                        "color": index % 2 == 0 ? Colors.red : Colors.black87,
                        "text": "Page №$index",
                      },
                    };
                  }),
                },
              },
            );

            await pumpDriver(tester, driver.asInternalDriver);

            var pager = find.byKey(const ValueKey("PageView"));
            var pageViewWidget = tester.widget<PageView>(pager);
            final c1 = find.byKey(const ValueKey("c0"));
            expect(pager, findsOneWidget);
            expect(c1, findsOneWidget);

            expect(pageViewWidget.pageSnapping, true);

            await driver.asInternalDriver.updateAttributes("PageView", {
              "pageSnapping": false,
            });

            await tester.pumpAndSettle();

            pager = find.byKey(const ValueKey("PageView"));
            pageViewWidget = tester.widget<PageView>(pager);

            expect(pageViewWidget.pageSnapping, false);
          },
        );
      },
    );

    testWidgets(
      "PageView remote commands must work as expected",
      (tester) async {
        final driver = XDriver.static(
          {
            "type": "PageView",
            "id": "PageView",
            "controlled": true,
            "attributes": {
              "constructor": "builder",
              "childObjects": List.generate(10, (index) {
                return {
                  "type": "Component",
                  "id": "i$index",
                  "tag": "Page",
                  "data": {
                    "color": index % 2 == 0 ? Colors.red : Colors.black87,
                    "text": "Page №$index",
                  },
                };
              }),
            },
          },
        );

        await pumpDriver(tester, driver.asInternalDriver);

        final pager = find.byKey(const ValueKey("PageView"));
        var c0 = find.byKey(const ValueKey("i0"));
        expect(pager, findsOneWidget);
        expect(c0, findsOneWidget);

        // Next page
        await driver.asInternalDriver.execute(
          ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "PageView",
                "commandData": {
                  "type": "pageView",
                  "action": "nextPage",
                  "duration": 10,
                },
              },
            },
          ),
        );

        await tester.pumpAndSettle();

        c0 = find.byKey(const ValueKey("i0"));
        var c1 = find.byKey(const ValueKey("i1"));
        expect(c0, findsNothing);
        expect(c1, findsOneWidget);

        // Previous page
        await driver.asInternalDriver.execute(
          ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "PageView",
                "commandData": {
                  "type": "pageView",
                  "action": "previousPage",
                  "duration": 10,
                },
              },
            },
          ),
        );

        await tester.pumpAndSettle();

        c0 = find.byKey(const ValueKey("i0"));
        c1 = find.byKey(const ValueKey("i1"));
        expect(c0, findsOneWidget);
        expect(c1, findsNothing);

        // Jump to page
        await driver.asInternalDriver.execute(
          ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "PageView",
                "commandData": {
                  "type": "pageView",
                  "action": "jumpToPage",
                  "page": 2,
                },
              },
            },
          ),
        );

        await tester.pumpAndSettle();

        var c3 = find.byKey(const ValueKey("i2"));
        c0 = find.byKey(const ValueKey("i0"));
        expect(c3, findsOneWidget);
        expect(c0, findsNothing);

        // Jump to offset
        await driver.asInternalDriver.execute(
          ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "PageView",
                "commandData": {
                  "type": "pageView",
                  "action": "jumpTo",
                  "value": 0,
                },
              },
            },
          ),
        );

        await tester.pumpAndSettle();

        c3 = find.byKey(const ValueKey("i2"));
        c0 = find.byKey(const ValueKey("i0"));
        expect(c3, findsNothing);
        expect(c0, findsOneWidget);

        // Animate to offset
        await driver.asInternalDriver.execute(
          ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "PageView",
                "commandData": {
                  "type": "pageView",
                  "action": "animateTo",
                  "duration": 10,
                  "offset": 500,
                },
              },
            },
          ),
        );

        await tester.pumpAndSettle();

        var c2 = find.byKey(const ValueKey("i1"));
        c0 = find.byKey(const ValueKey("i0"));
        expect(c2, findsOneWidget);
        expect(c0, findsNothing);

        // Animate to offset
        await driver.asInternalDriver.execute(
          ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "PageView",
                "commandData": {
                  "type": "pageView",
                  "action": "animateToPage",
                  "duration": 10,
                  "page": 0,
                },
              },
            },
          ),
        );

        await tester.pumpAndSettle();

        c2 = find.byKey(const ValueKey("i1"));
        c0 = find.byKey(const ValueKey("i0"));
        expect(c2, findsNothing);
        expect(c0, findsOneWidget);
      },
    );
  });
}
