import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> widget = {
  "type": "GestureDetector",
  "id": "test_gesture_detector",
  "controlled": true,
  "child": {
    "type": "Text",
    "controlled": true,
    "id": "target_text",
    "attributes": {
      "data": "Hello, world!",
    },
  },
  "attributes": {
    "onTap": {
      "executionType": 1, //local
      "event": "local_exec",
      "payload": {
        "type": "update",
        "updates": {
          "target_text": {
            "data": "onTap",
          },
        },
      },
    },
    "onLongPress": {
      "executionType": 1, //local
      "event": "local_exec",
      "payload": {
        "type": "update",
        "updates": {
          "target_text": {
            "data": "onLongPress",
          },
        },
      },
    },
  },
};

void main() {
  group(
    "DuitGestureDetector tests",
    () {
      testWidgets(
        "must perform actions as expected",
        (tester) async {
          final driver = DuitDriver.static(
            widget,
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          var target = find.text("Hello, world!");

          expect(find.text("Hello, world!"), findsOneWidget);

          await tester.tap(target);
          await tester.pumpAndSettle();

          target = find.text("onTap");

          expect(target, findsOneWidget);

          await tester.longPress(target);
          await tester.pumpAndSettle();

          expect(find.text("onLongPress"), findsOneWidget);
        },
      );
    },
  );
}
