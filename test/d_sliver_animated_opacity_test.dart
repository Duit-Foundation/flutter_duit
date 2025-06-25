import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "SliveAnimatedOpacity tests",
    () {
      testWidgets(
        "DuitSliverAnimatedOpacity must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": {},
              "children": [
                {
                  "type": "SliverAnimatedOpacity",
                  "id": "sliver1",
                  "controlled": false,
                  "attributes": {
                    "opacity": 0.5,
                    "needsBoxAdapter": false,
                    "duration": 100,
                  },
                  "child": {
                    "type": "SliverPadding",
                    "id": "sliver2",
                    "controlled": false,
                    "attributes": {
                      "padding": 12.0,
                      "needsBoxAdapter": true,
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
          expect(find.byKey(const ValueKey("sliver2")), findsOneWidget);
        },
      );

      testWidgets(
        "DuitSliverAnimatedOpacity must call onEnd",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "controlled": false,
              "attributes": {},
              "children": [
                {
                  "type": "SliverAnimatedOpacity",
                  "id": "sliver1",
                  "controlled": true,
                  "attributes": {
                    "opacity": 0.5,
                    "needsBoxAdapter": true,
                    "onEnd": {
                      "executionType": 1, //local
                      "event": "local_exec",
                      "payload": {
                        "type": "update",
                        "updates": {
                          "c_text": {
                            "data": "END",
                          },
                        }
                      },
                    },
                  },
                  "child": {
                    "type": "Text",
                    "id": "c_text",
                    "controlled": true,
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

          await driver.updateTestAttributes("sliver1", {
            "opacity": 1.0,
          });

          await tester.pumpAndSettle();

          final SliverAnimatedOpacity sliver =
              tester.widget(find.byKey(const ValueKey("sliver1")));
          expect(
            sliver.opacity,
            1.0,
          );
          expect(find.text("END"), findsOneWidget);
        },
      );
    },
  );
}
