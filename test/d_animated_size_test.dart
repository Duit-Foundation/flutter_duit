import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets(
    "DuitAnimatedSize must renders correctly",
    (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "AnimatedSize",
          "id": "rotation",
          "attributes": {
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
      expect(find.byType(AnimatedSize), findsOneWidget);
      expect(find.text("Some text"), findsOneWidget);
    },
  );
}
