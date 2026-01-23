import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitSizedOverflowBox tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "SizedOverflowBox",
              "id": "sob1",
              "controlled": false,
              "attributes": {
                "size": {"width": 100.0, "height": 50.0},
                "alignment": "topLeft",
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": {
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final sobFinder = find.byKey(const ValueKey("sob1"));

          expect(sobFinder, findsOneWidget);

          final sob = tester.widget<SizedOverflowBox>(sobFinder);

          expect(sob.size, const Size(100.0, 50.0));
          expect(sob.alignment, Alignment.topLeft);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "SizedOverflowBox",
              "id": "sob1",
              "controlled": true,
              "attributes": {
                "size": {"width": 100.0, "height": 50.0},
                "alignment": "center",
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": {
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("sob1")), findsOneWidget);

          var sob = tester.widget<SizedOverflowBox>(
            find.byKey(const ValueKey("sob1")),
          );

          expect(sob.size, const Size(100.0, 50.0));
          expect(sob.alignment, Alignment.center);

          await driver.asInternalDriver.updateAttributes(
            "sob1",
            {
              "size": {"width": 200.0, "height": 80.0},
              "alignment": "bottomRight",
            },
          );

          await tester.pumpAndSettle();

          sob = tester.widget<SizedOverflowBox>(
            find.byKey(const ValueKey("sob1")),
          );

          expect(sob.size, const Size(200.0, 80.0));
          expect(sob.alignment, Alignment.bottomRight);
        },
      );
    },
  );
}
