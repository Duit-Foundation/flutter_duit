import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitSwitch tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Switch",
              "id": "sw1",
              "controlled": true,
              "attributes": {"value": false},
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final swFinder = find.byKey(const ValueKey("sw1"));

          expect(swFinder, findsOneWidget);

          final sw = tester.widget<Switch>(swFinder);

          expect(sw.value, false);
        },
      );

      testWidgets(
        "must update value",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Switch",
              "id": "sw1",
              "controlled": true,
              "attributes": {"value": false},
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("sw1")), findsOneWidget);

          var sw = tester.widget<Switch>(find.byKey(const ValueKey("sw1")));

          expect(sw.value, false);

          // Эмулируем пользовательский tap по Switch
          await tester.tap(find.byKey(const ValueKey("sw1")));
          await tester.pumpAndSettle();

          sw = tester.widget<Switch>(find.byKey(const ValueKey("sw1")));

          expect(sw.value, true);
        },
      );
    },
  );
}
