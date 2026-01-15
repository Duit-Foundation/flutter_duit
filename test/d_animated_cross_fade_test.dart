import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "DuitAnimatedCrossFade must renders correctly",
    (tester) async {
      final driver = XDriver.static(
        {
          "type": "AnimatedCrossFade",
          "id": "crossfade",
          "attributes": {
            "duration": 100,
            "crossFadeState": 0,
          },
          "children": [
            {
              "type": "Text",
              "id": "text1",
              "attributes": {
                "data": "Some text",
              },
            },
            {
              "type": "Text",
              "id": "text2",
              "attributes": {
                "data": "Other text",
              },
            },
          ],
        },
      );

      await pumpDriver(
        tester, driver.asInternalDriver,
      );

      expect(find.byKey(const ValueKey("crossfade")), findsOneWidget);
      expect(find.text("Some text"), findsOneWidget);
      expect(find.text("Other text"), findsOneWidget);

      var animatedCrossFade =
          tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(animatedCrossFade.crossFadeState, CrossFadeState.showFirst);

      await driver.asInternalDriver.updateAttributes("crossfade", {
        "crossFadeState": 1,
      });

      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      animatedCrossFade =
          tester.widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade));
      expect(animatedCrossFade.crossFadeState, CrossFadeState.showSecond);
    },
  );
}
