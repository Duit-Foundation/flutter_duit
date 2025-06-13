import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "SliverVisibility tests",
    () {
      testWidgets(
        "DuitSliverVisibility must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "contolled": false,
              "attributes": {},
              "children": [
                {
                  "type": "SliverVisibility",
                  "id": "sliver1",
                  "controlled": false,
                  "attributes": {
                    "visible": false,
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
                {
                  "type": "SliverVisibility",
                  "id": "sliver2",
                  "controlled": false,
                  "attributes": {
                    "visible": false,
                    "needsBoxAdapter": false,
                  },
                  "child": {
                    "type": "SliverToBoxAdapter",
                    "id": "adapter1",
                    "controlled": false,
                    "child": {
                      "type": "Text",
                      "id": "text2",
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
                },
              ],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("sliver1")), findsNothing);
          expect(find.byKey(const ValueKey("text")), findsNothing);
        },
      );

      testWidgets(
        "DuitControlledSliverVisibility must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "contolled": false,
              "attributes": {},
              "children": [
                {
                  "type": "SliverVisibility",
                  "id": "sliver1",
                  "controlled": true,
                  "attributes": {
                    "visible": false,
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
                {
                  "type": "SliverVisibility",
                  "id": "sliver2",
                  "controlled": true,
                  "attributes": {
                    "visible": false,
                    "needsBoxAdapter": false,
                  },
                  "child": {
                    "type": "SliverToBoxAdapter",
                    "id": "adapter",
                    "controlled": false,
                    "child": {
                      "type": "Text",
                      "id": "text2",
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
                },
              ],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("sliver1")), findsNothing);
          expect(find.byKey(const ValueKey("text")), findsNothing);

          await driver.updateTestAttributes("sliver1", {
            "visible": true,
          });

          await tester.pumpAndSettle();

          final SliverVisibility sliver =
              tester.widget(find.byKey(const ValueKey("sliver1")));
          expect(
            sliver.visible,
            true,
          );
          expect(find.byKey(const ValueKey("sliver1")), findsOneWidget);
          expect(find.byKey(const ValueKey("text")), findsOneWidget);
        },
      );
    },
  );
}
