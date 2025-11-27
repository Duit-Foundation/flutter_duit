import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "SliverFillRemaining tests",
    () {
      testWidgets(
        "DuitSliverFillRemaining must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverFillRemaining",
                  "id": "sliver1",
                  "controlled": false,
                  "attributes": {
                    "hasScrollBody": false,
                  },
                  "child": {
                    "type": "Text",
                    "id": "text",
                    "controlled": false,
                    "attributes": {
                      "data": "Some text",
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
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("sliver1")), findsOneWidget);
          expect(find.byKey(const ValueKey("text")), findsOneWidget);
        },
      );

      testWidgets(
        "DuitControlledSliverFillRemaining must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": true,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverFillRemaining",
                  "id": "sliver1",
                  "controlled": true,
                  "attributes": {
                    "hasScrollBody": false,
                  },
                  "child": {
                    "type": "Text",
                    "id": "text",
                    "controlled": false,
                    "attributes": {
                      "data": "Some text",
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
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("sliver1")), findsOneWidget);
          expect(find.byKey(const ValueKey("text")), findsOneWidget);

          await driver.updateAttributes("sliver1", {
            "hasScrollBody": true,
          });

          await tester.pumpAndSettle();
          final sliver = tester.widget<SliverFillRemaining>(
            find.byKey(const ValueKey("sliver1")),
          );
          expect(find.byKey(const ValueKey("sliver1")), findsOneWidget);
          expect(find.byKey(const ValueKey("text")), findsOneWidget);
          expect(sliver.hasScrollBody, true);
        },
      );
    },
  );
}
