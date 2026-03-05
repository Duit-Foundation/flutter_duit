import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitSemantics tests",
    () {
      testWidgets(
        "must renders correctly with all parameters",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Semantics",
              "id": "sem1",
              "controlled": false,
              "attributes": {
                "label": "Test Label",
                "hint": "Test Hint",
                "value": "Test Value",
                "tooltip": "Test Tooltip",
                "enabled": true,
                "checked": true,
                "selected": false,
                "button": true,
                "link": false,
                "header": false,
                "textField": false,
                "image": false,
                "liveRegion": false,
                "container": true,
                "explicitChildNodes": false,
                "excludeSemantics": false,
                "blockUserActions": false,
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": {
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final semFinder = find.byKey(const ValueKey("sem1"));
          final childFinder = find.byKey(const ValueKey("child"));

          expect(semFinder, findsOneWidget);
          expect(childFinder, findsOneWidget);

          final handle = tester.ensureSemantics();
          final semanticsNode = tester.getSemantics(semFinder);

          expect(semanticsNode.label, "Test Label");
          expect(semanticsNode.hint, "Test Hint");
          expect(semanticsNode.value, "Test Value");
          expect(semanticsNode.tooltip, "Test Tooltip");

          handle.dispose();
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Semantics",
              "id": "sem3",
              "controlled": true,
              "attributes": {
                "label": "Initial Label",
                "hint": "Initial Hint",
                "enabled": true,
                "checked": false,
                "button": false,
                "container": false,
                "explicitChildNodes": false,
                "excludeSemantics": false,
                "blockUserActions": false,
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": {
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("sem3")), findsOneWidget);

          var handle = tester.ensureSemantics();
          var semanticsNode = tester.getSemantics(
            find.byKey(const ValueKey("sem3")),
          );

          expect(semanticsNode.label, "Initial Label");
          expect(semanticsNode.hint, "Initial Hint");

          handle.dispose();

          await driver.asInternalDriver.updateAttributes(
            "sem3",
            {
              "label": "Updated Label",
              "hint": "Updated Hint",
              "enabled": false,
              "checked": true,
              "button": true,
              "container": true,
              "explicitChildNodes": true,
              "excludeSemantics": true,
              "blockUserActions": true,
            },
          );

          await tester.pumpAndSettle();

          handle = tester.ensureSemantics();
          semanticsNode = tester.getSemantics(
            find.byKey(const ValueKey("sem3")),
          );

          expect(semanticsNode.label, "Updated Label");
          expect(semanticsNode.hint, "Updated Hint");

          handle.dispose();
        },
      );

      testWidgets(
        "must handle boolean flags correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Semantics",
              "id": "sem4",
              "controlled": false,
              "attributes": {
                "label": "Flags Test",
                "selected": true,
                "link": true,
                "header": true,
                "textField": true,
                "image": true,
                "liveRegion": true,
                "container": true,
                "explicitChildNodes": true,
                "excludeSemantics": true,
                "blockUserActions": true,
              },
              "child": {
                "type": "Text",
                "id": "text",
                "controlled": false,
                "attributes": {
                  "data": "Test",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final semFinder = find.byKey(const ValueKey("sem4"));

          expect(semFinder, findsOneWidget);

          final handle = tester.ensureSemantics();
          final semanticsNode = tester.getSemantics(semFinder);

          expect(semanticsNode.label, "Flags Test");

          handle.dispose();
        },
      );
    },
  );
}
