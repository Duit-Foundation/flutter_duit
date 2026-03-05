import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitCheckBox tests",
    () {
      testWidgets(
        "must change value",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "CheckBox",
              "id": "box",
              "attributes": {
                "value": true,
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("box")), findsOneWidget);

          await tester.tap(find.byKey(const ValueKey("box")));

          final checkbox =
              tester.widget<Checkbox>(find.byKey(const ValueKey("box")));

          await tester.pumpAndSettle();

          expect(checkbox.value, true);
        },
      );
    },
  );
}
