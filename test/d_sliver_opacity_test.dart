import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "SliverOpacity tests",
    () {
      testWidgets(
        "DuitSliverOpacity must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverOpacity",
                  "id": "sliver1",
                  "controlled": false,
                  "attributes": {
                    "opacity": 0.5,
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
                      }
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
        "DuitControlledSliverOpacity must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": [
                {
                  "type": "SliverOpacity",
                  "id": "sliver1",
                  "controlled": true,
                  "attributes": {
                    "opacity": 0.5,
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
                      }
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
            "opacity": 1.0,
          });

          await tester.pumpAndSettle();

          final SliverOpacity sliver =
              tester.widget(find.byKey(const ValueKey("sliver1")));
          expect(
            sliver.opacity,
            1.0,
          );
        },
      );
    },
  );
}
