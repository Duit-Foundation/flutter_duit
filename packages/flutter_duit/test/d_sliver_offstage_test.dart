import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_duit/flutter_duit.dart";

import "utils.dart";

void main() {
  group(
    "DuitSliverOffstage tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverOffstage",
                  "id": "sliver1",
                  "controlled": false,
                  "attributes": {
                    "offstage": false,
                    "needsBoxAdapter": true,
                  },
                  "child": {
                    "type": "Text",
                    "id": "text",
                    "controlled": false,
                    "attributes": {
                      "data": "Controlled text",
                      "style": {
                        "color": "#DCDCDC",
                        "fontSize": 64.0,
                        "fontWeight": 700,
                      },
                    },
                  },
                },
              ],
            },
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(find.byKey(const ValueKey("sliver1")), findsOneWidget);
          expect(find.byKey(const ValueKey("text")), findsOneWidget);
          expect(find.text("Controlled text"), findsOneWidget);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverOffstage",
                  "id": "sliver1",
                  "controlled": true,
                  "attributes": {
                    "offstage": false,
                    "needsBoxAdapter": true,
                  },
                  "child": {
                    "type": "Text",
                    "id": "text",
                    "controlled": false,
                    "attributes": {
                      "data": "Controlled text",
                      "style": {
                        "color": "#DCDCDC",
                        "fontSize": 64.0,
                        "fontWeight": 700,
                      },
                    },
                  },
                },
              ],
            },
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(find.byKey(const ValueKey("sliver1")), findsOneWidget);
          expect(find.byKey(const ValueKey("text")), findsOneWidget);
          expect(find.text("Controlled text"), findsOneWidget);

          driver.asInternalDriver.updateAttributes(
            "sliver1",
            {
              "offstage": true,
            },
          );

          await tester.pumpAndSettle();

          expect(find.byKey(const ValueKey("sliver1")), findsNothing);
          expect(find.byKey(const ValueKey("text")), findsNothing);
          expect(find.text("Controlled text"), findsNothing);
        },
      );
    },
  );
}
