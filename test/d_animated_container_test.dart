import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "DuitAnimatedContainer must renders correctly",
    (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "AnimatedContainer",
          "id": "cont",
          "attributes": {
            "duration": 100,
            "width": 100.0,
            "height": 100.0,
          },
          "child": {
            "type": "Text",
            "id": "text",
            "attributes": {
              "data": "Some text",
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(
        tester,
        driver,
      );

      expect(
        tester.widget(
          find.byKey(
            const ValueKey("cont"),
          ),
        ),
        isA<AnimatedContainer>(),
      );
      expect(find.byKey(const ValueKey("cont")), findsOneWidget);
    },
  );
}
