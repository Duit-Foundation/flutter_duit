import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "DuitAnimatedPositioned must renders correctly",
    (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Stack",
          "id": "stack",
          "controlled": false,
          "attributes": <String, dynamic>{},
          "children": <Map<String, dynamic>>[
            {
              "type": "AnimatedPositioned",
              "id": "positioned",
              "attributes": {
                "left": 0,
                "top": 0,
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
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(
        tester,
        driver,
      );

      expect(find.byKey(const ValueKey("positioned")), findsOneWidget);
    },
  );
}
