import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "DuitAnimatedPadding must renders correctly",
    (tester) async {
      final driver = XDriver.static(
        {
          "type": "AnimatedPadding",
          "id": "padding",
          "attributes": {
            "padding": [
              12,
              12,
              12,
              12,
            ],
            "duration": 1000,
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

      expect(find.byKey(const ValueKey("padding")), findsOneWidget);
      expect(find.text("Some text"), findsOneWidget);
    },
  );
}
