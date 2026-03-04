import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitIgnodePointer tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "IgnorePointer",
              "id": "ignore",
              "controlled": false,
              "attributes": {
                "ignoring": true,
              },
              "child": {
                "type": "Container",
                "id": "cont",
                "controlled": false,
                "attributes": {
                  "width": 100,
                  "height": 100,
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("ignore")), findsOneWidget);

          final ignoreWidget = tester
              .widget<IgnorePointer>(find.byKey(const ValueKey("ignore")));

          expect(ignoreWidget.ignoring, true);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "IgnorePointer",
              "id": "ignore",
              "controlled": true,
              "attributes": {
                "ignoring": true,
              },
              "child": {
                "type": "Container",
                "id": "cont",
                "controlled": false,
                "attributes": {
                  "width": 100,
                  "height": 100,
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("ignore")), findsOneWidget);

          var ignoreWidget = tester
              .widget<IgnorePointer>(find.byKey(const ValueKey("ignore")));

          expect(ignoreWidget.ignoring, true);

          await driver.asInternalDriver.updateAttributes(
            "ignore",
            {
              "ignoring": false,
            },
          );

          await tester.pumpAndSettle();

          ignoreWidget = tester
              .widget<IgnorePointer>(find.byKey(const ValueKey("ignore")));

          expect(ignoreWidget.ignoring, false);
        },
      );
    },
  );
}
