import 'package:flutter/foundation.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets(
    "DuitAnimatedAlign must renders correctly",
    (tester) async {
      final driver = DuitDriver.static(
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
          }
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(
        tester,
        driver,
      );

      expect(find.byKey(const ValueKey("align")), findsOneWidget);
      expect(find.text("Some text"), findsOneWidget);
    },
  );
}
