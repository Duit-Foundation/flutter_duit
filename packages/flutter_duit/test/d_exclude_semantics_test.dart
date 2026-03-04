import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitExcludeSemantics tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "ExcludeSemantics",
              "id": "exclude1",
              "controlled": false,
              "attributes": <String, dynamic>{
                "excluding": false,
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": <String, dynamic>{
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final excludeFinder = find.byKey(const ValueKey("exclude1"));
          final childFinder = find.byKey(const ValueKey("child"));

          expect(excludeFinder, findsOneWidget);
          expect(childFinder, findsOneWidget);

          final excludeWidget = tester
              .widget<ExcludeSemantics>(find.byKey(const ValueKey("exclude1")));

          expect(excludeWidget.excluding, false);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "ExcludeSemantics",
              "id": "exclude4",
              "controlled": true,
              "attributes": <String, dynamic>{
                "excluding": true,
              },
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": <String, dynamic>{
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          expect(find.byKey(const ValueKey("exclude4")), findsOneWidget);

          var excludeWidget = tester
              .widget<ExcludeSemantics>(find.byKey(const ValueKey("exclude4")));

          expect(excludeWidget.excluding, true);

          await driver.asInternalDriver.updateAttributes(
            "exclude4",
            {
              "excluding": false,
            },
          );

          await tester.pumpAndSettle();

          excludeWidget = tester
              .widget<ExcludeSemantics>(find.byKey(const ValueKey("exclude4")));

          expect(excludeWidget.excluding, false);
        },
      );
    },
  );
}
