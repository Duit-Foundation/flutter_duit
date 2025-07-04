import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

final _t1 = <String, dynamic>{
  "type": "Text",
  "id": "tfgdfg1",
  "controlled": true,
  "attributes": {"data": "Text 1"}
};

final _t2 = <String, dynamic>{
  "type": "Text",
  "id": "fgfgfbcb",
  "controlled": false,
  "attributes": {"data": "Text 2"}
};

Map<String, dynamic> _createWidget() {
  return {
    "type": "Column",
    "attributes": {},
    "controlled": false,
    "id": "col",
    "children": [
      {
        "type": "ElevatedButton",
        "id": "button1",
        "controlled": true,
        "action": {
          "executionType": 1, //local
          "event": "local_exec",
          "payload": {
            "type": "update",
            "updates": {
              "subtree": _t1,
            }
          }
        },
        "attributes": {
          "autofocus": false,
        },
        "child": {
          "type": "Text",
          "id": "t1dvv",
          "controlled": true,
          "attributes": {
            "data": "Press me!",
            "style": {
              "fontSize": 12.0,
              "fontWeight": 400,
            }
          },
        }
      },
      {
        "type": "ElevatedButton",
        "id": "button2",
        "controlled": true,
        "action": {
          "executionType": 1, //local
          "event": "local_exec",
          "payload": {
            "type": "update",
            "updates": {
              "subtree": _t2,
            }
          }
        },
        "attributes": {
          "autofocus": false,
        },
        "child": {
          "type": "Text",
          "id": "vssww",
          "controlled": true,
          "attributes": {
            "data": "Press me!",
            "style": {
              "fontSize": 12.0,
              "fontWeight": 400,
            }
          },
        }
      },
      {
        "type": "Subtree",
        "id": "subtree",
        "controlled": true,
        "attributes": {},
        "child": {"type": "Empty", "id": "t1x", "attributes": {}}
      }
    ]
  };
}

void main() {
  group(
    "DuitSubtree widget tests",
    () {
      testWidgets(
        "Check subtree content changed correctly after toggle",
        (tester) async {
          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget(),
                  transportOptions: EmptyTransportOptions(),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final button1 = find.byKey(const Key("button1"));
          final button2 = find.byKey(const Key("button2"));

          expect(button1, findsOneWidget);
          expect(button2, findsOneWidget);
          expect(find.text("Text 1"), findsNothing);

          await tester.tap(button2);
          await tester.pumpAndSettle();

          expect(find.text("Text 2"), findsOneWidget);

          await tester.tap(button1);
          await tester.pumpAndSettle();
          await tester.tap(button2);
          await tester.pumpAndSettle();
          await tester.tap(button1);
          await tester.pumpAndSettle();

          expect(find.text("Text 1"), findsOneWidget);
        },
      );
    },
  );
}
