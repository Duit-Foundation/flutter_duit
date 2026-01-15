import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_duit/flutter_duit.dart";

import "utils.dart";

void main() {
  group(
    "DuitScaffold tests",
    () {
      testWidgets(
        "must build with default attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "attributes": {
                "backgroundColor": "#00FF00",
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final scaffold = find.byType(Scaffold);
          expect(scaffold, findsOneWidget);

          final scaffoldWidget = tester.widget<Scaffold>(scaffold);

          expect(scaffoldWidget.backgroundColor, const Color(0xFF00FF00));
          expect(scaffoldWidget.extendBody, false);
          expect(scaffoldWidget.extendBodyBehindAppBar, false);
          expect(scaffoldWidget.primary, true);
        },
      );

      testWidgets(
        "must build with body widget",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "Text",
                  "id": "text",
                  "controlled": false,
                  "attributes": {
                    "data": "Hello, world!",
                  },
                },
              ],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final text = find.byKey(const Key("text"));
          expect(text, findsOneWidget);

          final textWidget = tester.widget<Text>(text);
          expect(textWidget.data, "Hello, world!");
        },
      );

      testWidgets(
        "must build with AppBar widget",
        (tester) async {
          await pumpDriver(
            tester,
            XDriver.static(
              {
                "type": "Scaffold",
                "id": "scaffold",
                "children": [
                  null,
                  {
                    "type": "AppBar",
                    "id": "appBar",
                    "controlled": true,
                    "attributes": <String, dynamic>{},
                  },
                ],
              },
            ).asInternalDriver,
          );

          final appBar = find.byKey(const Key("appBar"));
          expect(appBar, findsOneWidget);
        },
      );

      testWidgets(
        "must build with bottomsheet widget",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "children": [
                null,
                null,
                null,
                {
                  "type": "Container",
                  "id": "bottom",
                  "controlled": false,
                  "attributes": {"height": 100, "color": "#00FF00"},
                },
              ],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final container = find.byKey(const Key("bottom"));
          expect(container, findsOneWidget);

          final containerWidget = tester.widget<Container>(container);
          expect(containerWidget.color, const Color(0xFF00FF00));
        },
      );

      testWidgets(
        "must build with FAB widget",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "children": [
                null,
                null,
                {
                  "type": "Container",
                  "id": "bottom",
                  "controlled": false,
                  "attributes": {
                    "height": 25,
                    "width": 25,
                    "color": "#00FF00",
                  },
                },
                null,
              ],
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final container = find.byKey(const Key("bottom"));
          expect(container, findsOneWidget);

          final containerWidget = tester.widget<Container>(container);
          expect(containerWidget.color, const Color(0xFF00FF00));
        },
      );
    },
  );
}
