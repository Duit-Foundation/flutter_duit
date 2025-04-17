import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets(
    "DuitAnimatedRotation must renders correctly",
    (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "AnimatedRotation",
          "id": "rotation",
          "attributes": {
            "turns": 1,
            "duration": 100,
          },
          "child": {
            "type": "Text",
            "id": "text",
            "attributes": {
              "data": "Some text",
            },
          }
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(
        tester,
        driver,
      );

      expect(find.byKey(const ValueKey("rotation")), findsOneWidget);
      expect(find.text("Some text"), findsOneWidget);
    },
  );
}
