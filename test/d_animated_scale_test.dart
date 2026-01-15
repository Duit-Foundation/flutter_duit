import "package:flutter/material.dart" show AnimatedScale, ValueKey;
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "DuitAnimatedScale must renders correctly",
    (tester) async {
      final driver = XDriver.static(
        {
          "type": "Stack",
          "id": "stack",
          "controlled": false,
          "attributes": <String, dynamic>{},
          "children": <Map<String, dynamic>>[
            {
              "type": "AnimatedScale",
              "id": "scale",
              "attributes": {
                "scale": 2.0,
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
          ],
        },
      );

      await pumpDriver(
        tester, driver.asInternalDriver,
      );

      expect(find.byKey(const ValueKey("scale")), findsOneWidget);
      expect(find.byType(AnimatedScale), findsOneWidget);
      expect(find.text("Some text"), findsOneWidget);
    },
  );
}
