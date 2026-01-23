import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitFractionallySizedBox tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "FractionallySizedBox",
              "id": "fsb1",
              "controlled": false,
              "attributes": {
                "widthFactor": 0.5,
                "heightFactor": 0.75,
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

          final fsbFinder = find.byKey(const ValueKey("fsb1"));

          expect(fsbFinder, findsOneWidget);

          final fsb = tester.widget<FractionallySizedBox>(fsbFinder);

          expect(fsb.widthFactor, 0.5);
          expect(fsb.heightFactor, 0.75);
          expect(fsb.alignment, Alignment.topLeft);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "FractionallySizedBox",
              "id": "fsb1",
              "controlled": true,
              "attributes": {
                "widthFactor": 0.5,
                "heightFactor": 0.75,
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

          expect(find.byKey(const ValueKey("fsb1")), findsOneWidget);

          var fsb = tester.widget<FractionallySizedBox>(
            find.byKey(const ValueKey("fsb1")),
          );

          expect(fsb.widthFactor, 0.5);
          expect(fsb.heightFactor, 0.75);
          expect(fsb.alignment, Alignment.center);

          await driver.asInternalDriver.updateAttributes(
            "fsb1",
            {
              "widthFactor": 0.8,
              "heightFactor": 0.6,
              "alignment": "topRight",
            },
          );

          await tester.pumpAndSettle();

          fsb = tester.widget<FractionallySizedBox>(
            find.byKey(const ValueKey("fsb1")),
          );

          expect(fsb.widthFactor, 0.8);
          expect(fsb.heightFactor, 0.6);
          expect(fsb.alignment, Alignment.topRight);
        },
      );
    },
  );
}
