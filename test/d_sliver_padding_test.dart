import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "SliverPadding tests",
    () {
      testWidgets(
        "DuitSliverPadding must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverPadding",
                  "id": "sliver1",
                  "controlled": false,
                  "attributes": {
                    "padding": 10.0,
                    "needsBoxAdapter": true,
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
        "DuitControlledSliverPadding must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverPadding",
                  "id": "sliver1",
                  "controlled": true,
                  "attributes": {
                    "padding": 10.0,
                    "needsBoxAdapter": true,
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
            "padding": [
              12,
              24,
            ],
          });

          await tester.pumpAndSettle();

          final sliver = tester
              .widget<SliverPadding>(find.byKey(const ValueKey("sliver1")));
          expect(
            sliver.padding,
            const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          );
        },
      );
    },
  );
}
