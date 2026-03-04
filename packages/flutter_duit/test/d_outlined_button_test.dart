import "dart:ui";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget() {
  return {
    "type": "OutlinedButton",
    "id": "bId",
    "controlled": true,
    "action": LocalAction(
      event: UpdateEvent(
        updates: {
          "t1": {
            "data": "Pressed!",
            "style":
                const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
          },
        },
      ),
    ),
    "attributes": {
      "autofocus": false,
      "onLongPress": LocalAction(
        event: UpdateEvent(
          updates: {
            "t1": {
              "data": "Long pressed!",
              "style":
                  const TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400),
            },
          },
        ),
      ),
      "onFocusChange": LocalAction(
        event: UpdateEvent(
          updates: {
            "t1": {
              "data": "Focused!",
              "style":
                  const TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700),
            },
          },
        ),
      ),
      "onHover": LocalAction(
        event: UpdateEvent(
          updates: {
            "t1": {
              "data": "Hovered!",
              "style":
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            },
          },
        ),
      ),
    },
    "child": {
      "type": "Text",
      "id": "t1",
      "controlled": true,
      "attributes": {
        "data": "Press me!",
        "style": const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
      },
    },
  };
}

void main() {
  group(
    "DuitOutlinedButton widget tests",
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

      testWidgets("check onFocusChange callback", (tester) async {
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

        // Request focus on button (requestFocus is a synchronous method)
        driver.requestFocus("bId");
        await tester.pumpAndSettle();

        var text = find.text("Focused!");
        expect(text, findsOneWidget);

        var widget = tester.widget<Text>(text);
        expect(widget.style?.fontWeight, equals(FontWeight.w700));
        expect(widget.style?.fontSize, equals(32.0));
      });

      testWidgets("check onHover callback", (tester) async {
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

        // Create a mouse gesture for hover testing
        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );

        // Add pointer and move to button center
        await gesture.addPointer(location: Offset.zero);
        await tester.pumpAndSettle();

        await gesture.moveTo(tester.getCenter(button));
        await tester.pumpAndSettle();

        var text = find.text("Hovered!");
        expect(text, findsOneWidget);

        var widget = tester.widget<Text>(text);
        expect(widget.style?.fontWeight, equals(FontWeight.w600));
        expect(widget.style?.fontSize, equals(20.0));
      });
    },
  );
}
