import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Future<void> _pumpDriver(WidgetTester tester, Map<String, dynamic> widget) =>
    pumpDriver(tester, XDriver.static(widget).asInternalDriver);

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    "type": "Column",
    "id": "column_root",
    "controlled": false,
    "children": [
      {
        "type": "Dismissible",
        "id": "dismissible_test",
        "controlled": isControlled,
        "attributes": {
          "direction": "startToEnd",
        },
        "children": [
          {
            "type": "Container",
            "id": "dismissible_content",
            "controlled": false,
            "attributes": {
              "color": "#DCDCDC",
              "width": 400,
              "height": 80,
            },
          },
        ],
      },
    ],
  };
}

Map<String, dynamic> _createWidgetWithBackground([bool isControlled = false]) {
  return {
    "type": "Column",
    "id": "column_root",
    "controlled": false,
    "children": [
      {
        "type": "Dismissible",
        "id": "dismissible_with_bg",
        "controlled": isControlled,
        "attributes": {
          "direction": "horizontal",
        },
        "children": [
          {
            "type": "Container",
            "id": "dismissible_content",
            "controlled": false,
            "attributes": {
              "color": "#DCDCDC",
              "width": 400,
              "height": 80,
            },
          },
          {
            "type": "Container",
            "id": "background",
            "controlled": false,
            "attributes": {
              "color": "#FF0000",
              "width": 400,
              "height": 80,
            },
          },
        ],
      },
    ],
  };
}

void main() {
  group("DuitDismissible widget tests", () {
    testWidgets("check widget", (tester) async {
      await _pumpDriver(tester, _createWidget());

      final widget = find.byKey(const ValueKey("dismissible_test"));
      expect(widget, findsOneWidget);
      expect(find.byKey(const ValueKey("dismissible_content")), findsOneWidget);
    });

    testWidgets("must apply direction attribute", (tester) async {
      await _pumpDriver(tester, {
        "type": "Column",
        "id": "column",
        "controlled": false,
        "children": [
          {
            "type": "Dismissible",
            "id": "dismissible_dir",
            "controlled": false,
            "attributes": {"direction": "endToStart"},
            "children": [
              {
                "type": "Container",
                "id": "content",
                "controlled": false,
                "attributes": {"width": 100, "height": 50},
              },
            ],
          },
        ],
      });

      final dismissible = tester.widget<Dismissible>(
        find.byKey(const ValueKey("dismissible_dir")),
      );
      expect(dismissible.direction, DismissDirection.endToStart);
    });

    testWidgets("must render with background and secondaryBackground",
        (tester) async {
      await _pumpDriver(tester, _createWidgetWithBackground());

      expect(find.byKey(const ValueKey("dismissible_with_bg")), findsOneWidget);
      expect(find.byKey(const ValueKey("dismissible_content")), findsOneWidget);
      final dismissible = tester.widget<Dismissible>(
        find.byKey(const ValueKey("dismissible_with_bg")),
      );
      expect(dismissible.background, isNotNull);
    });

    testWidgets("must use default direction startToEnd when not specified",
        (tester) async {
      await _pumpDriver(tester, {
        "type": "Column",
        "id": "column",
        "controlled": false,
        "children": [
          {
            "type": "Dismissible",
            "id": "dismissible_default",
            "controlled": false,
            "attributes": <String, dynamic>{},
            "children": [
              {
                "type": "Container",
                "id": "content",
                "controlled": false,
                "attributes": {"width": 100, "height": 50},
              },
            ],
          },
        ],
      });

      final dismissible = tester.widget<Dismissible>(
        find.byKey(const ValueKey("dismissible_default")),
      );
      expect(dismissible.direction, DismissDirection.startToEnd);
    });

    testWidgets("must update attributes for controlled widget", (tester) async {
      final driver = XDriver.static(_createWidget(true));
      await pumpDriver(tester, driver.asInternalDriver);

      final widget = find.byKey(const ValueKey("dismissible_test"));
      expect(widget, findsOneWidget);

      final initialDismissible = tester.widget<Dismissible>(widget);
      expect(initialDismissible.direction, DismissDirection.startToEnd);

      await driver.asInternalDriver.updateAttributes(
        "dismissible_test",
        {
          "direction": 0,
        },
      );

      await tester.pumpAndSettle();

      final updatedDismissible = tester.widget<Dismissible>(widget);
      expect(updatedDismissible.direction, DismissDirection.vertical);
    });

    testWidgets(
        "element disappears after dismiss when onDismissed updates layout",
        (tester) async {
      // Dismissible requires parent to remove it via onDismissed.
      // We wrap in Visibility - onDismissed sets visible:false to hide.
      await _pumpDriver(tester, {
        "type": "Column",
        "id": "column_root",
        "controlled": false,
        "children": [
          {
            "type": "Visibility",
            "id": "dismissible_visibility",
            "controlled": true,
            "attributes": {"visible": true},
            "children": [
              {
                "type": "Dismissible",
                "id": "dismissible_test",
                "controlled": true,
                "attributes": {
                  "direction": "startToEnd",
                  "dismissThresholds": {"startToEnd": 0.1},
                  "onDismissed": {
                    "executionType": 1,
                    "event": "local_exec",
                    "payload": {
                      "type": "update",
                      "updates": {
                        "dismissible_visibility": {"visible": false},
                      },
                    },
                  },
                },
                "children": [
                  {
                    "type": "Container",
                    "id": "dismissible_content",
                    "controlled": false,
                    "attributes": {
                      "color": "#DCDCDC",
                      "width": 400,
                      "height": 80,
                    },
                  },
                ],
              },
              null,
            ],
          },
        ],
      });

      expect(find.byKey(const ValueKey("dismissible_test")), findsOneWidget);

      await tester.dragFrom(
        tester.getCenter(find.byKey(const ValueKey("dismissible_test"))),
        const Offset(400, 0),
      );
      await tester.pumpAndSettle();

      // After dismiss, onDismissed hides the Visibility wrapper
      expect(find.byKey(const ValueKey("dismissible_test")), findsNothing);
    });

    testWidgets("throws ArgumentError for invalid direction value",
        (tester) async {
      await _pumpDriver(tester, _createWidget());
      expect(
        () => DuitDataSource({"direction": 1.0}).toEnum<DismissDirection>(
          key: "direction",
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    group("dismissThresholds parsing", () {
      testWidgets("must parse vertical threshold", (tester) async {
        await _pumpDriver(tester, {
          "type": "Column",
          "id": "column",
          "controlled": false,
          "children": [
            {
              "type": "Dismissible",
              "id": "dismissible",
              "controlled": false,
              "attributes": {
                "direction": "startToEnd",
                "dismissThresholds": {"vertical": 0.3},
              },
              "children": [
                {
                  "type": "Container",
                  "id": "content",
                  "controlled": false,
                  "attributes": {"width": 100, "height": 50},
                },
              ],
            },
          ],
        });
        final dismissible = tester.widget<Dismissible>(
          find.byKey(const ValueKey("dismissible")),
        );
        expect(
          dismissible.dismissThresholds,
          containsPair(DismissDirection.vertical, 0.3),
        );
      });

      testWidgets("must parse horizontal threshold", (tester) async {
        await _pumpDriver(tester, {
          "type": "Column",
          "id": "column",
          "controlled": false,
          "children": [
            {
              "type": "Dismissible",
              "id": "dismissible",
              "controlled": false,
              "attributes": {
                "direction": "startToEnd",
                "dismissThresholds": {"horizontal": 0.4},
              },
              "children": [
                {
                  "type": "Container",
                  "id": "content",
                  "controlled": false,
                  "attributes": {"width": 100, "height": 50},
                },
              ],
            },
          ],
        });
        final dismissible = tester.widget<Dismissible>(
          find.byKey(const ValueKey("dismissible")),
        );
        expect(
          dismissible.dismissThresholds,
          containsPair(DismissDirection.horizontal, 0.4),
        );
      });

      testWidgets("must parse up threshold", (tester) async {
        await _pumpDriver(tester, {
          "type": "Column",
          "id": "column",
          "controlled": false,
          "children": [
            {
              "type": "Dismissible",
              "id": "dismissible",
              "controlled": false,
              "attributes": {
                "direction": "startToEnd",
                "dismissThresholds": {"up": 0.5},
              },
              "children": [
                {
                  "type": "Container",
                  "id": "content",
                  "controlled": false,
                  "attributes": {"width": 100, "height": 50},
                },
              ],
            },
          ],
        });
        final dismissible = tester.widget<Dismissible>(
          find.byKey(const ValueKey("dismissible")),
        );
        expect(
          dismissible.dismissThresholds,
          containsPair(DismissDirection.up, 0.5),
        );
      });

      testWidgets("must parse down threshold", (tester) async {
        await _pumpDriver(tester, {
          "type": "Column",
          "id": "column",
          "controlled": false,
          "children": [
            {
              "type": "Dismissible",
              "id": "dismissible",
              "controlled": false,
              "attributes": {
                "direction": "startToEnd",
                "dismissThresholds": {"down": 0.6},
              },
              "children": [
                {
                  "type": "Container",
                  "id": "content",
                  "controlled": false,
                  "attributes": {"width": 100, "height": 50},
                },
              ],
            },
          ],
        });
        final dismissible = tester.widget<Dismissible>(
          find.byKey(const ValueKey("dismissible")),
        );
        expect(
          dismissible.dismissThresholds,
          containsPair(DismissDirection.down, 0.6),
        );
      });

      testWidgets("must parse endToStart threshold", (tester) async {
        await _pumpDriver(tester, {
          "type": "Column",
          "id": "column",
          "controlled": false,
          "children": [
            {
              "type": "Dismissible",
              "id": "dismissible",
              "controlled": false,
              "attributes": {
                "direction": "startToEnd",
                "dismissThresholds": {"endToStart": 0.7},
              },
              "children": [
                {
                  "type": "Container",
                  "id": "content",
                  "controlled": false,
                  "attributes": {"width": 100, "height": 50},
                },
              ],
            },
          ],
        });
        final dismissible = tester.widget<Dismissible>(
          find.byKey(const ValueKey("dismissible")),
        );
        expect(
          dismissible.dismissThresholds,
          containsPair(DismissDirection.endToStart, 0.7),
        );
      });

      testWidgets("must parse none threshold", (tester) async {
        await _pumpDriver(tester, {
          "type": "Column",
          "id": "column",
          "controlled": false,
          "children": [
            {
              "type": "Dismissible",
              "id": "dismissible",
              "controlled": false,
              "attributes": {
                "direction": "startToEnd",
                "dismissThresholds": {"none": 0.8},
              },
              "children": [
                {
                  "type": "Container",
                  "id": "content",
                  "controlled": false,
                  "attributes": {"width": 100, "height": 50},
                },
              ],
            },
          ],
        });
        final dismissible = tester.widget<Dismissible>(
          find.byKey(const ValueKey("dismissible")),
        );
        expect(
          dismissible.dismissThresholds,
          containsPair(DismissDirection.none, 0.8),
        );
      });

      testWidgets("must parse multiple dismiss thresholds", (tester) async {
        await _pumpDriver(tester, {
          "type": "Column",
          "id": "column",
          "controlled": false,
          "children": [
            {
              "type": "Dismissible",
              "id": "dismissible",
              "controlled": false,
              "attributes": {
                "direction": "startToEnd",
                "dismissThresholds": {
                  "vertical": 0.3,
                  "horizontal": 0.4,
                  "up": 0.5,
                  "down": 0.6,
                  "startToEnd": 0.7,
                  "endToStart": 0.8,
                  "none": 0.9,
                },
              },
              "children": [
                {
                  "type": "Container",
                  "id": "content",
                  "controlled": false,
                  "attributes": {"width": 100, "height": 50},
                },
              ],
            },
          ],
        });
        final dismissible = tester.widget<Dismissible>(
          find.byKey(const ValueKey("dismissible")),
        );
        expect(dismissible.dismissThresholds, {
          DismissDirection.vertical: 0.3,
          DismissDirection.horizontal: 0.4,
          DismissDirection.up: 0.5,
          DismissDirection.down: 0.6,
          DismissDirection.startToEnd: 0.7,
          DismissDirection.endToStart: 0.8,
          DismissDirection.none: 0.9,
        });
      });
    });
  });
}
