import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget() {
  return {
    "type": "ElevatedButton",
    "id": "bId",
    "controlled": true,
    "action": {
      "executionType": 1, //local
      "event": "local_exec",
      "payload": {
        "type": "update",
        "updates": {
          "t1": {
            "data": "Pressed!",
            "style": <String, dynamic>{
              "fontSize": 24.0,
              "fontWeight": 800,
            },
          },
        },
      },
    },
    "attributes": {
      "autofocus": false,
      "onLongPress": {
        "executionType": 1, //local
        "event": "local_exec",
        "payload": {
          "type": "update",
          "updates": {
            "t1": {
              "data": "Long pressed!",
              "style": <String, dynamic>{
                "fontSize": 48.0,
                "fontWeight": 400,
              },
            },
          },
        },
      },
    },
    "child": {
      "type": "Text",
      "id": "t1",
      "controlled": true,
      "attributes": {
        "data": "Press me!",
        "style": <String, dynamic>{
          "fontSize": 12.0,
          "fontWeight": 400,
        },
      },
    },
  };
}

void main() {
  group(
    "DuitButton widget tests",
    () {
      testWidgets("check pressed and key assignment", (t) async {
        await t.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: XDriver.static(
                _createWidget(),
              ),
            ),
          ),
        );

        await t.pumpAndSettle();

        final button = find.byKey(const Key("bId"));

        expect(button, findsOneWidget);

        await t.tap(button);

        await t.pumpAndSettle();

        expect(find.text("Pressed!"), findsOneWidget);
      });

      testWidgets("check action execution", (tester) async {
        final driver = XDriver.static(
          _createWidget(),
        );

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: driver,
            ),
          ),
        );

        await tester.pumpAndSettle();

        final button = find.byKey(const Key("bId"));

        await tester.tap(button);

        await tester.pumpAndSettle();

        var text = find.text("Pressed!");
        expect(text, findsOneWidget);

        var widget = tester.widget<Text>(text);

        expect(widget.style?.fontWeight, equals(FontWeight.w800));
        expect(widget.style?.fontSize, equals(24.0));

        await tester.longPress(button);
        await tester.pumpAndSettle();

        text = find.text("Long pressed!");
        expect(text, findsOneWidget);

        widget = tester.widget<Text>(text);
        expect(text, findsOneWidget);
        expect(widget.style?.fontWeight, equals(FontWeight.w400));
        expect(widget.style?.fontSize, equals(48.0));
      });
    },
  );
}
