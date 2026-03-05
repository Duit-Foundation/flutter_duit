import "package:flutter/foundation.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "DuitAnimatedAlign must renders correctly",
    (tester) async {
      final driver = XDriver.static(
        {
          "type": "AnimatedAlign",
          "id": "align",
          "attributes": {
            "alignment": "bottomRight",
            "duration": 100,
          },
          "child": {
            "type": "Text",
            "id": "text",
            "attributes": {
              "data": "Some text",
            },
          },
        },
      );

      await pumpDriver(
        tester, driver.asInternalDriver,
      );

      expect(find.byKey(const ValueKey("align")), findsOneWidget);
      expect(find.text("Some text"), findsOneWidget);
    },
  );

  testWidgets("DuitAnimatedAlign must call onEnd", (tester) async {
    final driver = XDriver.static(
      {
        "type": "AnimatedAlign",
        "id": "align",
        "attributes": {
          "alignment": "bottomRight",
          "duration": 100,
          "onEnd": {
            "executionType": 1, //local
            "event": "local_exec",
            "payload": {
              "type": "update",
              "updates": {
                "text": {
                  "data": "END",
                },
              },
            },
          },
        },
        "child": {
          "type": "Text",
          "id": "text",
          "controlled": true,
          "attributes": {
            "data": "Some text",
          },
        },
      },
    );

    await pumpDriver(
      tester, driver.asInternalDriver,
    );

    await driver.asInternalDriver.updateAttributes("align", {
      "alignment": "bottomLeft",
    });

    await tester.pumpAndSettle();

    expect(find.text("END"), findsOneWidget);
  });
}
