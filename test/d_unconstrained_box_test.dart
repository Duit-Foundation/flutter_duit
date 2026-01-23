import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitUnconstrainedBox tests",
    () {
      testWidgets(
        "must renders correctly with all parameters",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "UnconstrainedBox",
              "id": "ub1",
              "controlled": false,
              "attributes": {
                "alignment": "topLeft",
                "constrainedAxis": "horizontal",
                "clipBehavior": "hardEdge",
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

          final ubFinder = find.byKey(const ValueKey("ub1"));

          expect(ubFinder, findsOneWidget);

          final ub = tester.widget<UnconstrainedBox>(ubFinder);

          expect(ub.alignment, Alignment.topLeft);
          expect(ub.constrainedAxis, Axis.horizontal);
          expect(ub.clipBehavior, Clip.hardEdge);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "UnconstrainedBox",
              "id": "ub6",
              "controlled": true,
              "attributes": {
                "alignment": "center",
                "constrainedAxis": "horizontal",
                "clipBehavior": "none",
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

          expect(find.byKey(const ValueKey("ub6")), findsOneWidget);

          var ub = tester.widget<UnconstrainedBox>(
            find.byKey(const ValueKey("ub6")),
          );

          expect(ub.alignment, Alignment.center);
          expect(ub.constrainedAxis, Axis.horizontal);
          expect(ub.clipBehavior, Clip.none);

          await driver.asInternalDriver.updateAttributes(
            "ub6",
            {
              "alignment": "topRight",
              "constrainedAxis": "vertical",
              "clipBehavior": "hardEdge",
            },
          );

          await tester.pumpAndSettle();

          ub = tester.widget<UnconstrainedBox>(
            find.byKey(const ValueKey("ub6")),
          );

          expect(ub.alignment, Alignment.topRight);
          expect(ub.constrainedAxis, Axis.vertical);
          expect(ub.clipBehavior, Clip.hardEdge);
        },
      );
    },
  );
}
